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
    // The information needed for each tab: content, icon, title and label
    var contentView: AnyView
    var iconView: AnyView = AnyView(Image(sbbName: "cross", size: .small))
    var titleView: AnyView = AnyView(Text("_"))
    var label: Any?
    
    public init(contentView: AnyView, iconView: AnyView, titleView: AnyView, label: Any) {
        self.contentView = contentView
        self.iconView = iconView
        self.titleView = titleView
        self.label = label
    }
    
    public init(contentView: AnyView, iconView: AnyView, titleView: AnyView) {
        self.contentView = contentView
        self.iconView = iconView
        self.titleView = titleView
    }
    
    public init(contentView: AnyView, label: Any) {
        self.contentView = contentView
        self.label = label
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
            if let label = self.contents[index].label {
                if (label as! Selection == selection) {
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
            VStack {
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
                                self.selection = self.contents[index].label as? Selection ?? self.selection
                            }) {
                                if (index == self.selectionIndex) {
                                    Circle()
                                        .frame(width: segmentWidth * 0.65)
                                        .overlay(self.contents[index].iconView.colorInvert())
                                } else {
                                    self.contents[index].iconView
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
                    VStack {
                        self.contents[self.selectionIndex].titleView
                            .sbbFont(.legend)
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                            .frame(width: segmentWidth, alignment: .center)
                            .offset(x: segmentWidth * CGFloat(self.selectionIndex))
                    }
                    .foregroundColor(Color.sbbColor(.textBlack))
                    .padding(.bottom, 15)
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
            temp.append(self.contents[index].label as! Selection)
        }
        return temp
    }
}

extension View {
    public func sbbTabItem<Views>(@ViewBuilder content: () -> TupleView<Views>) -> TabBarEntryView {
        // Content must have at least 2 views to work (Tuple) - the additional views are ignored here
        let views = content().getViews
        
        if let content = getTabBarEntryContent(val: self) {
            if let label = content.label {
                return TabBarEntryView(contentView: AnyView(content.contentView), iconView: views[0], titleView: views[1], label: label)
            }
            return TabBarEntryView(contentView: AnyView(content.contentView), iconView: views[0], titleView: views[1])
        }
        return TabBarEntryView(contentView: AnyView(self), iconView: views[0], titleView: views[1])
    }
    
    
    public func sbbTag<V>(_ tag: V) -> TabBarEntryView where V : Hashable {
        if let content = getTabBarEntryContent(val: self) {
            return TabBarEntryView(contentView: content.contentView, iconView: content.iconView, titleView: content.titleView, label: tag)
        }
        
        return TabBarEntryView(contentView: AnyView(self), label: tag)
    }
}

extension TupleView {
    
    var getTabViews: [TabBarEntryView] {
        makeArrayTabViews(from: value)
    }
    
    var getViews: [AnyView] {
        makeArray(from: value)
    }
    
    private struct GenericView {
        let body: Any
        
        var tabEntryView: TabBarEntryView? {
            if let content = getTabBarEntryContent(val: body) {
                if let label = content.label {
                    return TabBarEntryView(contentView: content.contentView, iconView: content.iconView, titleView: content.titleView, label: label)
                }
                return TabBarEntryView(contentView: content.contentView, iconView: content.iconView, titleView: content.titleView)
            }
            let bodyView = AnyView(_fromValue: body)
            return TabBarEntryView(contentView: bodyView!)
        }
        
        var anyView: AnyView? {
            return AnyView(_fromValue: body)
        }
    }
    
    private func makeArrayTabViews<Tuple>(from tuple: Tuple) -> [TabBarEntryView] {
        func convert(child: Mirror.Child) -> TabBarEntryView? {
            withUnsafeBytes(of: child.value) { ptr -> TabBarEntryView? in
                let binded = ptr.bindMemory(to: GenericView.self)
                
                return binded.first?.tabEntryView
            }
        }
        
        let tupleMirror = Mirror(reflecting: tuple)
        return tupleMirror.children.compactMap(convert)
    }
    
    private func makeArray<Tuple>(from tuple: Tuple) -> [AnyView] {
        func convert(child: Mirror.Child) -> AnyView? {
            // Get a child view and convert it to AnyView
            withUnsafeBytes(of: child.value) { ptr -> AnyView? in
                let binded = ptr.bindMemory(to: GenericView.self)
                
                return binded.first?.anyView
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
            let tab: Int = 1
            
            SBBTabView(selection: .constant(tab)) {
                VStack {
                    Text("Bahnhof")
                    Image(sbbName: "station", size:.small)
                }
                .sbbTag(0)
                .sbbTabItem{
                    Image(sbbName: "station", size:.small)
                    Text("Bahnhof")
                }
                
                VStack {
                    Text("Haltestelle")
                    Image(sbbName: "bus-stop", size:.small)
                }
                .sbbTag(1)
                .sbbTabItem{
                    Image(sbbName: "bus-stop", size:.small)
                    Text("Haltestelle")
                }
                
                VStack {
                    Text("Unterwegs")
                    Image(sbbName: "train", size:.small)
                }
                .sbbTag(2)
                .sbbTabItem{
                    Image(sbbName: "train", size:.small)
                    Text("Unterwegs")
                }
                
                VStack {
                    Text("Türknopf")
                    Image(sbbName: "fullscreen", size:.small)
                }
                .sbbTag(3)
                .sbbTabItem{
                    Image(sbbName: "fullscreen", size:.small)
                    Text("Türknopf")
                }
                
                VStack {
                    Text("Einstellungen")
                    Image(sbbName: "gears", size:.small)
                }
                .sbbTabItem{
                    Image(sbbName: "gears", size:.small)
                    Text("Einstellungen")
                }
                
            }
            .previewDisplayName("Light")
            
            SBBTabView(selection: .constant(tab)) {
                VStack {
                    Text("Bahnhof")
                    Image(sbbName: "station", size:.small)
                }
                .sbbTag(0)
                .sbbTabItem{
                    Image(sbbName: "station", size:.small)
                    Text("Bahnhof")
                }
                
                VStack {
                    Text("Haltestelle")
                    Image(sbbName: "bus-stop", size:.small)
                }
                .sbbTag(1)
                .sbbTabItem{
                    Image(sbbName: "bus-stop", size:.small)
                    Text("Haltestelle")
                }
                
                VStack {
                    Text("Unterwegs")
                    Image(sbbName: "train", size:.small)
                }
                .sbbTag(2)
                .sbbTabItem{
                    Image(sbbName: "train", size:.small)
                    Text("Unterwegs")
                }
                
                VStack {
                    Text("Türknopf")
                    Image(sbbName: "fullscreen", size:.small)
                }
                .sbbTag(3)
                .sbbTabItem{
                    Image(sbbName: "fullscreen", size:.small)
                    Text("Türknopf")
                }
                
                VStack {
                    Text("Einstellungen")
                    Image(sbbName: "gears", size:.small)
                }
                .sbbTag(4)
                .sbbTabItem{
                    Image(sbbName: "gears", size:.small)
                    Text("Einstellungen")
                }
                
            }
            .previewDisplayName("Dark")
            .environment(\.colorScheme, .dark)
            
            
            TabView(selection: .constant(tab)) {
                VStack {
                    Text("Bahnhof")
                    Image(sbbName: "station", size:.small)
                }
                .tag(0)
                .tabItem{
                    Image(sbbName: "station", size:.small)
                    Text("Bahnhof")
                }
                
                VStack {
                    Text("Haltestelle")
                    Image(sbbName: "bus-stop", size:.small)
                }
                .tag(1)
                .tabItem{
                    Image(sbbName: "bus-stop", size:.small)
                    Text("Haltestelle")
                }
                
                VStack {
                    Text("Unterwegs")
                    Image(sbbName: "train", size:.small)
                }
                .tag(2)
                .tabItem{
                    Image(sbbName: "train", size:.small)
                    Text("Unterwegs")
                }
                
                VStack {
                    Text("Türknopf")
                    Image(sbbName: "fullscreen", size:.small)
                }
                .tag(3)
                .tabItem{
                    Image(sbbName: "fullscreen", size:.small)
                    Text("Türknopf")
                }
                
                VStack {
                    Text("Einstellungen")
                    Image(sbbName: "gears", size:.small)
                }
                .tag(4)
                .tabItem{
                    Image(sbbName: "gears", size:.small)
                    Text("Einstellungen")
                }
            }
            .previewDisplayName("Light")
        }.previewLayout(.sizeThatFits)
    }
}

