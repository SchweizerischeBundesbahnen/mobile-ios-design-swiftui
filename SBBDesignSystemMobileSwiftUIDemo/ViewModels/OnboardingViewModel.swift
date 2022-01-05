//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import Foundation
import SBBMobileDesignSystemSwiftUI
import UIKit

class OnboardingViewModel: ObservableObject {
    
    @Published var onboardingState: SBBOnboardingState {
        willSet {
            userDefaults.set(newValue.rawValue, forKey: OnboardingViewModel.userDefaultsKey)
            UIAccessibility.post(notification: .screenChanged, argument: nil)   // reset voiceover focus (on Onboarding or on "normal" screen)
        }
    }
    @Published var currentOnboardingCardIndex: Int = 0
    
    private let userDefaults = UserDefaults.standard
    private static let userDefaultsKey = "onboardingState"

    init() {
        self.onboardingState = SBBOnboardingState(rawValue: userDefaults.object(forKey: OnboardingViewModel.userDefaultsKey) as? String ?? "startView")!
    }
    
    // For SwiftUI previews.
    init(onboardingState: SBBOnboardingState = .hidden) {
        self.onboardingState = onboardingState
    }
}
