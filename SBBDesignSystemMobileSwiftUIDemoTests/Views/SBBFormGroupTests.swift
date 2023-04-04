//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBFormGroupTests: XCTestCase {

    func testFormGroupWithTitle() {
        let view = SBBFormGroup(title: "Title:") {
            SBBTextField(text: .constant("My Value"), label: "Placeholder")
            SBBCheckBox(isOn: .constant(true), text: Text("CheckBox"), showBottomLine: false)
        }
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBFormGroup", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
