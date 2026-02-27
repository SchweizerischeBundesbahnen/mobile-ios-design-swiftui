//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBDividerTests: DSMTest {
    
    @Test func testDivider() {
        let view = SBBDivider()
        for colorScheme in ColorScheme.allCases {
            view.frame(minWidth: 300).recordDocumentationSnapshot(name: "SBBDivider", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
