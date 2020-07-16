//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import SwiftUI

struct FakeSBBOnboardingCardViews {
    
    static let card1 = SBBOnboardingCardView(image: Image("Onboarding_Train", bundle: Helper.bundle), title: Text("Card 1"), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."))
    static let card2 = SBBOnboardingCardView(image: Image("Onboarding_Train", bundle: Helper.bundle), title: Text("Card 2"), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."))
    static let cardWithButton = SBBOnboardingCardView(image: Image("Onboarding_Train", bundle: Helper.bundle), title: Text("Card 3"), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")) {
            Button(action: {
                print("TODO")
            }) {
                Text("Ausprobieren")
            }
    }
    static let customCard = Text("Your custom card")
}
