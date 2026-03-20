//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2024.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBStepperTests: DSMTest {
    
    @Test func testStepper() {
        let view = SBBStepper(currentStepIndex: 1, numberOfSteps: 3, images: [Image(sbbIcon: .face_worker_small), Image(sbbIcon: .piggy_bank_small), Image(sbbIcon: .heart_small)])
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBStepper", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
