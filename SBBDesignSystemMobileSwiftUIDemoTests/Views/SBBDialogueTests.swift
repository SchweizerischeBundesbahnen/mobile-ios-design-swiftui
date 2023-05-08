//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBDialogueTests: XCTestCase {
    
    private let title = Text("Title")
    private let label = Text("Multiline Text")
    private let errorCode = Text("ErrorCode: 404")

    func testSBBDialogueFullscreen() {
        let view = SBBDialogue(title: title, label: label, errorCode: errorCode, style: .fullscreen) {
            Button(action: { }) {
                Text("Custom Action 2")
            }
                .buttonStyle(SBBSecondaryButtonStyle())
            Button(action: { }) {
                Text("Custom Action 1")
            }
                .buttonStyle(SBBPrimaryButtonStyle())
        }
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBDialogueInline() {
        let view = SBBDialogue(title: title, label: label, errorCode: errorCode, style: .inline) {
            Button(action: { }) {
                Text("Custom Action 2")
            }
                .buttonStyle(SBBSecondaryButtonStyle())
            Button(action: { }) {
                Text("Custom Action 1")
            }
                .buttonStyle(SBBPrimaryButtonStyle())
        }
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBDialogue", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBDialogueList() {
        let view = SBBDialogue(title: title, label: label, errorCode: errorCode, style: .list) {
            Button(action: { }) {
                Text("Custom Action 2")
            }
                .buttonStyle(SBBSecondaryButtonStyle())
            Button(action: { }) {
                Text("Custom Action 1")
            }
                .buttonStyle(SBBPrimaryButtonStyle())
        }
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
