//
// Copyright (c) Schweizerische Bundesbahnen SBB, 2025
//  

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBOnboardingWrapperTests: DSMTest {
    @Test func testOnboardingTitle() {
        let view = SBBOnboardingWrapperTitleView(image: Image("Onboarding_Luc"), title: Text("Willkommen"), subtitle: Text("Willkommen zum Rundgang."), buttonView: {
            Button(action: {}) {
                Text("Start")
            }
            .buttonStyle(SBBPrimaryButtonStyle())
        })
        for colorScheme in ColorScheme.allCases {
            view.frame(minWidth: 375, minHeight: 812).recordDocumentationSnapshot(name: "SBBOnboardingWrapper", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testOnboardingCard() {
        let view = SBBOnboardingWrapperCardView(image: Image("Onboarding_Card1"), title: Text("Card"), onNext: { }) {
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
        }
        for colorScheme in ColorScheme.allCases {
            view.frame(minWidth: 375, minHeight: 812).recordDocumentationSnapshot(name: "SBBOnboardingWrapperCard", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
