//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBMobileDesignSystemSwiftUI

class SBBIconButtonStyleTests: XCTestCase {
    
    var button = Button(action: {}) {
        Image(sbbName: "dog", size: .small)
    }

    func testIconButton() {
        let view = button.buttonStyle(SBBIconButtonStyle())
        for colorScheme in ColorScheme.allCases {
            view.frame(minWidth: 200).recordDocumentationSnapshot(name: "SBBIconButtonStyle", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
    
    func testIconButtonDisabled() {
        let view = button.buttonStyle(SBBIconButtonStyle()).disabled(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
    
    func testIconButtonSmall() {
        let view = button.buttonStyle(SBBIconButtonStyle(size: .small))
        for colorScheme in ColorScheme.allCases {
            view.frame(minWidth: 200).recordDocumentationSnapshot(name: "SBBIconButtonStyleSmall", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
}
