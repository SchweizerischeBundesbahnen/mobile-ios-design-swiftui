//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

/**
 A View that is used to display the shape of the tab bar
 */
struct TabBarShapeView: View {
    
    var selectionIndex: Int
    var currentTab: Int
    var tabBarParameters: TabBarParameters
    var transitionFactor: CGFloat
    var transitionFactorPressed: CGFloat
    var isPressed: Bool
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    public init(selectionIndex: Int, currentTab: Int, tabBarParameters: TabBarParameters, transitionFactor: CGFloat, transitionFactorPressed: CGFloat, isPressed: Bool) {
        self.selectionIndex = selectionIndex
        self.currentTab = currentTab
        self.tabBarParameters = tabBarParameters
        self.transitionFactor = transitionFactor
        self.transitionFactorPressed = transitionFactorPressed
        self.isPressed = isPressed
    }
    
    public var tabBarShape: TabBarShape { return TabBarShape(destTab: self.selectionIndex, currentTab: self.currentTab, tabBarCoordinatesParameters: self.tabBarParameters, transitionFactor: self.transitionFactor, transitionFactorPressed: self.transitionFactorPressed, isPressed: self.isPressed, isPortrait: self.horizontalSizeClass == .compact && self.verticalSizeClass == .regular)
    }
    
    public var body: some View {
        Rectangle()
            .frame(width: self.tabBarParameters.barWidth * 2, height: self.tabBarParameters.barHeight)
            .offset(y: self.tabBarParameters.barHeight)
            .foregroundColor(Color.sbbColor(.tabViewBackground))
            .frame(width: self.tabBarParameters.barWidth, height: self.tabBarParameters.barHeight)
            .accessibility(hidden: true)
        tabBarShape
            .frame(width: self.tabBarParameters.barWidth, height: self.tabBarParameters.barHeight)
            .foregroundColor(Color.sbbColor(.tabViewBackground))
            .accessibility(hidden: true)
    }
}
