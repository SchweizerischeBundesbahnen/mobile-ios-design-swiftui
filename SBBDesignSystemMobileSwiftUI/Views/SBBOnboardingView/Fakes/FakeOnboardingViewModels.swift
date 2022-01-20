//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import SwiftUI

struct FakeOnboardingViewModels {
    
    static let startView = OnboardingViewModel(state: .constant(.startView), currentCardIndex: .constant(0), cardViews: [FakeSBBOnboardingCardViews.card1, FakeSBBOnboardingCardViews.card2, FakeSBBOnboardingCardViews.cardWithButton, FakeSBBOnboardingCardViews.customCard])
    static let endView = OnboardingViewModel(state: .constant(.endView), currentCardIndex: .constant(0), cardViews: [FakeSBBOnboardingCardViews.card1, FakeSBBOnboardingCardViews.card2, FakeSBBOnboardingCardViews.cardWithButton, FakeSBBOnboardingCardViews.customCard])
    static let cardsView = OnboardingViewModel(state: .constant(.cardsView), currentCardIndex: .constant(0), cardViews: [FakeSBBOnboardingCardViews.card1, FakeSBBOnboardingCardViews.card2, FakeSBBOnboardingCardViews.cardWithButton, FakeSBBOnboardingCardViews.customCard])
    static let hidden = OnboardingViewModel(state: .constant(.hidden), currentCardIndex: .constant(0), cardViews: [FakeSBBOnboardingCardViews.card1, FakeSBBOnboardingCardViews.card2, FakeSBBOnboardingCardViews.cardWithButton, FakeSBBOnboardingCardViews.customCard])
}
