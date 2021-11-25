//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBMobileDesignSystemSwiftUI

class SBBTertiaryButtonStyleTests: XCTestCase {
    
    var button = Button(action: {}) {
        Text("Tertiary Button")
    }

    func testTertiaryButton() {
        let view = button.buttonStyle(SBBTertiaryButtonStyle())
        for colorScheme in ColorScheme.allCases {
            view.frame(minWidth: 200).recordDocumentationSnapshot(name: "SBBTertiaryButtonStyle", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
    
    func testTertiaryButtonDisabled() {
        let view = button.buttonStyle(SBBTertiaryButtonStyle()).disabled(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
    
    func testTertiaryButtonSmall() {
        let view = button.buttonStyle(SBBTertiaryButtonStyle(size: .small))
        for colorScheme in ColorScheme.allCases {
            view.frame(minWidth: 200).recordDocumentationSnapshot(name: "SBBTertiaryButtonStyleSmall", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
}
