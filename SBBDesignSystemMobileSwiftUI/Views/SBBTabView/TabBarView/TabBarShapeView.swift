//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

struct TabBarShapeView: View {
    
    private var barHeight: CGFloat
    var selectionIndex: Int
    var currentTab: Int
    var tabBarCoordinatesParameters: TabBarCoordinatesParameters
    var transitionFactor: CGFloat
    var transitionFactorPressed: CGFloat
    var isPressed: Bool
    
    public init(barHeight: CGFloat, selectionIndex: Int, currentTab: Int, tabBarCoordinatesParameters: TabBarCoordinatesParameters, transitionFactor: CGFloat, transitionFactorPressed: CGFloat, isPressed: Bool) {
        self.barHeight = barHeight
        self.selectionIndex = selectionIndex
        self.currentTab = currentTab
        self.tabBarCoordinatesParameters = tabBarCoordinatesParameters
        self.transitionFactor = transitionFactor
        self.transitionFactorPressed = transitionFactorPressed
        self.isPressed = isPressed
    }
    
    public var tabBarShape: some View {
        // Tab bar shape
        TabBarShape(destTab: self.selectionIndex, currentTab: self.currentTab, tabBarCoordinatesParameters: self.tabBarCoordinatesParameters, transitionFactor: self.transitionFactor, transitionFactorPressed: self.transitionFactorPressed, isPressed: self.isPressed)
            .foregroundColor(Color.sbbColor(.tabViewBackground))
    }
    
    public var body: some View {
        GeometryReader { geometry in
            // Additional (to cover unsafe area at the bottom)
            Rectangle()
                .frame(width: geometry.size.width * 2, height: self.barHeight)
                .offset(y: self.barHeight)
                .foregroundColor(Color.sbbColor(.tabViewBackground))
                .frame(width: geometry.size.width, height: self.barHeight)
            tabBarShape
        }
    }
}
