//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBSecondaryButtonStyleTests: XCTestCase {
    
    var button = Button(action: {}) {
        Text("Secondary Button")
    }

    func testSecondaryButton() {
        let view = button.buttonStyle(SBBSecondaryButtonStyle())
        for colorScheme in ColorScheme.allCases {
            view.frame(minWidth: 200).recordDocumentationSnapshot(name: "SBBSecondaryButtonStyle", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSecondaryButtonDisabled() {
        let view = button.buttonStyle(SBBSecondaryButtonStyle()).disabled(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
