//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation

public enum SBBOnboardingState: String, Equatable {
    case hidden = "hidden"
    case startView = "startView"
    case cardsView = "cardsView"
    case endView = "endView"
}
