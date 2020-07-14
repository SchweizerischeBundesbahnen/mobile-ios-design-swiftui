//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBOnboardingView: View {
    
    @Binding private var onboardingState: SBBOnboardingState
    
    private let startView: SBBOnboardingTitleView
    private let endView: SBBOnboardingTitleView
    private let cardViews: [SBBOnboardingCardView]
    
    public init(onboardingState: Binding<SBBOnboardingState>, startView: SBBOnboardingTitleView, endView: SBBOnboardingTitleView, cardViews: [SBBOnboardingCardView]) {
        self._onboardingState = onboardingState
        self.startView = startView
        self.endView = endView
        self.cardViews = cardViews
    }
        
    public var body: some View {
        Group {
            if onboardingState == .startView {
                OnboardingTitleViewWithControls(onboardingState: $onboardingState, onboardingTitleView: startView)
            } else if onboardingState == .cardsView {
                OnboardingCardsView(onboardingState: $onboardingState, cardViews: cardViews)
            } else if onboardingState == .endView {
                OnboardingTitleViewWithControls(onboardingState: $onboardingState, onboardingTitleView: endView)
            }
        }
    }
}

struct SBBOnboardingView_Previews: PreviewProvider {
    
    static let onboardingTitleView = SBBOnboardingTitleView(image: Image(systemName: "car"), title: Text("Test title"))
    static let cardView = SBBOnboardingCardView(image: Image(systemName: "car"), title: Text("Test title"), text: Text("Test text"))
    static let cardViews = [cardView, cardView]
    
    static var previews: some View {
        Group {
            SBBOnboardingView(onboardingState: .constant(.startView), startView: onboardingTitleView, endView: onboardingTitleView, cardViews: cardViews)
                .previewDisplayName("StartView Light")
            SBBOnboardingView(onboardingState: .constant(.startView), startView: onboardingTitleView, endView: onboardingTitleView, cardViews: cardViews)
                .previewDisplayName("StartView Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
