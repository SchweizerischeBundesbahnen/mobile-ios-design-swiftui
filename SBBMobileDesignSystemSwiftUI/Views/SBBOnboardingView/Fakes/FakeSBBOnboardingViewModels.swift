//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import SwiftUI

public struct FakeSBBOnboardingViewModels {
    
    public static let startView = SBBOnboardingViewModel(startViewModel: FakeSBBOnboardingTitleViewModels.start, endViewModel: FakeSBBOnboardingTitleViewModels.end, FakeSBBOnboardingCardViews.card1, FakeSBBOnboardingCardViews.card2, FakeSBBOnboardingCardViews.cardWithButton, FakeSBBOnboardingCardViews.customCard)
    public static let endView = SBBOnboardingViewModel(state: .endView, startViewModel: FakeSBBOnboardingTitleViewModels.start, endViewModel: FakeSBBOnboardingTitleViewModels.end, FakeSBBOnboardingCardViews.card1, FakeSBBOnboardingCardViews.card2, FakeSBBOnboardingCardViews.cardWithButton, FakeSBBOnboardingCardViews.customCard)
    public static let cardsView = SBBOnboardingViewModel(state: .cardsView, startViewModel: FakeSBBOnboardingTitleViewModels.start, endViewModel: FakeSBBOnboardingTitleViewModels.end, FakeSBBOnboardingCardViews.card1, FakeSBBOnboardingCardViews.card2, FakeSBBOnboardingCardViews.cardWithButton, FakeSBBOnboardingCardViews.customCard)
    public static let hidden = SBBOnboardingViewModel(state: .hidden, startViewModel: FakeSBBOnboardingTitleViewModels.start, endViewModel: FakeSBBOnboardingTitleViewModels.end, FakeSBBOnboardingCardViews.card1, FakeSBBOnboardingCardViews.card2, FakeSBBOnboardingCardViews.cardWithButton, FakeSBBOnboardingCardViews.customCard)
}
