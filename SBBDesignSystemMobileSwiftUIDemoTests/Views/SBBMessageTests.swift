//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBMessageTests: XCTestCase {
    let title = Text("Title, single line if possible.")
    let text = Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus.")
    
    func testSBBMessageError() {
        let view = SBBMessage(title: title, text: text, imageType: .error)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBMessageErrorLoading() {
        let view = SBBMessage(title: title, text: text, imageType: .error, isLoading: true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBMessageErrorRetry() {
        let view = SBBMessage(title: title, text: text, imageType: .error, retry: {})
        for colorScheme in ColorScheme.allCases {
            //gview.recordDocumentationSnapshot(name: "SBBMessage", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBMessageWithTopImage() {
        let view = SBBMessage(title: title, text: text, topImage: Image(sbbIcon: .binoculars_large))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBMessageWithTopImageAndBottomImage() {
        let view = SBBMessage(title: title, text: text, topImage: Image(sbbIcon: .binoculars_large), bottomImage: Image(sbbIcon: .arrows_circle_small))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBMessageInfoWithBottomImage() {
        let view = SBBMessage(title: title, text: text, imageType: .error, bottomImage: Image(sbbIcon: .arrows_circle_small))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
