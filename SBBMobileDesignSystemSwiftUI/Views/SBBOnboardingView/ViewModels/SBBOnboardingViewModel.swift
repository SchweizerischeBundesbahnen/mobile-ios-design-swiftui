//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import SwiftUI

public class SBBOnboardingViewModel: ObservableObject {
    
    @Published public var state: SBBOnboardingState // TODO - Use UserDefaults to persist the state
    @Published var currentCardIndex: Int = 0 {
        didSet {
            if cardViews.indices.contains(currentCardIndex) {
                currentCardView = cardViews[currentCardIndex]
                previousCardView = cardViews.indices.contains(currentCardIndex - 1) ? cardViews[currentCardIndex - 1] : nil
            }
        }
    }
    @Published var currentCardView: AnyView?
    @Published var previousCardView: AnyView?   // the CardView before the current CardView
    
    let startViewModel: SBBOnboardingTitleViewModel
    let endViewModel: SBBOnboardingTitleViewModel
    let cardViews: [AnyView]
    
    public init(state: SBBOnboardingState = .startView, startViewModel: SBBOnboardingTitleViewModel, endViewModel: SBBOnboardingTitleViewModel) {
        self.state = state
        self.startViewModel = startViewModel
        self.endViewModel = endViewModel
        self.cardViews = [AnyView]()
        self.currentCardView = cardViews.first
    }
    
    public init<C0>(state: SBBOnboardingState = .startView, startViewModel: SBBOnboardingTitleViewModel, endViewModel: SBBOnboardingTitleViewModel, _ c0: C0) where C0: View {
        self.state = state
        self.startViewModel = startViewModel
        self.endViewModel = endViewModel
        self.cardViews = [AnyView(c0)]
        self.currentCardView = cardViews.first
    }
    
    public init<C0, C1>(state: SBBOnboardingState = .startView, startViewModel: SBBOnboardingTitleViewModel, endViewModel: SBBOnboardingTitleViewModel, _ c0: C0, _ c1: C1) where C0: View, C1: View {
        self.state = state
        self.startViewModel = startViewModel
        self.endViewModel = endViewModel
        self.cardViews = [AnyView(c0), AnyView(c1)]
        self.currentCardView = cardViews.first
    }
    
    public init<C0, C1, C2>(state: SBBOnboardingState = .startView, startViewModel: SBBOnboardingTitleViewModel, endViewModel: SBBOnboardingTitleViewModel, _ c0: C0, _ c1: C1, _ c2: C2) where C0: View, C1: View, C2: View {
        self.state = state
        self.startViewModel = startViewModel
        self.endViewModel = endViewModel
        self.cardViews = [AnyView(c0), AnyView(c1), AnyView(c2)]
        self.currentCardView = cardViews.first
    }
    
    public init<C0, C1, C2, C3>(state: SBBOnboardingState = .startView, startViewModel: SBBOnboardingTitleViewModel, endViewModel: SBBOnboardingTitleViewModel, _ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) where C0: View, C1: View, C2: View, C3: View {
        self.state = state
        self.startViewModel = startViewModel
        self.endViewModel = endViewModel
        self.cardViews = [AnyView(c0), AnyView(c1), AnyView(c2), AnyView(c3)]
        self.currentCardView = cardViews.first
    }
    
    public init<C0, C1, C2, C3, C4>(state: SBBOnboardingState = .startView, startViewModel: SBBOnboardingTitleViewModel, endViewModel: SBBOnboardingTitleViewModel, _ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) where C0: View, C1: View, C2: View, C3: View, C4: View {
        self.state = state
        self.startViewModel = startViewModel
        self.endViewModel = endViewModel
        self.cardViews = [AnyView(c0), AnyView(c1), AnyView(c2), AnyView(c3), AnyView(c4)]
        self.currentCardView = cardViews.first
    }
    
    public init<C0, C1, C2, C3, C4, C5>(state: SBBOnboardingState = .startView, startViewModel: SBBOnboardingTitleViewModel, endViewModel: SBBOnboardingTitleViewModel, _ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View {
        self.state = state
        self.startViewModel = startViewModel
        self.endViewModel = endViewModel
        self.cardViews = [AnyView(c0), AnyView(c1), AnyView(c2), AnyView(c3), AnyView(c4), AnyView(c5)]
        self.currentCardView = cardViews.first
    }
}
