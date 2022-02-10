//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

struct FakeTabBarShape {
    static let tabBarShape = TabBarShapeView(selectionIndex: 0, currentTab: 1, tabBarParameters: FakeTabBarParameters.fakeSpaced, transitionFactor: 1.0, transitionFactorPressed: 1.0, isPressed: false)
    
    static let tabBarShapePressed = TabBarShapeView(selectionIndex: 0, currentTab: 1, tabBarParameters: FakeTabBarParameters.fakeClose, transitionFactor: 1.0, transitionFactorPressed: 1.0, isPressed: true)
    
    static let tabBarShapePressedSpaced = TabBarShapeView(selectionIndex: 0, currentTab: 1, tabBarParameters: FakeTabBarParameters.fakeSpaced, transitionFactor: 1.0, transitionFactorPressed: 1.0, isPressed: true)
    
    static let tabBarShapeTransition = TabBarShapeView(selectionIndex: 0, currentTab: 1, tabBarParameters: FakeTabBarParameters.fakeClose, transitionFactor: 0.4, transitionFactorPressed: 1, isPressed: false)
    
    static let tabBarShapeTransitionSpaced = TabBarShapeView(selectionIndex: 0, currentTab: 1, tabBarParameters: FakeTabBarParameters.fakeSpaced, transitionFactor: 0.4, transitionFactorPressed: 1, isPressed: false)
}
