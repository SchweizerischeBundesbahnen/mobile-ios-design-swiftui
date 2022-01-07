//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI
import Foundation

struct TabBarShape: Shape {
    // Shape of the tabBar
    private var selectedTab: Int
    private var nbTabs: Int
    
    public init(selectedTab: Int, nbTabs: Int) {
        self.selectedTab = selectedTab
        self.nbTabs = nbTabs
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let bottomLeftCorner = CGPoint(x: rect.minX, y: rect.maxY)
        let topLeftCorner = CGPoint(x: rect.minX, y: rect.minY)
        let topRightCorner = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRightCorner = CGPoint(x: rect.maxX, y: rect.maxY)
        
        let tabWidth: CGFloat = segmentWidth(parentWidth: rect.width, nbTabs: self.nbTabs)
        let offset: CGFloat = tabWidth * CGFloat(selectedTab)
        
        let factor: CGFloat = tabWidth * 0.1
        
        // First curve on the left
        let startLeftCurve = CGPoint(x: offset - tabWidth / 2 + factor, y: rect.minY)
        let endLeftCurve = CGPoint(x: offset + factor, y: tabWidth / 2)
        let controlLeft = CGPoint(x: offset + factor, y: rect.minY)
        // Middle curve
        let endMiddleCurve = CGPoint(x: offset + tabWidth - factor, y: tabWidth / 2 )
        let control1Middle = CGPoint(x: offset + factor, y: tabWidth)
        let control2Middle = CGPoint(x: offset + tabWidth - factor, y: tabWidth)
        // Right curve
        let endRightCurve = CGPoint(x: offset + (tabWidth * 3/2) - factor, y: rect.minY)
        let controlRight = CGPoint(x: offset + tabWidth - factor, y: rect.minY)
        
        // Start bottom left corner
        path.move(to: bottomLeftCorner)
        // Draw lines to start of the left curve
        path.addLines([bottomLeftCorner, topLeftCorner, startLeftCurve])
        // Draw left curve
        path.addQuadCurve(to: endLeftCurve, control: controlLeft)
        // Draw middle curve
        path.addCurve(to: endMiddleCurve, control1: control1Middle, control2: control2Middle)
        // Draw right curve
        path.addQuadCurve(to: endRightCurve, control: controlRight)
        // Add lines to complete path
        path.addLines([endRightCurve, topRightCorner, bottomRightCorner, bottomLeftCorner])
        
        return path
    }
}

public struct TabBarEntryView: View {
    // The information needed for each tab: content, image, label and tag
    var contentView: AnyView
    var imageView: Image = Image(sbbName: "cross", size: .small)
    var labelView: Text = Text("_")
    var tag: Any?
    
    public init(contentView: AnyView, imageView: Image, labelView: Text, tag: Any) {
        self.contentView = contentView
        self.imageView = imageView
        self.labelView = labelView
        self.tag = tag
    }
    
    public init(contentView: AnyView, imageView: Image, labelView: Text) {
        self.contentView = contentView
        self.imageView = imageView
        self.labelView = labelView
    }
    
    public init(contentView: AnyView, tag: Any) {
        self.contentView = contentView
        self.tag = tag
    }
    
    public init(contentView: AnyView) {
        self.contentView = contentView
    }
    
    public var body: some View {
        self.contentView
    }
}

public struct SBBTabView<Selection>: View where Selection: Hashable {
    
