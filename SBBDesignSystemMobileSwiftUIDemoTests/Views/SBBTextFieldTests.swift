//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBTextFieldTests: DSMTest {
    
    var text = "I like trains"
    var label = "Placeholder"

    @Test func testTextFieldPlaceholderNoText() {
        let view = SBBTextField(text: .constant(""), label: label)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testTextFieldPlaceHolderText() {
        let view = SBBTextField(text: .constant(text), label: label)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testTextFieldPlaceHolderTextIcon() {
        let view = SBBTextField(text: .constant(text), label: label, icon: Image(sbbIcon: .route_circle_start_small), showBottomLine: false)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testTextFieldPlaceHolderTextIconError() {
        let view = SBBTextField(text: .constant(text), label: label, error: "Error", icon: Image(sbbIcon: .route_circle_start_small))
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBTextField", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testTextFieldNoPlaceHolderText() {
        let view = SBBTextField(text: .constant(text))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testTextFieldNoPlaceHolderNoText() {
        let view = SBBTextField(text: .constant(""))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testTextFieldPlaceHolderTextDisabled() {
        let view = SBBTextField(text: .constant(text), label: label).disabled(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
