//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBMobileDesignSystemSwiftUI

class SBBIconTextButtonStyleTests: XCTestCase {
    
    var button = Button(action: {}) {
        VStack(alignment: .center, spacing: 4, content: {
            Image(sbbName: "station", size: .large)
            Text("Station")
        })
    }

    func testIconTextButton() {
        let view = button.buttonStyle(SBBIconTextButtonStyle())
        for colorScheme in ColorScheme.allCases {
            view.frame(minWidth: 200).recordDocumentationSnapshot(name: "SBBIconTextButtonStyle", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
    
    func testIconTextButtonDisabled() {
        let view = button.buttonStyle(SBBIconTextButtonStyle()).disabled(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
}
