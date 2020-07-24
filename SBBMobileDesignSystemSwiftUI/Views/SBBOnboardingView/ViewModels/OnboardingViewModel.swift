//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import SwiftUI

class OnboardingViewModel: ObservableObject {
    
    @Binding var state: SBBOnboardingState
    @Binding var currentCardIndex: Int {
        didSet {
            if cardViews.indices.contains(currentCardIndex) {
                currentCardView = cardViews[currentCardIndex]
            }
        }
    }
    @Published var currentCardView: SBBOnboardingCardView?
    
    let cardViews: [SBBOnboardingCardView]
    
    init(state: Binding<SBBOnboardingState>, currentCardIndex: Binding<Int>, cardViews: [SBBOnboardingCardView]) {
        self._state = state
        self._currentCardIndex = currentCardIndex
        self.cardViews = cardViews
        
        if !cardViews.indices.contains(currentCardIndex.wrappedValue) {
            fatalError("currentCardIndex \(currentCardIndex.wrappedValue) passed to SBBOnboardingView is bigger than the number of passed cardViews \(cardViews.count)")
        }
        
        self.currentCardView = cardViews[currentCardIndex.wrappedValue]
    }
}
