//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import SwiftUI

struct FakeOnboardingViewModels {
    
    static let startView = OnboardingViewModel(state: .constant(.startView), cardViews: [FakeSBBOnboardingCardViews.card1, FakeSBBOnboardingCardViews.card2, FakeSBBOnboardingCardViews.cardWithButton, FakeSBBOnboardingCardViews.customCard])
    static let endView = OnboardingViewModel(state: .constant(.endView), cardViews: [FakeSBBOnboardingCardViews.card1, FakeSBBOnboardingCardViews.card2, FakeSBBOnboardingCardViews.cardWithButton, FakeSBBOnboardingCardViews.customCard])
    static let cardsView = OnboardingViewModel(state: .constant(.cardsView), cardViews: [FakeSBBOnboardingCardViews.card1, FakeSBBOnboardingCardViews.card2, FakeSBBOnboardingCardViews.cardWithButton, FakeSBBOnboardingCardViews.customCard])
    static let hidden = OnboardingViewModel(state: .constant(.hidden), cardViews: [FakeSBBOnboardingCardViews.card1, FakeSBBOnboardingCardViews.card2, FakeSBBOnboardingCardViews.cardWithButton, FakeSBBOnboardingCardViews.customCard])
}
