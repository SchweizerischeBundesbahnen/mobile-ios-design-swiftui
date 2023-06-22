//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBPromotionBoxTests: XCTestCase {
    let title = Text("Title")
    let text = Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.")
    
    func testSBBPromotionBox() {
        let view = SBBPromotionBox(title: title, text: text, isPresented: .constant(true))
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBPromotionBox", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
