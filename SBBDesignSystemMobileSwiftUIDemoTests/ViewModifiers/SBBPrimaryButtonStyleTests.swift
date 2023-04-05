//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBPrimaryButtonStyleTests: XCTestCase {
    
    var button = Button(action: {}) {
        Text("Primary Button")
    }

    func testPrimaryButton() {
        let view = button.buttonStyle(SBBPrimaryButtonStyle())
        for colorScheme in ColorScheme.allCases {
            view.frame(minWidth: 200).recordDocumentationSnapshot(name: "SBBPrimaryButtonStyle", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testPrimaryButtonDisabled() {
        let view = button.buttonStyle(SBBPrimaryButtonStyle()).disabled(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
