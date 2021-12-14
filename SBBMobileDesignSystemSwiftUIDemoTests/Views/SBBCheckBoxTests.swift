//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBMobileDesignSystemSwiftUI

class SBBCheckBoxTests: XCTestCase {
    
    func testCheckBoxTextOnly() {
        let view = SBBCheckBox(isOn: .constant(true), text: Text("Label"))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
    
    func testCheckBoxWithImage() {
        let view = SBBCheckBox(isOn: .constant(false), image: Image(sbbName: "alarm-clock", size: .small), text: Text("Label"))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
    
    func testCheckBoxDisabled() {
        let view = SBBCheckBox(isOn: .constant(true), image: Image(sbbName: "alarm-clock", size: .small), text: Text("Label"))
            .disabled(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
    
    func testCheckBoxSubText() {
        let view = SBBCheckBox(isOn: .constant(true), image: Image(sbbName: "alarm-clock", size: .small), text: Text("Text"), subText: Text("SubText"), showBottomLine: false)
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBCheckBox", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
}
