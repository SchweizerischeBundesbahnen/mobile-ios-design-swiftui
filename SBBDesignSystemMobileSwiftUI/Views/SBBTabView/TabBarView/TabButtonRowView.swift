//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

@available(iOS 15.0, *)
public struct AccessibilityTabButtonsView<Selection>: View where Selection: Hashable {
    @AccessibilityFocusState var isTabBarFocused: Bool
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
        TabButtonView(selection: self.$selection, transitionFactor: self.$transitionFactor, transitionFactorPressed: self.$transitionFactorPressed, isPressed: self.$isPressed, currentTab: self.$currentTab, labelSizes: self.$labelSizes, contents: self.contents, selectionIndex: self.selectionIndex, tabBarParameters: self.tabBarParameters)
    }
}

/**
 A View that is used to display the buttons on the tab bar
 */
public struct TabButtonsView<Selection>: View where Selection: Hashable {
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
        let isPortrait = self.horizontalSizeClass == .compact && self.verticalSizeClass == .regular
        HStack(spacing: 0) {
            ForEach(0..<self.contents.count) { index in
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
                        self.contents[index].imageView
                            .frame(width: self.tabBarParameters.buttonWidth, height: self.tabBarParameters.buttonHeight)
                    } else {
                        // Display the icon and the text
                        HStack(spacing: 0) {
                            self.contents[index].imageView
                                .frame(width: self.tabBarParameters.buttonWidth, height: self.tabBarParameters.buttonHeight)
                            self.contents[index].labelView
                               .accessibility(hidden: true)
                                .sbbFont(.body)
                                .lineLimit(1)
                                .minimumScaleFactor(0.1)
                                .padding(.leading, self.selectionIndex == index ? 10 : 0)
                                .background(ViewGeometry())
                                .onPreferenceChange(ViewSizeKey.self) {
                                    self.labelSizes[index] = $0
                                }
                        }
                    }
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
            .frame(width: self.tabBarParameters.segmentWidth, height: self.tabBarParameters.barHeight, alignment: .top)
        }
    }
}
