//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBIconTextButtonStyleTests: XCTestCase {
    
    var button = Button(action: {}) {
        VStack(alignment: .center, spacing: 4, content: {
            Image(sbbIcon: .station_large)
            Text("Station")
        })
    }

    func testIconTextButton() {
        let view = button.buttonStyle(SBBIconTextButtonStyle())
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBIconTextButtonStyle", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testIconTextButtonDisabled() {
        let view = button.buttonStyle(SBBIconTextButtonStyle()).disabled(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
