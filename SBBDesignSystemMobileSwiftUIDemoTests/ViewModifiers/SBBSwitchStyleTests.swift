//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBSwitchStyleTests: DSMTest {
    
    var toggle = Toggle(isOn: .constant(true)) {
        Text("Label")
    }

    @Test func testSwitchStyle() {
        let view = toggle.toggleStyle(SBBSwitchStyle())
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBSwitchStyle", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testSwitchStyleDisabled() {
        let view = toggle.toggleStyle(SBBSwitchStyle()).disabled(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
