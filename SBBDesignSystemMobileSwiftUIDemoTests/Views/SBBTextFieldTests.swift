//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBTextFieldTests: XCTestCase {
    
    var text = "I like trains"
    var label = "Placeholder"

    func testTextFieldPlaceholderNoText() {
        let view = SBBTextField(text: .constant(""), label: label)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testTextFieldPlaceHolderText() {
        let view = SBBTextField(text: .constant(text), label: label)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testTextFieldPlaceHolderTextIcon() {
        let view = SBBTextField(text: .constant(text), label: label, icon: Image(sbbName: "route-circle-start", size: .small), showBottomLine: false)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testTextFieldPlaceHolderTextIconError() {
        let view = SBBTextField(text: .constant(text), label: label, error: "Error", icon: Image(sbbName: "route-circle-start", size: .small))
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBTextField", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testTextFieldNoPlaceHolderText() {
        let view = SBBTextField(text: .constant(text))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testTextFieldNoPlaceHolderNoText() {
        let view = SBBTextField(text: .constant(""))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testTextFieldPlaceHolderTextDisabled() {
        let view = SBBTextField(text: .constant(text), label: label).disabled(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
}
