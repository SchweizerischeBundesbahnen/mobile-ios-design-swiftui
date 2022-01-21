//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

public struct FakeTabButtons {
    static let fakeButtonRow = TabButtonRowView(selection: .constant(0), transitionFactor: .constant(1.0), transitionFactorPressed: .constant(1.0), isPressed: .constant(false), currentTab: .constant(0), labelSizes: .constant([CGSize.zero, CGSize.zero]), contents: [FakeTabBarEntry.fakeTab1, FakeTabBarEntry.fakeTab2], selectionIndex: 1, tabBarParameters: FakeTabBarParameters.fakeSpaced)
    
    static let fakeButton = TabButtonView(selection: .constant(0), transitionFactor: .constant(1.0), transitionFactorPressed: .constant(1.0), isPressed: .constant(false), currentTab: .constant(0), labelSizes: .constant([CGSize.zero, CGSize.zero]), index: 0, contents: [FakeTabBarEntry.fakeTab1, FakeTabBarEntry.fakeTab2], selectionIndex: 1, tabBarParameters: FakeTabBarParameters.fakeSpaced, isTabBarFocused: true)
}
