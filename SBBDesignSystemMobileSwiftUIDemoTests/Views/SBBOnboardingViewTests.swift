//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBMobileDesignSystemSwiftUI

class SBBOnboardingViewTests: XCTestCase {
    
    var titleView = SBBOnboardingTitleView(image: Image("Onboarding_Luc"), title: Text("Willkommen"))
    func createCardViews() -> [SBBOnboardingCardView] { return [SBBOnboardingCardView(image: Image("Onboarding_Card1"), title: Text("Card with additional custom content"), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")), SBBOnboardingCardView(image: Image("Onboarding_Card1"), title: Text(""), text: Text("")), SBBOnboardingCardView(image: Image("Onboarding_Card1"), title: Text(""), text: Text(""))]
    }

    func testOnboardingTitleView() {
        let view = SBBOnboardingView(state: .constant(.startView), currentCardIndex: .constant(0), startView: titleView, endView: titleView, content: createCardViews)
        for colorScheme in ColorScheme.allCases {
            view.frame(minWidth: 375, minHeight: 812).recordDocumentationSnapshot(name: "SBBOnboardingTitleView", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
    
    func testOnboardingCardView() {
        let view = SBBOnboardingView(state: .constant(.cardsView), currentCardIndex: .constant(0), startView: titleView, endView: titleView, content: createCardViews)
        for colorScheme in ColorScheme.allCases {
            view.frame(minWidth: 375, minHeight: 812).recordDocumentationSnapshot(name: "SBBOnboardingCardView", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
}
