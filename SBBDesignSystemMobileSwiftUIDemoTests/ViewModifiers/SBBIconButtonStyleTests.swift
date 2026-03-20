//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBIconButtonStyleTests: DSMTest {
    
    var button = Button(action: {}) {
        Image(sbbIcon: .dog_small)
    }

    @Test func testIconButton() {
        let view = button.buttonStyle(SBBIconButtonStyle())
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBIconButtonStyle", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testIconButtonDisabled() {
        let view = button.buttonStyle(SBBIconButtonStyle()).disabled(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testIconButtonSmall() {
        let view = button.buttonStyle(SBBIconButtonStyle(size: .small))
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBIconButtonStyleSmall", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
