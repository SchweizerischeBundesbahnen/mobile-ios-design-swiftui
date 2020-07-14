//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBOnboardingView: View {
    
    @Binding private var onboardingState: SBBOnboardingState
    
    private let startView: SBBOnboardingTitleView
    private let endView: SBBOnboardingTitleView
    
    public init(onboardingState: Binding<SBBOnboardingState>, startView: SBBOnboardingTitleView, endView: SBBOnboardingTitleView) {
        self._onboardingState = onboardingState
        self.startView = startView
        self.endView = endView
    }
        
    public var body: some View {
        Group {
            if onboardingState == .startView {
                OnboardingTitleViewWithControls(onboardingState: $onboardingState, onboardingTitleView: startView)
            } else if onboardingState == .cardsView {
                OnboardingCardsView(onboardingState: $onboardingState)
            } else if onboardingState == .endView {
                OnboardingTitleViewWithControls(onboardingState: $onboardingState, onboardingTitleView: endView)
            }
        }
    }
}

struct SBBOnboardingView_Previews: PreviewProvider {
    
    static let onboardingTitleView = SBBOnboardingTitleView(image: Image(systemName: "car"), title: Text("Test title"))
    
    static var previews: some View {
        Group {
            SBBOnboardingView(onboardingState: .constant(.startView), startView: onboardingTitleView, endView: onboardingTitleView)
                .previewDisplayName("StartView Light")
            SBBOnboardingView(onboardingState: .constant(.startView), startView: onboardingTitleView, endView: onboardingTitleView)
                .previewDisplayName("StartView Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