    @Binding private var selection: Selection
    private let contents: [TabBarEntryView]
    private var selectionIndex: Int {
        for index in (0...self.contents.count) {
            // Some tab may not have a label
            if let tag = self.contents[index].tag {
                if (tag as! Selection == selection) {
                    return index
                }
            }
        }
        return 0
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    public init<Views>(selection: Binding<Selection>, @ViewBuilder content: () -> TupleView<Views>) {
        self._selection = selection
        // Content must have at least 2 views to work (Tuple)
        self.contents = content().getTabViews
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let segmentWidth = segmentWidth(parentWidth: geometry.size.width, nbTabs: self.contents.count)
            VStack(spacing: 0) {
                // Content of the tab
                self.contents[self.selectionIndex].contentView
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                ZStack {
                    // Tab bar shape
                    TabBarShape(selectedTab: self.selectionIndex, nbTabs: self.contents.count)
                        .shadow(color: Color.sbbColor(.smoke), radius: self.colorScheme == .light ? 10 : 0, x: 0, y: 0)
                    
                    // Icons in a row
                    HStack(spacing: 0) {
                        ForEach(0..<self.contents.count) { index in
                            Button(action: {
                                self.selection = self.contents[index].tag as? Selection ?? self.selection
                            }) {
                                if (index == self.selectionIndex) {
                                    Circle()
                                        .frame(width: segmentWidth * 0.65)
                                        .overlay(self.contents[index].imageView.colorInvert())
                                } else {
                                    self.contents[index].imageView
                                }
                            }
                        }
                        .sbbFont(.body)
                        .foregroundColor(Color.sbbColor(.textBlack))
                        .frame(width: segmentWidth, height: segmentWidth * 0.8)
                    }
                    .padding(.top, 3)
                    .frame(height: segmentWidth * 1.3, alignment: .top)
                    
                    // Current tab title
                    self.contents[self.selectionIndex].labelView
                        .sbbFont(.legend)
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .foregroundColor(Color.sbbColor(.textBlack))
                        .padding(.bottom, 15)
                        .frame(width: segmentWidth, alignment: .center)
                        .offset(x: segmentWidth * CGFloat(self.selectionIndex))
                        .frame(width: geometry.size.width, alignment: .leading)
                        .frame(height: segmentWidth * 1.3, alignment: .bottom)
                }
                .frame(height: segmentWidth * 1.3)
                .foregroundColor(Color.sbbColor(.tabViewBackground))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.sbbColor(.background))
    }
    
    private func buildTags() -> [Selection] {
        var temp = Array<Selection>()
        for index in (0...self.contents.count) {
            temp.append(self.contents[index].tag as! Selection)
        }
        return temp
    }
}

extension View {
    public func sbbTabItem(image: Image, label: Text) -> TabBarEntryView {
        if let content = getTabBarEntryContent(val: self) {
            if let tag = content.tag {
                return TabBarEntryView(contentView: AnyView(content.contentView), imageView: image, labelView: label, tag: tag)
            }
            return TabBarEntryView(contentView: AnyView(content.contentView), imageView: image, labelView: label)
        }
        return TabBarEntryView(contentView: AnyView(self), imageView: image, labelView: label)
    }
    
    
    public func sbbTag<V>(_ tag: V) -> TabBarEntryView where V : Hashable {
        if let content = getTabBarEntryContent(val: self) {
            return TabBarEntryView(contentView: content.contentView, imageView: content.imageView, labelView: content.labelView, tag: tag)
        }
        
        return TabBarEntryView(contentView: AnyView(self), tag: tag)
    }
}

extension TupleView {
    
    var getTabViews: [TabBarEntryView] {
        makeArrayTabViews(from: value)
    }
    
    private struct GenericView {
        let body: Any
        
        var tabEntryView: TabBarEntryView? {
            if let content = getTabBarEntryContent(val: body) {
                if let tag = content.tag {
                    return TabBarEntryView(contentView: content.contentView, imageView: content.imageView, labelView: content.labelView, tag: tag)
                }
                return TabBarEntryView(contentView: content.contentView, imageView: content.imageView, labelView: content.labelView)
            }
            let bodyView = AnyView(_fromValue: body)
            return TabBarEntryView(contentView: bodyView!)
        }
    }
    
