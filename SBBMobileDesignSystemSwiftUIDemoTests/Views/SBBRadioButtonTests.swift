//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBMobileDesignSystemSwiftUI

class SBBRadioButtonTests: XCTestCase {
    
    let image = Image(sbbName: "alarm-clock", size: .small)
    let text = Text("Label")
    let subText = Text("SubLabel")
    
    func testRadioButtonTextOnly() {
        let view = SBBRadioButton(text: text)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
    
    func testRadioButtonWithImage() {
        let view = SBBRadioButton(image: image, text: text)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
    
    func testRadioButtonDisabled() {
        let view = SBBRadioButton(text: text)
            .disabled(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
    
    func testRadioButtonSubText() {
        let view = SBBRadioButton(image: image, text: text, subText: subText, showBottomLine: false)
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBRadioButton", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
}
