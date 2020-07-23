//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import SwiftUI

struct FakeOnboardingViewModels {
    
    static let startView = OnboardingViewModel(state: .constant(.startView), startViewModel: FakeOnboardingTitleViewModels.start, endViewModel: FakeOnboardingTitleViewModels.end, cardViews: [FakeSBBOnboardingCardViews.card1, FakeSBBOnboardingCardViews.card2, FakeSBBOnboardingCardViews.cardWithButton, FakeSBBOnboardingCardViews.customCard])
    static let endView = OnboardingViewModel(state: .constant(.endView), startViewModel: FakeOnboardingTitleViewModels.start, endViewModel: FakeOnboardingTitleViewModels.end, cardViews: [FakeSBBOnboardingCardViews.card1, FakeSBBOnboardingCardViews.card2, FakeSBBOnboardingCardViews.cardWithButton, FakeSBBOnboardingCardViews.customCard])
    static let cardsView = OnboardingViewModel(state: .constant(.cardsView), startViewModel: FakeOnboardingTitleViewModels.start, endViewModel: FakeOnboardingTitleViewModels.end, cardViews: [FakeSBBOnboardingCardViews.card1, FakeSBBOnboardingCardViews.card2, FakeSBBOnboardingCardViews.cardWithButton, FakeSBBOnboardingCardViews.customCard])
    static let hidden = OnboardingViewModel(state: .constant(.hidden), startViewModel: FakeOnboardingTitleViewModels.start, endViewModel: FakeOnboardingTitleViewModels.end, cardViews: [FakeSBBOnboardingCardViews.card1, FakeSBBOnboardingCardViews.card2, FakeSBBOnboardingCardViews.cardWithButton, FakeSBBOnboardingCardViews.customCard])
}
