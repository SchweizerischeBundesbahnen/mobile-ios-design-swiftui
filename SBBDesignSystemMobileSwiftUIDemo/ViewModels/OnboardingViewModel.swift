//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import Foundation
import SBBDesignSystemMobileSwiftUI
import UIKit

class OnboardingViewModel: ObservableObject {
    
    enum OnboardingCard {
        case dsm
        case github
        case contact
    }
    
    @Published var onboardingState: SBBOnboardingWrapperState {
        willSet {
            userDefaults.set(newValue.rawValue, forKey: OnboardingViewModel.userDefaultsKey)
            UIAccessibility.post(notification: .screenChanged, argument: nil)   // reset voiceover focus (on Onboarding or on "normal" screen)
        }
    }
    @Published var currentOnboardingCard: OnboardingCard = .dsm
    @Published var currentOnboardingCardIndex: Int = 0
    
    private let userDefaults = UserDefaults.standard
    private static let userDefaultsKey = "onboardingState"

    init() {
        self.onboardingState = SBBOnboardingWrapperState(rawValue: userDefaults.object(forKey: OnboardingViewModel.userDefaultsKey) as? String ?? "start")!
    }
    
    func onNext(_ card: OnboardingCard?) {
        if let card {
            self.currentOnboardingCard = card
            self.currentOnboardingCardIndex += 1
        } else {
            self.onboardingState = .end
            self.currentOnboardingCard = .dsm
            self.currentOnboardingCardIndex = 0
        }
    }
    
    // For SwiftUI previews.
    init(onboardingState: SBBOnboardingWrapperState = .hidden) {
        self.onboardingState = onboardingState
    }
}
