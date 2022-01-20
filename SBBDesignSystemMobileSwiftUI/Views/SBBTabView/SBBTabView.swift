//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI
import Foundation

/**
 A View that is used to display a tab bar.
 */
public struct SBBTabView<Selection>: View where Selection: Hashable {
    @Binding private var selection: Selection
    private let contents: [TabBarEntryView]
    private let circleSize: CGFloat
    private let barHeight: CGFloat
    private let bottomOffset: CGFloat
    @State private var textSize: CGSize = .zero
    @State private var transitionFactor: CGFloat = 1.0
    @State private var transitionFactorPressed: CGFloat = 1.0
    @State private var currentTab: Int = -1
    @State private var isPressed: Bool = false
    @State private var tabBarHidden: Bool = false
    private var selectionIndex: Int {
        for index in (0...self.contents.count) {
            // Some tab may not have a label
            if let tag = self.contents[index].tag {
                if let tagValue = tag as? Selection {
                    if tagValue == selection {
                        return index
                    }
                }
            }
        }
        return 0
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    public init<Views>(selection: Binding<Selection>, circleSize: CGFloat = 44, @ViewBuilder content: () -> TupleView<Views>) {
        self._selection = selection
        // Content must have at least 2 views to work (Tuple)
        self.contents = content().getTabViews
        self.circleSize = circleSize
        self.barHeight = circleSize * 3
        self.bottomOffset = circleSize * 3 - 100
    }
    
    private func segmentWidth(parentWidth: CGFloat, nbTabs: Int) -> CGFloat {
        return parentWidth / CGFloat(nbTabs)
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let segmentWidth = self.segmentWidth(parentWidth: geometry.size.width, nbTabs: self.contents.count)
            
            ZStack(alignment: .bottom) {
                // Content of the tab
                self.contents[self.selectionIndex].contentView
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                
                if !self.tabBarHidden {
                    ZStack(alignment: .bottom) {
                        // Circles behind the bar
                        HStack(spacing: 0) {
                            ForEach(0..<self.contents.count) { index in
                                Circle()
                                    .overlay(self.contents[index].imageView.colorInvert())
                                    .frame(width: self.circleSize, height: self.circleSize)
                                    .padding(.top, 8)
                                    .accessibilityHidden(true)
                            }
                            .frame(width: segmentWidth, height: barHeight, alignment: .top)
                        }
                        
                        // Tab bar shape
                        TabBarShape(destTab: self.selectionIndex, currentTab: self.currentTab, nbTabs: self.contents.count, circleSize: self.circleSize, segmentWidth: segmentWidth, circlePad: 6, heightDiff: 2, transitionFactor: self.transitionFactor, transitionFactorPressed: self.transitionFactorPressed, isPressed: self.isPressed)
                            .foregroundColor(Color.sbbColor(.tabViewBackground))
                        
                        // Current tab title
                        self.contents[self.selectionIndex].labelView
                            .accessibility(hidden: true)
                            .background(ViewGeometry())
                            .onPreferenceChange(ViewSizeKey.self) {
                                self.textSize = $0
                            }
                            .sbbFont(.body)
                            .lineLimit(1)
                            .minimumScaleFactor(0.1)
                            .foregroundColor(Color.sbbColor(.textBlack))
                            .padding(.top, 58)
                            .offset(x: self.getOffset(selectionIndex: self.selectionIndex, textWidth: self.textSize.width, segmentWidth: segmentWidth))
                            .frame(width: geometry.size.width, alignment: .leading)
                            .frame(height: self.barHeight, alignment: .topLeading)
                        
                        HStack(spacing: 0) {
                            ForEach(0..<self.contents.count) { index in
                                Button(action: {
                                    currentTab = self.selectionIndex
                                    self.selection = self.contents[index].tag as? Selection ?? self.selection
                                    
                                    if self.selectionIndex != currentTab && !isPressed {
                                        self.transitionFactor = 0.2
                                        withAnimation(Animation.easeIn(duration: 0.2)) {
                                            self.transitionFactor = 1
                                        }
                                    }
                                }) {
                                    self.contents[index].imageView
                                        .frame(width: 56, height: 58)
                                }
                                .simultaneousGesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged({ _ in
                                            if !self.isPressed {
                                                self.isPressed = true
                                                self.currentTab = index
                                                self.transitionFactorPressed = 0
                                                withAnimation(Animation.easeIn(duration: 0.2)) {
                                                    self.transitionFactorPressed = 1
                                                }
                                            }
                                        })
                                        .onEnded({ _ in
                                            self.isPressed = false
                                            
                                        })
                                )
                                .accessibility(label: Text((index == self.selectionIndex) ? "\("selected".localized)." : ".") + self.contents[index].labelView + Text(". \("tab".localized)"))
                                .accessibility(removeTraits: .isButton)
                                .accessibility(hint: Text(" \(index + 1) \("of".localized) \(self.contents.count)"))
                            }
                            .foregroundColor(Color.sbbColor(.textBlack))
                            .frame(width: segmentWidth, height: barHeight, alignment: .top)
                        }
                        .clipShape(TabBarShape(destTab: self.selectionIndex, currentTab: self.currentTab, nbTabs: self.contents.count, circleSize: self.circleSize, segmentWidth: segmentWidth, circlePad: 6, heightDiff: 2, transitionFactor: self.transitionFactor, transitionFactorPressed: self.transitionFactorPressed, isPressed: self.isPressed))
                    }
                    .frame(height: self.barHeight)
                    .offset(y: self.bottomOffset)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.sbbColor(.background))
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                        self.tabBarHidden = true
                    }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                        self.tabBarHidden = false
                    }
        }
    }
    
    private func getOffset(selectionIndex: Int, textWidth: CGFloat, segmentWidth: CGFloat) -> CGFloat {
        let halfSegment = segmentWidth / 2
        let halfText = textWidth / 2
        let offset = segmentWidth * CGFloat(selectionIndex) + halfSegment - halfText
        
        if selectionIndex == 0 {
            if halfText >= 0.8 * halfSegment {
                return 10
            }
            return halfSegment - halfText
        } else if selectionIndex == self.contents.count - 1 {
            if halfText >= 0.8 * halfSegment {
                return offset - halfText + halfSegment - 10
            }
            return offset
        } else {
            return offset
        }
    }
}

private struct ViewSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

private struct ViewGeometry: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ViewSizeKey.self, value: geometry.size)
        }
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
            if let bodyView = AnyView(_fromValue: body) {
                return TabBarEntryView(contentView: bodyView)
            }
            return TabBarEntryView()
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

struct SBBTabView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let tab: Int = 0
            
            SBBTabView(selection: .constant(tab)) {
                ZStack {
                    Rectangle()
                        .frame(width: .infinity, height: .infinity)
                        .foregroundColor(.red)
                    VStack {
                        Text("Bahnhof")
                        Image(sbbName: "station", size:.small)
                    }
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
            }
            .previewDisplayName("Light")
            
            SBBTabView(selection: .constant(0)) {
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
                    label: Text("Finder")
                )
                
                VStack {
                    Text("Lifte")
                    Image(sbbName: "Lift", size:.small)
                }
                .sbbTag(4)
                .sbbTabItem(
                    image: Image(sbbName: "lift", size:.small),
                    label: Text("Lifte")
                )
                
                VStack {
                    Text("Einstellungen")
                    Image(sbbName: "gears", size:.small)
                }
                .sbbTag(5)
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
