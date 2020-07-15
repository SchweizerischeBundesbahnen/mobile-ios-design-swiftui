//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import SwiftUI

public struct FakeSBBOnboardingViewModels {
    
    public static let startView = SBBOnboardingViewModel(startViewModel: FakeSBBOnboardingTitleViewModels.start, endViewModel: FakeSBBOnboardingTitleViewModels.end, cardViewModels: [FakeSBBOnboardingCardViewModels.card1, FakeSBBOnboardingCardViewModels.card2])
    public static let endView = SBBOnboardingViewModel(state: .endView, startViewModel: FakeSBBOnboardingTitleViewModels.start, endViewModel: FakeSBBOnboardingTitleViewModels.end, cardViewModels: [FakeSBBOnboardingCardViewModels.card1, FakeSBBOnboardingCardViewModels.card2])
    public static let cardsView = SBBOnboardingViewModel(state: .cardsView, startViewModel: FakeSBBOnboardingTitleViewModels.start, endViewModel: FakeSBBOnboardingTitleViewModels.end, cardViewModels: [FakeSBBOnboardingCardViewModels.card1, FakeSBBOnboardingCardViewModels.card2])
    public static let hidden = SBBOnboardingViewModel(state: .hidden, startViewModel: FakeSBBOnboardingTitleViewModels.start, endViewModel: FakeSBBOnboardingTitleViewModels.end, cardViewModels: [FakeSBBOnboardingCardViewModels.card1, FakeSBBOnboardingCardViewModels.card2])
}
