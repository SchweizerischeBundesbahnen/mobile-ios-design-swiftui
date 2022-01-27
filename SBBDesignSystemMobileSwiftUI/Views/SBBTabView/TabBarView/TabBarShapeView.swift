//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

/**
 A View that is used by ``SBBTabView`` to display the shape of the tab bar.
 */
struct TabBarShapeView: View {
    
    var selectionIndex: Int
    var currentTab: Int
    var tabBarParameters: TabBarParameters
    var transitionFactor: CGFloat
    var transitionFactorPressed: CGFloat
    var isPressed: Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    /**
     Returns a TabBarShapeView displaying the shape of the tab bar.
     
     - Parameters:
        - selectionIndex: The index of the selected tab
        - currentTab: The index of the currently displayed tab
        - tabBarParameters: The TabBarParameters used to create the tab bar.
        - transitionFactor: The factor used to animate the transition between two tabs
        - transitionFactorPressed: The factor to animate the pressed shape
        - isPressed: Whether one pressed on a tab
     */
    public init(selectionIndex: Int, currentTab: Int, tabBarParameters: TabBarParameters, transitionFactor: CGFloat, transitionFactorPressed: CGFloat, isPressed: Bool) {
        self.selectionIndex = selectionIndex
        self.currentTab = currentTab
        self.tabBarParameters = tabBarParameters
        self.transitionFactor = transitionFactor
        self.transitionFactorPressed = transitionFactorPressed
        self.isPressed = isPressed
    }
    
    public var tabBarShape: TabBarShape { return TabBarShape(destTab: self.selectionIndex, currentTab: self.currentTab, tabBarCoordinatesParameters: self.tabBarParameters, transitionFactor: self.transitionFactor, transitionFactorPressed: self.transitionFactorPressed, isPressed: self.isPressed, isPortrait: self.tabBarParameters.isPortrait)
    }
    
    public var body: some View {
        ZStack {
            tabBarShape
                .frame(width: self.tabBarParameters.barWidth, height: self.tabBarParameters.barHeight)
                .foregroundColor(Color.sbbColor(.tabViewBackground))
                .accessibility(hidden: true)
                .shadow(color: Color.sbbColor(.tabshadow), radius: self.colorScheme == .dark ? 0 : 20, x: 0, y: 0)
            Rectangle()
                .frame(width: self.tabBarParameters.barWidth * 2, height: self.tabBarParameters.barHeight)
                .offset(y: self.tabBarParameters.barHeight)
                .foregroundColor(Color.sbbColor(.tabViewBackground))
                .frame(width: self.tabBarParameters.barWidth, height: self.tabBarParameters.barHeight)
                .accessibility(hidden: true)
        }
    }
}

struct TabBarShapeView_Previews: PreviewProvider {
    
    private static var allTabBarShape = [FakeTabBarShape.tabBarShape, FakeTabBarShape.tabBarShapePressed, FakeTabBarShape.tabBarShapePressedSpaced, FakeTabBarShape.tabBarShapeTransition, FakeTabBarShape.tabBarShapeTransitionSpaced]
    
    private static var allTabBarName = ["", "pressed", "transition"]
    
    static var previews: some View {
        Group {
            ForEach(0..<allTabBarShape.count) { index in
                allTabBarShape[index]
                    .background(Color.sbbColor(.background))
                    .previewDisplayName("Light \(allTabBarName[index % 3])")
                
                allTabBarShape[index]
                    .background(Color.sbbColor(.background))
                    .previewDisplayName("Dark \(allTabBarName[index % 3])")
                    .environment(\.colorScheme, .dark)
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
