//
// Copyright (c) Schweizerische Bundesbahnen SBB, 2025
//  

/// SBBOverview current process state. This state typically needs to be persisted (e.g. in UserDefaults).
public enum SBBOverviewState: String, Equatable {
    /// state hiding the entire SBBOverview (typically set after the user finished or aborted the Onboarding process)
    case hidden
    /// state showing the start of the overview (typically on first app launch)
    case start
    /// state showing the restart of the overview (typically when the overview is revisited)
    case restart
    /// state showing the cards of the overview
    case cards
    /// state showing the end of the overview
    case end
    /// state showing the update of the overview (typically when a new feature is added)
    case update
    /// state showing the settings of the overview (typically to handle authorizations)
    case settings
}
