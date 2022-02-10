//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI


/**
 A View that is used by ``SBBTabView`` to display a button.
 */
struct TabButtonView<Selection>: View where Selection: Hashable {
    
    @Binding private var selection: Selection
    @Binding private var transitionFactor: CGFloat
    @Binding private var transitionFactorPressed: CGFloat
    @Binding private var isPressed: Bool
    @Binding private var currentTab: Int
    @Binding private var labelSizes: [CGSize]
    
    private var index: Int
    private var tabBarParameters: TabBarParameters
    private var contents: [TabBarEntryView]
    private var isTabBarFocused: Bool
    private var selectionIndex: Int {
        TabBarEntryView.selectionIndex(for: selection, in: contents)
    }
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    /**
     Returns a TabButtonView displaying a button.
     
     - Parameters:
        - selection: The currently selected tab.
        - transitionFactor: The factor used to animate the transition between two tabs
        - transitionFactorPressed: The factor to animate the pressed shape
        - isPressed: Whether one pressed on a tab
        - currentTab: The index of the currently displayed tab
        - labelSizes: An array containing the size of the labels (for landscape mode)
        - index: The index of the button
        - content: An array of TabBarEntryView, specifying the content of each tab.
        - tabBarParameters: The TabBarParameters used to create the tab bar.
        - isTabBarFocused: Whether the tab bar is in focus of the VoiceOver
     */
    public init(selection: Binding<Selection>, transitionFactor: Binding<CGFloat>, transitionFactorPressed: Binding<CGFloat>, isPressed: Binding<Bool>, currentTab: Binding<Int>, labelSizes: Binding<[CGSize]>, index: Int, content: [TabBarEntryView], tabBarParameters: TabBarParameters, isTabBarFocused: Bool) {
        self._selection = selection
        self._transitionFactor = transitionFactor
        self._transitionFactorPressed = transitionFactorPressed
        self._isPressed = isPressed
        self._currentTab = currentTab
        self._labelSizes = labelSizes
        self.index = index
        self.contents = content
        self.tabBarParameters = tabBarParameters
        self.isTabBarFocused = isTabBarFocused
    }
    
    public var body: some View {
        let isPortrait = self.horizontalSizeClass == .compact && self.verticalSizeClass == .regular
        Button(action: {
            self.currentTab = self.selectionIndex
            self.selection = self.contents[index].tag as? Selection ?? self.selection
            
            if self.selectionIndex != self.currentTab && !self.isPressed {
                self.transitionFactor = 0.2
                withAnimation(Animation.easeIn(duration: 0.2)) {
                    self.transitionFactor = 1
                }
            }
        }) {
            if isPortrait {
                // Display only the icon
                self.contents[self.index].imageView
                    .frame(width: self.tabBarParameters.buttonWidth, height: self.tabBarParameters.circleRadius * 2)
                    .padding(.top, self.tabBarParameters.topPad)
            } else {
                // Display the icon and the text
                HStack(spacing: 0) {
                    self.contents[self.index].imageView
                        .frame(width: self.tabBarParameters.buttonWidth, height: self.tabBarParameters.circleRadius * 2)
                        .padding(.top, self.tabBarParameters.topPad)
                    
                    self.contents[self.index].labelView
                        .background(ViewGeometry())
                        .onPreferenceChange(ViewSizeKey.self) {
                            self.labelSizes[self.index] = $0
                        }
                        .sbbFont(.body)
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .padding(.leading, self.selectionIndex == index ? 10 : 0)
                        .padding(.trailing, 5)
                }
                .accessibility(hidden: true)
            }
        }
            .foregroundColor(Color.sbbColor(.textBlack))
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        if !self.isPressed {
                            self.isPressed = true
                            self.currentTab = self.index
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
            .accessibility(label: Text(self.isTabBarFocused ? "" : "\("tab bar".localized).") + Text((self.index == self.selectionIndex) ? "\("selected".localized)." : "") + self.contents[self.index].labelView + Text(". \("tab".localized)"))
            .accessibility(removeTraits: .isButton)
            .accessibility(hint: Text(" \(self.index + 1) \("of".localized) \(self.contents.count)"))
            .accessibility(identifier: self.contents[self.index].label)
    }
}

struct TabButtonView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            FakeTabButtons.fakeButton
                .background(Color.sbbColor(.background))
                .environment(\.horizontalSizeClass, .compact)
                .environment(\.verticalSizeClass, .regular)
                .previewDisplayName("Light portrait")
            
            FakeTabButtons.fakeButton
                .background(Color.sbbColor(.background))
                .environment(\.horizontalSizeClass, .compact)
                .environment(\.verticalSizeClass, .regular)
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark landscape")
            
            FakeTabButtons.fakeButton
                .background(Color.sbbColor(.background))
                .previewDisplayName("Light portrait")
            
            FakeTabButtons.fakeButton
                .background(Color.sbbColor(.background))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark landscape")
        }
        .previewLayout(.sizeThatFits)
    }
}

