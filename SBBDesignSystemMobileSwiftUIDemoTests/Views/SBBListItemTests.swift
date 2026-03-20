//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBListItemTests: DSMTest {
    
    var label = Text("Label")
    var footnote = Text("Footnote")
    var image = Image(sbbIcon: .station_small)

    @Test func testListItemWithLabel() {
        let view = SBBListItem(label: label, rightImage: Image(sbbIcon: .chevron_small_right_small))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testListItemInfoType() {
        let view = SBBListItem(label: label, rightImage: Image(sbbIcon: .circle_information_small_small))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testListItemWithLabelImage() {
        let view = SBBListItem(label: label, leftImage: image, rightImage: Image(sbbIcon: .chevron_small_right_small))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testListItemWithLabelFootnote() {
        let view = SBBListItem(label: label, rightImage: Image(sbbIcon: .chevron_small_right_small), footnote: footnote)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testListItemWithLabelImageFootnote() {
        let view = SBBListItem(label: label, leftImage: image, rightImage: Image(sbbIcon: .chevron_small_right_small), footnote: footnote, showBottomLine: false)
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBListItem", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