    private func makeArrayTabViews<Tuple>(from tuple: Tuple) -> [TabBarEntryView] {
        func convert(child: Mirror.Child) -> TabBarEntryView? {
            // Get a child view and convert it to TabBarEntryView
            withUnsafeBytes(of: child.value) { ptr -> TabBarEntryView? in
                let binded = ptr.bindMemory(to: GenericView.self)
                
                return binded.first?.tabEntryView
            }
        }
        
        let tupleMirror = Mirror(reflecting: tuple)
        return tupleMirror.children.compactMap(convert)
    }
}

private func segmentWidth(parentWidth: CGFloat, nbTabs: Int) -> CGFloat {
    return parentWidth / CGFloat(nbTabs)
}

private func getTabBarEntryContent<V>(val: V) -> TabBarEntryView? {
    if let temp = val as? TabBarEntryView {
        return temp
    } else if let temp = val as? ModifiedContent<TabBarEntryView, _IdentifiedModifier<__DesignTimeSelectionIdentifier>> {
        return temp.content
    }
    return nil
}

struct SBBTabView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let tab: Int = 0
            
            SBBTabView(selection: .constant(tab)) {
                VStack {
                    Text("Bahnhof")
                    Image(sbbName: "station", size:.small)
                }
                .sbbTag(0)
                .sbbTabItem(
                    image: Image(sbbName: "station", size:.small),
                    label: Text("Bahnhof")
                )
                
                VStack {
                    Text("Haltestelle")
                    Image(sbbName: "bus-stop", size:.small)
                }
                .sbbTag(1)
                .sbbTabItem(
                    image: Image(sbbName: "bus-stop", size:.small),
                    label: Text("Haltestelle")
                )
                
                VStack {
                    Text("Unterwegs")
                    Image(sbbName: "train", size:.small)
                }
                .sbbTag(2)
                .sbbTabItem(
                    image: Image(sbbName: "train", size:.small),
                    label: Text("Unterwegs")
                )
                
                VStack {
                    Text("Türknopf")
                    Image(sbbName: "fullscreen", size:.small)
                }
                .sbbTag(3)
                .sbbTabItem(
                    image: Image(sbbName: "fullscreen", size:.small),
                    label: Text("Türknopf")
                )
                
                VStack {
                    Text("Einstellungen")
                    Image(sbbName: "gears", size:.small)
                }
                .sbbTag(4)
                .sbbTabItem(
                    image: Image(sbbName: "gears", size:.small),
                    label: Text("Einstellungen")
                )
            }
            .previewDisplayName("Light")
            
            SBBTabView(selection: .constant(tab)) {
                VStack {
                    Text("Bahnhof")
                    Image(sbbName: "station", size:.small)
                }
                .sbbTag(0)
                .sbbTabItem(
                    image: Image(sbbName: "station", size:.small),
                    label: Text("Bahnhof")
                )
                
                VStack {
                    Text("Haltestelle")
                    Image(sbbName: "bus-stop", size:.small)
                }
                .sbbTag(1)
                .sbbTabItem(
                    image: Image(sbbName: "bus-stop", size:.small),
                    label: Text("Haltestelle")
                )
                
                VStack {
                    Text("Unterwegs")
                    Image(sbbName: "train", size:.small)
                }
                .sbbTag(2)
                .sbbTabItem(
                    image: Image(sbbName: "train", size:.small),
                    label: Text("Unterwegs")
                )
                
                VStack {
                    Text("Türknopf")
                    Image(sbbName: "fullscreen", size:.small)
                }
                .sbbTag(3)
                .sbbTabItem(
                    image: Image(sbbName: "fullscreen", size:.small),
                    label: Text("Türknopf")
                )
                
                VStack {
                    Text("Einstellungen")
                    Image(sbbName: "gears", size:.small)
                }
                .sbbTag(4)
                .sbbTabItem(
                    image: Image(sbbName: "gears", size:.small),
                    label: Text("Einstellungen")
                )
            }
            .previewDisplayName("Dark")
            .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
