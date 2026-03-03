//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBRadioButtonTests: DSMTest {
    
    let image = Image(sbbIcon: .alarm_clock_small)
    let text = Text("Label")
    let subText = Text("SubLabel")
    
    @Test func testRadioButtonTextOnly() {
        let view = SBBRadioButton(text: text).isSelected(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testRadioButtonWithImage() {
        let view = SBBRadioButton(image: image, text: text).isSelected(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testRadioButtonDisabled() {
        let view = SBBRadioButton(text: text).isSelected(true)
            .disabled(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testRadioButtonSubText() {
        let view = SBBRadioButton(image: image, text: text, subText: subText, showBottomLine: false).isSelected(true)
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBRadioButton", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
