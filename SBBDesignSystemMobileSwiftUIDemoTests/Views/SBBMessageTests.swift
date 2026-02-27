//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBMessageTests: DSMTest {
    let title = Text("Title, single line if possible.")
    let text = Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.")
    
    @Test func testSBBMessageError() {
        let view = SBBMessage(title: title, text: text, imageType: .error)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testSBBMessageErrorLoading() {
        let view = SBBMessage(title: title, text: text, imageType: .error, isLoading: true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testSBBMessageErrorRetry() {
        let view = SBBMessage(title: title, text: text, imageType: .error, retry: {})
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBMessage", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testSBBMessageWithTopImage() {
        let view = SBBMessage(title: title, text: text, topImage: Image(sbbIcon: .binoculars_large))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testSBBMessageWithTopImageAndBottomImage() {
        let view = SBBMessage(title: title, text: text, topImage: Image(sbbIcon: .binoculars_large), bottomImage: Image(sbbIcon: .arrows_circle_small))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testSBBMessageErrorWithBottomImage() {
        let view = SBBMessage(title: title, text: text, imageType: .error, bottomImage: Image(sbbIcon: .arrows_circle_small))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
