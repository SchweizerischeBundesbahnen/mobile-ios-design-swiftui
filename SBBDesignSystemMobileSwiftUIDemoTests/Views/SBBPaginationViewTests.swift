//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBPaginationViewTests: DSMTest {

    @Test func testPaginationView() {
        let view = SBBPaginationView(currentPageIndex: 0, numberOfPages: 3)
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBPaginationView", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
