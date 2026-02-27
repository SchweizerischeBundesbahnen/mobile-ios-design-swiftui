//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBTextAreaTests: DSMTest {
    
    var text = "I like trains"
    var label = "Placeholder"

    @Test func testTextAreaPlaceholderNoText() {
        let view = SBBTextArea(text: .constant(""), label: label).frame(height: 100)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testTextAreaPlaceHolderText() {
        let view = SBBTextArea(text: .constant(text), label: label, showBottomLine: false).frame(height: 100)
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBTextArea", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testTextAreaNoPlaceHolderText() {
        let view = SBBTextArea(text: .constant(text)).frame(height: 100)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testTextAreaNoPlaceHolderNoText() {
        let view = SBBTextArea(text: .constant("")).frame(height: 100)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testTextAreaPlaceHolderTextDisabled() {
        let view = SBBTextArea(text: .constant(text), label: label).frame(height: 100).disabled(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
