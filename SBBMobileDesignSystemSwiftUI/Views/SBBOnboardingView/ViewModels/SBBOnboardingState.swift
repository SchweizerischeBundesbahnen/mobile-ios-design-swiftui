//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation

/// SBBOnboardingView current onboarding process state. This state typically needs to be persisted (e.g. in UserDefaults).
public enum SBBOnboardingState: String, Equatable {
    /// SBBOnboardingView state hiding the entire SBBOnboardingView (typically set after the user finished or aborted the Onboarding process)
    case hidden = "hidden"
    /// SBBOnboardingView state showing the initial SBBOnboardingCardView
    case startView = "startView"
    /// SBBOnboardingView state showing the first SBBOnboardingCardView
    case cardsView = "cardsView"
    /// SBBOnboardingView state showing the final SBBOnboardingCardView
    case endView = "endView"
}
