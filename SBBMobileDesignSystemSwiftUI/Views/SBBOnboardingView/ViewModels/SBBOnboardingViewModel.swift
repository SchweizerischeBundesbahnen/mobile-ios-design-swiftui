//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation

public class SBBOnboardingViewModel: ObservableObject {
    
    @Published public var state: SBBOnboardingState // TODO - Use UserDefaults to persist the state
    
    let startViewModel: SBBOnboardingTitleViewModel
    let endViewModel: SBBOnboardingTitleViewModel
    let cardViewModels: [SBBOnboardingCardViewModel]
    
    public init(state: SBBOnboardingState = .startView, startViewModel: SBBOnboardingTitleViewModel, endViewModel: SBBOnboardingTitleViewModel, cardViewModels: [SBBOnboardingCardViewModel]) {
        self.state = .startView
        self.startViewModel = startViewModel
        self.endViewModel = endViewModel
        self.cardViewModels = cardViewModels
    }
}
