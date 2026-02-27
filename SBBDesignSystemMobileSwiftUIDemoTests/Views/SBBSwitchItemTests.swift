//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2025.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBSwitchItemTests: DSMTest {
    
    var label = Text("Label")
    var image = Image(sbbIcon: .unicorn_small)
    var errorMessage = Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut.")
    var errorCode = Text("Fehler-Code 12334")

    @Test func testSwitchItemList() {
        let view = SBBSwitchItem(isOn: .constant(true), label: label, image: image)
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBSwitchItemList", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testSwitchItemStandalone() {
        let view = SBBSwitchItem(isOn: .constant(true), label: label, image: image, type: .standalone)
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBSwitchItemStandalone", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testListItemListWithError() {
        let view = SBBSwitchItem(isOn: .constant(true), label: label, image: image, errorMessage: errorMessage, errorCode: errorCode)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testListItemStandaloneWithError() {
        let view = SBBSwitchItem(isOn: .constant(true), label: label, image: image, type: .standalone, errorMessage: errorMessage, errorCode: errorCode)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
