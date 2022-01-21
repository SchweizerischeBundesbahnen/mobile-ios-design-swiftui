//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI


/**
 A View that is used to display the buttons in the tab bar for iOS 15.0
 */
@available(iOS 15.0, *)
public struct AccessibleTabButtonRowView<Selection>: View where Selection: Hashable {
    
    @AccessibilityFocusState private var isTabBarFocused: Bool
    
    @Binding private var selection: Selection
    @Binding private var transitionFactor: CGFloat
    @Binding private var transitionFactorPressed: CGFloat
    @Binding private var isPressed: Bool
    @Binding private var currentTab: Int
    @Binding private var labelSizes: [CGSize]
    
    private var tabBarParameters: TabBarParameters
    private var contents: [TabBarEntryView]
    private var selectionIndex: Int {
        for index in (0...self.contents.count) {
            // Some tab may not have a label
            if let tag = self.contents[index].tag, let tagValue = tag as? Selection {
                if tagValue == selection {
                    return index
                }
            }
        }
        return 0
    }
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    public init(selection: Binding<Selection>, transitionFactor: Binding<CGFloat>, transitionFactorPressed: Binding<CGFloat>, isPressed: Binding<Bool>, currentTab: Binding<Int>, labelSizes: Binding<[CGSize]>, contents: [TabBarEntryView], selectionIndex: Int, tabBarParameters: TabBarParameters) {
        self._selection = selection
        self._transitionFactor = transitionFactor
        self._transitionFactorPressed = transitionFactorPressed
        self._isPressed = isPressed
        self._currentTab = currentTab
        self._labelSizes = labelSizes
        
        self.contents = contents
        self.tabBarParameters = tabBarParameters
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<self.contents.count) { index in
                TabButtonView(selection: self.$selection, transitionFactor: self.$transitionFactor, transitionFactorPressed: self.$transitionFactorPressed, isPressed: self.$isPressed, currentTab: self.$currentTab, labelSizes: self.$labelSizes, index: index, contents: self.contents, selectionIndex: self.selectionIndex, tabBarParameters: self.tabBarParameters, isTabBarFocused: self.isTabBarFocused)
                    .accessibility(removeTraits: .isButton)
                    .accessibilityFocused($isTabBarFocused)
            }
            .foregroundColor(Color.sbbColor(.textBlack))
            .frame(width: self.tabBarParameters.segmentWidth, height: self.tabBarParameters.barHeight, alignment: .top)
        }
    }
}

/**
 A View that is used to display the buttons in the tab bar
 */
public struct TabButtonRowView<Selection>: View where Selection: Hashable {
    
    @Binding private var selection: Selection
    @Binding private var transitionFactor: CGFloat
    @Binding private var transitionFactorPressed: CGFloat
    @Binding private var isPressed: Bool
    @Binding private var currentTab: Int
    @Binding private var labelSizes: [CGSize]
    
    private var tabBarParameters: TabBarParameters
    private var contents: [TabBarEntryView]
    private var selectionIndex: Int {
        for index in (0...self.contents.count) {
            // Some tab may not have a label
            if let tag = self.contents[index].tag, let tagValue = tag as? Selection {
                if tagValue == selection {
                    return index
                }
            }
        }
        return 0
    }
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    public init(selection: Binding<Selection>, transitionFactor: Binding<CGFloat>, transitionFactorPressed: Binding<CGFloat>, isPressed: Binding<Bool>, currentTab: Binding<Int>, labelSizes: Binding<[CGSize]>, contents: [TabBarEntryView], selectionIndex: Int, tabBarParameters: TabBarParameters) {
        self._selection = selection
        self._transitionFactor = transitionFactor
        self._transitionFactorPressed = transitionFactorPressed
        self._isPressed = isPressed
        self._currentTab = currentTab
        self._labelSizes = labelSizes
        
        self.contents = contents
        self.tabBarParameters = tabBarParameters
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<self.contents.count) { index in
                TabButtonView(selection: self.$selection, transitionFactor: self.$transitionFactor, transitionFactorPressed: self.$transitionFactorPressed, isPressed: self.$isPressed, currentTab: self.$currentTab, labelSizes: self.$labelSizes, index: index, contents: self.contents, selectionIndex: self.selectionIndex, tabBarParameters: self.tabBarParameters, isTabBarFocused: true)
            }
            .foregroundColor(Color.sbbColor(.textBlack))
            .frame(width: self.tabBarParameters.segmentWidth, height: self.tabBarParameters.barHeight, alignment: .top)
        }
    }
}
