//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBProcessFlowTests: XCTestCase {
    
    func testProcessFlow() {
        let view = SBBProcessFlow(currentStepIndex: 1, images: [Image(sbbIcon: .face_worker_small), Image(sbbIcon: .piggy_bank_small), Image(sbbIcon: .heart_small)])
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBProcessFlow", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
