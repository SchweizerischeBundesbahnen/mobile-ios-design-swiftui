//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBStatusTests: XCTestCase {
    
    func testSBBStatusAlert() {
        let view = SBBStatus(statusType: .alert)
        for colorScheme in ColorScheme.allCases {
//            view.recordDocumentationSnapshot(name: "SBBStatus", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBStatusWarning() {
        let view = SBBStatus(statusType: .warning)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBStatusSuccess() {
        let view = SBBStatus(statusType: .success)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBStatusInfo() {
        let view = SBBStatus(statusType: .info)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBStatusAlertNoText() {
        let view = SBBStatus(statusType: .alert, showText: false)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBStatusWarningNoText() {
        let view = SBBStatus(statusType: .warning, showText: false)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBStatusSuccessNoText() {
        let view = SBBStatus(statusType: .success, showText: false)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBStatusInfoNoText() {
        let view = SBBStatus(statusType: .info, showText: false)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
