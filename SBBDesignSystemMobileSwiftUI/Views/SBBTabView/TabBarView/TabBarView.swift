//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI


/**
 A View that is used by ``SBBTabView`` to display the tab bar only.
 
 ## Overview
 You create a TabBarView by providing a selectedSegment binding and an array of TabBarEntryView for each tab. The image and label associated with each TabBarEntryView are retrieved to be displayed in the tab bar. A TabBarEntryView can be created from scratch or obtained through the View modifier `.sbbTabItem(image: Image?, label: Text?, tag: AnyHashable)`.
 
 ```swift
 @State private var selectedSegment = 0
 
     var body: some View {
         TabBarView(selection: $selectedSegment, contents: [
            VStack { ... }.sbbTabItem(image: Image(sbbName: "station", size: .small), label: Text("Station"), tag: 0),
            VStack { ... }.sbbTabItem(image: Image(sbbName: "bus-stop", size: .small), label: Text("Stop"), tag: 1)
         ])
    }
 }
 ```
 */
public struct TabBarView<Selection>: View where Selection: Hashable {
    
    @Binding private var selection: Selection
    
    @State private var labelSizes: [CGSize] = Array(repeating: .zero, count: 10)
    @State private var labelSize: CGSize = .zero
    @State private var transitionFactor: CGFloat = 1.0
    @State private var transitionFactorPressed: CGFloat = 1.0
    @State private var isPressed: Bool = false
    @State private var currentTab: Int = -1
    
    private var contents: [TabBarEntryView]
    private var selectionIndex: Int {
        contents.firstIndex { $0.tag as? Selection == selection } ?? 0
    }
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    /**
     Returns a TabBarView displaying the tab bar.
     
     - Parameters:
        - selection: The currently selected tab.
        - content: An array of TabBarEntryView, specifying the content of each tab.
     */
    public init(selection: Binding<Selection>, content: [TabBarEntryView]) {
        self._selection = selection
        self.contents = content
    }
    
    
    public var body: some View {
        let isPortrait = self.horizontalSizeClass == .compact && self.verticalSizeClass == .regular
        let barHeight: CGFloat = isPortrait ? 75 : 38
        
        GeometryReader { geometry in
            let segmentWidth: CGFloat = self.segmentWidth(parentWidth: geometry.size.width, nbTabs: self.contents.count)
            let circleSize: CGFloat = isPortrait ? 44 : 36
            let circlePad: CGFloat = isPortrait ? 6 : 2
            let topPad: CGFloat = isPortrait ? 8 : 0
            
            let buttonHeight: CGFloat = topPad + circleSize + circlePad
            let buttonWidth: CGFloat = circleSize + 2 * circlePad
            
            let tabBarParameters = TabBarParameters(circleRadius: circleSize / 2,
                                                    circlePad: circlePad,
                                                    topPad: topPad,
                                                    segmentWidth: segmentWidth,
                                                    segmentWidths: self.labelSizes,
                                                    barHeight: barHeight,
                                                    barWidth: geometry.size.width,
                                                    buttonHeight: buttonHeight,
                                                    buttonWidth: buttonWidth,
                                                    isPortrait: isPortrait)
            
            ZStack(alignment: .bottom) {
                // Circles behind the bar
                TabCircleRowView(selectionIndex: self.selectionIndex,
                                 content: self.contents,
                                 tabBarParameters: tabBarParameters)
                
                // Tab bar shape
                TabBarShapeView(selectionIndex: self.selectionIndex,
                                currentTab: self.currentTab,
                                tabBarParameters: tabBarParameters,
                                transitionFactor: self.transitionFactor,
                                transitionFactorPressed: self.transitionFactorPressed,
                                isPressed: self.isPressed)
                
                if isPortrait {
                    // Current tab label
                    TabLabelView(textSize: self.$labelSize,
                                 selectionIndex: self.selectionIndex,
                                 content: self.contents,
                                 tabBarParameters: tabBarParameters)
                }
                // Button in the tab bar
                if #available(iOS 15.0, *) {
                    TabButtonRow15View(selection: self.$selection,
                                       transitionFactor: self.$transitionFactor,
                                       transitionFactorPressed: self.$transitionFactorPressed,
                                       isPressed: self.$isPressed,
                                       currentTab: self.$currentTab,
                                       labelSizes: self.$labelSizes,
                                       content: self.contents,
                                       tabBarParameters: tabBarParameters)
                        .clipShape(TabBarShape(destTab: self.selectionIndex,
                                               currentTab: self.currentTab,
                                               tabBarCoordinatesParameters: tabBarParameters,
                                               transitionFactor: self.transitionFactor,
                                               transitionFactorPressed: self.transitionFactorPressed,
                                               isPressed: self.isPressed))
                } else {
                    TabButtonRowView(selection: self.$selection,
                                     transitionFactor: self.$transitionFactor,
                                     transitionFactorPressed: self.$transitionFactorPressed,
                                     isPressed: self.$isPressed,
                                     currentTab: self.$currentTab,
                                     labelSizes: self.$labelSizes,
                                     content: self.contents,
                                     tabBarParameters: tabBarParameters)
                        .clipShape(TabBarShape(destTab: self.selectionIndex, currentTab: self.currentTab, tabBarCoordinatesParameters: tabBarParameters, transitionFactor: self.transitionFactor, transitionFactorPressed: self.transitionFactorPressed, isPressed: self.isPressed))
                }
            }
        }
        .frame(height: barHeight)
    }
    
    private func segmentWidth(parentWidth: CGFloat, nbTabs: Int) -> CGFloat {
        return parentWidth / CGFloat(nbTabs)
    }
}

struct ViewSizeKey: PreferenceKey {
    public static var defaultValue: CGSize = .zero
    
    public static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct ViewGeometry: View {
    public var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ViewSizeKey.self, value: geometry.size)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    private static var tabBar = TabBarView(selection: .constant(0), content: [
        FakeTabBarEntry.fakeTab1,
        FakeTabBarEntry.fakeTab2,
    ])
    
    static var previews: some View {
        Group {
            tabBar
                .background(Color.sbbColor(.background))
                .previewDisplayName("Light portrait")
                .environment(\.horizontalSizeClass, .compact)
                .environment(\.verticalSizeClass, .regular)
            
            tabBar
                .background(Color.sbbColor(.background))
                .previewDisplayName("Dark portrait")
                .environment(\.colorScheme, .dark)
                .environment(\.horizontalSizeClass, .compact)
                .environment(\.verticalSizeClass, .regular)
            
            tabBar
                .background(Color.sbbColor(.background))
                .previewDisplayName("Light landscape")
            
            tabBar
                .background(Color.sbbColor(.background))
                .previewDisplayName("Dark landscape")
                .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
