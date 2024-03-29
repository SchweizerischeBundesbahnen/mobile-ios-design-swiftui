//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import SwiftUI

struct FakeSBBOnboardingTitleViews {
    
    static let start = SBBOnboardingTitleView(image: Image("Onboarding_Luc", bundle: Helper.bundle), title: Text("Willkommen bei Ihrer SBB App"))
    static let end = SBBOnboardingTitleView(image: Image("Onboarding_Gang", bundle: Helper.bundle), title: Text("Wir wünschen Ihnen eine gute Fahrt mit Ihrer SBB App"))
}
