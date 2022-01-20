//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBDividerTests: XCTestCase {
    
    func testDivider() {
        let view = SBBDivider()
        for colorScheme in ColorScheme.allCases {
            view.frame(minWidth: 300).recordDocumentationSnapshot(name: "SBBDivider", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
}
