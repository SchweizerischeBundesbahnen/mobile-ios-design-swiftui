//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBPromotionBoxTests: DSMTest {
    let title = Text("Title")
    let text = Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.")
    
    @Test func testSBBPromotionBox() {
        let view = SBBPromotionBox(title: title, text: text, isPresented: .constant(true))
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBPromotionBox", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
