//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import SwiftUI

class OnboardingViewModel: ObservableObject {
    
    @Binding var state: SBBOnboardingState
    @Published var currentCardIndex: Int = 0 {
        didSet {
            if cardViews.indices.contains(currentCardIndex) {
                currentCardView = cardViews[currentCardIndex]
                previousCardView = cardViews.indices.contains(currentCardIndex - 1) ? cardViews[currentCardIndex - 1] : nil
            }
        }
    }
    @Published var currentCardView: SBBOnboardingCardView?
    @Published var previousCardView: SBBOnboardingCardView?   // the CardView before the current CardView
    
    let cardViews: [SBBOnboardingCardView]
    
    init(state: Binding<SBBOnboardingState>, cardViews: [SBBOnboardingCardView]) {
        self._state = state
        self.cardViews = cardViews
        self.currentCardView = cardViews.first
    }
}
