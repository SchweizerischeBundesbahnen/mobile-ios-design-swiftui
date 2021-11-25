//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBMobileDesignSystemSwiftUI

class SBBDividerTests: XCTestCase {
    
    func testDividerLight() {
        let view = SBBDivider()
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image, record: recordNewReferenceSnapshots)
    }

    func testDividerDark() {
        let view = SBBDivider()
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image, record: recordNewReferenceSnapshots)
    }
}
