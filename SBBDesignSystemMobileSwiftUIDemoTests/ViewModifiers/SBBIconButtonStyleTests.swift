//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBIconButtonStyleTests: XCTestCase {
    
    var button = Button(action: {}) {
        Image(sbbIcon: .dog_small)
    }

    func testIconButton() {
        let view = button.buttonStyle(SBBIconButtonStyle())
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBIconButtonStyle", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testIconButtonDisabled() {
        let view = button.buttonStyle(SBBIconButtonStyle()).disabled(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testIconButtonSmall() {
        let view = button.buttonStyle(SBBIconButtonStyle(size: .small))
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBIconButtonStyleSmall", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
