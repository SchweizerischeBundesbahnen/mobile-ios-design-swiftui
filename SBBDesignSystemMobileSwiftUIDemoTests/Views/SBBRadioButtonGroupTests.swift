//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBRadioButtonGroupTests: XCTestCase {
    
    func testRadioButtonGroup() {
        let view = SBBRadioButtonGroup(title: "Title", selection: .constant(0), tags: [0, 1, 2]) {
            SBBRadioButton(text: Text("Option 1"))
            SBBRadioButton(text: Text("Option 2"))
            SBBRadioButton(text: Text("Option 3"), showBottomLine: false)
        }
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBRadioButtonGroup", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
}
