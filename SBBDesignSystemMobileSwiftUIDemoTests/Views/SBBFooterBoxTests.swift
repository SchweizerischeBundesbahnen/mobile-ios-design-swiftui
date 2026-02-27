//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2024.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBFooterTests: DSMTest {
    let content = {
        VStack(alignment: .leading) {
            Text("Title")
            Text("This is some information.")
        }
    }
    
    @Test func testSBBFooterBox() {
        let view = SBBFooterBox(content: content, hasTabBar: false)
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBFooterBox", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testSBBHeaderFooterBoxHasTabBar() {
        let view = SBBFooterBox(content: content, hasTabBar: true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
