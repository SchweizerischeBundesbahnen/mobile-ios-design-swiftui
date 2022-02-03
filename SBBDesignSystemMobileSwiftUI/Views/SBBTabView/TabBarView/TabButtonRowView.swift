//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

/**
 A View that is used by ``SBBTabView`` to display the buttons in the tab bar for iOS 15.0. What's different: the first time the VoiceOver goes into the TabBar, it says 'tab bar'.
 */
@available(iOS 15.0, *)
struct TabButtonRow15View<Selection>: View where Selection: Hashable {
    
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
        contents.firstIndex { $0.tag as? Selection == selection } ?? 0
    }
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    /**
     Returns a TabButtonRow15View displaying a row of buttons.
     
     - Parameters:
        - selection: The currently selected tab.
        - transitionFactor: The factor used to animate the transition between two tabs
        - transitionFactorPressed: The factor to animate the pressed shape
        - isPressed: Whether one pressed on a tab
        - currentTab: The index of the currently displayed tab
        - labelSizes: An array containing the size of the labels (for landscape mode)
        - content: An array of TabBarEntryView, specifying the content of each tab.
        - tabBarParameters: The TabBarParameters used to create the tab bar.
     */
    public init(selection: Binding<Selection>, transitionFactor: Binding<CGFloat>, transitionFactorPressed: Binding<CGFloat>, isPressed: Binding<Bool>, currentTab: Binding<Int>, labelSizes: Binding<[CGSize]>, contents: [TabBarEntryView], tabBarParameters: TabBarParameters) {
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
            ForEach(Array(self.contents.enumerated()), id: \.offset) { index, _ in
                TabButtonView(selection: self.$selection,
                              transitionFactor: self.$transitionFactor,
                              transitionFactorPressed: self.$transitionFactorPressed,
                              isPressed: self.$isPressed,
                              currentTab: self.$currentTab,
                              labelSizes: self.$labelSizes,
                              index: index,
                              contents: self.contents,
                              selectionIndex: self.selectionIndex,
                              tabBarParameters: self.tabBarParameters,
                              isTabBarFocused: self.isTabBarFocused)
                    .accessibility(removeTraits: .isButton)
                    .accessibilityFocused($isTabBarFocused)
            }
            .frame(width: self.tabBarParameters.segmentWidth, height: self.tabBarParameters.barHeight, alignment: .top)
        }
    }
}

/**
 A View that is used by ``SBBTabView`` to display the buttons in the tab bar.
 */
struct TabButtonRowView<Selection>: View where Selection: Hashable {
    
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
            if let tagValue = self.contents[index].tag as? Selection {
                if tagValue == selection {
                    return index
                }
            }
        }
        return 0
    }
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    /**
     Returns a TabButtonRowView displaying the buttons in the tab bar.
     
     - Parameters:
        - selection: The currently selected tab.
        - transitionFactor: The factor used to animate the transition between two tabs
        - transitionFactorPressed: The factor to animate the pressed shape
        - isPressed: Whether one pressed on a tab
        - currentTab: The index of the currently displayed tab
        - labelSizes: An array containing the size of the labels (for landscape mode)
        - content: An array of TabBarEntryView, specifying the content of each tab.
        - tabBarParameters: The TabBarParameters used to create the tab bar.
     */
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
            ForEach(Array(self.contents.enumerated()), id: \.offset) { index, _ in
                TabButtonView(selection: self.$selection,
                              transitionFactor: self.$transitionFactor,
                              transitionFactorPressed: self.$transitionFactorPressed,
                              isPressed: self.$isPressed,
                              currentTab: self.$currentTab,
                              labelSizes: self.$labelSizes,
                              index: index,
                              contents: self.contents,
                              selectionIndex: self.selectionIndex,
                              tabBarParameters: self.tabBarParameters,
                              isTabBarFocused: true)
            }
            .frame(width: self.tabBarParameters.segmentWidth, height: self.tabBarParameters.barHeight, alignment: .top)
        }
    }
}

struct TabButtonRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            FakeTabButtons.fakeButtonRow
                .background(Color.sbbColor(.background))
                .environment(\.horizontalSizeClass, .compact)
                .environment(\.verticalSizeClass, .regular)
                .previewDisplayName("Light portrait")
            
            FakeTabButtons.fakeButtonRow
                .background(Color.sbbColor(.background))
                .environment(\.horizontalSizeClass, .compact)
                .environment(\.verticalSizeClass, .regular)
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark landscape")
            
            FakeTabButtons.fakeButtonRow
                .background(Color.sbbColor(.background))
                .previewDisplayName("Light portrait")
            
            FakeTabButtons.fakeButtonRow
                .background(Color.sbbColor(.background))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark landscape")
        }
        .previewLayout(.sizeThatFits)
    }
}
