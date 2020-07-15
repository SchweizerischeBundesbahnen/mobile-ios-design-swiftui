//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation

public class SBBOnboardingViewModel: ObservableObject {
    
    @Published public var state: SBBOnboardingState // TODO - Use UserDefaults to persist the state
    @Published var currentCardIndex: Int = 0 {
        didSet {
            if cardViewModels.indices.contains(currentCardIndex) {
                currentCardViewModel = cardViewModels[currentCardIndex]
            }
        }
    }
    @Published var currentCardViewModel: SBBOnboardingCardViewModel?
    
    let startViewModel: SBBOnboardingTitleViewModel
    let endViewModel: SBBOnboardingTitleViewModel
    let cardViewModels: [SBBOnboardingCardViewModel]
    
    public init(state: SBBOnboardingState = .startView, startViewModel: SBBOnboardingTitleViewModel, endViewModel: SBBOnboardingTitleViewModel, cardViewModels: [SBBOnboardingCardViewModel]) {
        self.state = .startView
        self.startViewModel = startViewModel
        self.endViewModel = endViewModel
        self.cardViewModels = cardViewModels
        self.currentCardViewModel = cardViewModels.first
    }
}
