//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

struct FakeTabButtons {
    static let fakeButtonRow = TabButtonRowView(selection: .constant(0), transitionFactor: .constant(1.0), transitionFactorPressed: .constant(1.0), isPressed: .constant(false), currentTab: .constant(0), labelSizes: .constant([CGSize.zero, CGSize.zero]), content: [FakeTabBarEntry.fakeTab1, FakeTabBarEntry.fakeTab2], tabBarParameters: FakeTabBarParameters.fakeSpaced)
    
    static let fakeButton = TabButtonView(selection: .constant(0), transitionFactor: .constant(1.0), transitionFactorPressed: .constant(1.0), isPressed: .constant(false), currentTab: .constant(0), labelSizes: .constant([CGSize.zero, CGSize.zero]), index: 0, content: [FakeTabBarEntry.fakeTab1, FakeTabBarEntry.fakeTab2], tabBarParameters: FakeTabBarParameters.fakeSpaced)
}
