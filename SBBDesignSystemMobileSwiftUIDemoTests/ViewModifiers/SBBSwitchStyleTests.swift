//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBSwitchStyleTests: XCTestCase {
    
    var toggle = Toggle(isOn: .constant(true)) {
        Text("Label")
    }

    func testSwitchStyle() {
        let view = toggle.toggleStyle(SBBSwitchStyle())
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBSwitchStyle", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSwitchStyleDisabled() {
        let view = toggle.toggleStyle(SBBSwitchStyle()).disabled(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
}
