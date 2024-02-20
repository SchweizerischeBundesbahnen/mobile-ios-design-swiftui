//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2024.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBFooterTests: XCTestCase {
    let content = {
        VStack(alignment: .leading) {
            Text("Title")
            Text("This is some information.")
        }
    }
    
    func testSBBFooterBox() {
        let view = SBBFooterBox(content: content, hasTabBar: false)
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBFooterBox", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBHeaderFooterBoxHasTabBar() {
        let view = SBBFooterBox(content: content, hasTabBar: true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
