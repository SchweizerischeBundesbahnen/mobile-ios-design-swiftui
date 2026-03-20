//
// Copyright (c) Schweizerische Bundesbahnen SBB, 2025
//  


import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBSwitchButtonStyleTests: DSMTest {
    
    var toggle = Toggle("", isOn: .constant(true))

    @Test func testSwitchButtonStyle() {
        
        let view = toggle.toggleStyle(SBBSwitchButtonStyle())
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBSwitchButtonStyle", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testSwitchButtonStyleDisabled() {
        let view = toggle.toggleStyle(SBBSwitchButtonStyle()).disabled(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
