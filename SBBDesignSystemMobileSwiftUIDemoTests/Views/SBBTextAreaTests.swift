//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBTextAreaTests: XCTestCase {
    
    var text = "I like trains"
    var label = "Placeholder"

    func testTextAreaPlaceholderNoText() {
        let view = SBBTextArea(text: .constant(""), label: label).frame(height: 100)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testTextAreaPlaceHolderText() {
        let view = SBBTextArea(text: .constant(text), label: label, showBottomLine: false).frame(height: 100)
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBTextArea", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testTextAreaNoPlaceHolderText() {
        let view = SBBTextArea(text: .constant(text)).frame(height: 100)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testTextAreaNoPlaceHolderNoText() {
        let view = SBBTextArea(text: .constant("")).frame(height: 100)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testTextAreaPlaceHolderTextDisabled() {
        let view = SBBTextArea(text: .constant(text), label: label).frame(height: 100).disabled(true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
}
