//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBStatusTests: DSMTest {
    
    @Test func testSBBStatusAlert() {
        let view = SBBStatus(statusType: .alert)
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBStatus", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testSBBStatusWarning() {
        let view = SBBStatus(statusType: .warning)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testSBBStatusSuccess() {
        let view = SBBStatus(statusType: .success)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testSBBStatusInfo() {
        let view = SBBStatus(statusType: .info)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testSBBStatusAlertNoText() {
        let view = SBBStatus(statusType: .alert, showText: false)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testSBBStatusWarningNoText() {
        let view = SBBStatus(statusType: .warning, showText: false)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testSBBStatusSuccessNoText() {
        let view = SBBStatus(statusType: .success, showText: false)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testSBBStatusInfoNoText() {
        let view = SBBStatus(statusType: .info, showText: false)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
