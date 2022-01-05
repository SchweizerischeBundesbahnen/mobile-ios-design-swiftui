//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBProcessFlowTests: XCTestCase {
    
    func testProcessFlow() {
        let view = SBBProcessFlow(currentStepIndex: 1, images: [Image(sbbName: "face-worker", size: .small), Image(sbbName: "piggy-bank", size: .small), Image(sbbName: "heart", size: .small)])
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBProcessFlow", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
}
