//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBMobileDesignSystemSwiftUI

class SBBListItemTests: XCTestCase {
    
    var label = Text("Label")
    var footnote = Text("Footnote")
    var image = Image(sbbName: "station", size: .small)

    func testListItemWithLabel() {
        let view = SBBListItem(label: label)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
    
    func testListItemInfoType() {
        let view = SBBListItem(label: label, type: .info)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
    
    func testListItemWithLabelImage() {
        let view = SBBListItem(label: label, image: image)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
    
    func testListItemWithLabelFootnote() {
        let view = SBBListItem(label: label, footnote: footnote)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
    
    func testListItemWithLabelImageFootnote() {
        let view = SBBListItem(label: label, image: image, footnote: footnote, showBottomLine: false)
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBListItem", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
}
