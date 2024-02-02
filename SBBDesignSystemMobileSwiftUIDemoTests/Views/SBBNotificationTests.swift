//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBNotificationTests: XCTestCase {
    
    func testSBBNotificationAlert() {
        let view = SBBNotification(isPresented: .constant(true), statusType: .alert, title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."))
        for colorScheme in ColorScheme.allCases {
//            view.recordDocumentationSnapshot(name: "SBBNotification", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBNotificationWarning() {
        let view = SBBNotification(isPresented: .constant(true), statusType: .warning, title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBNotificationSuccess() {
        let view = SBBNotification(isPresented: .constant(true), statusType: .success, title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBNotificationInfo() {
        let view = SBBNotification(isPresented: .constant(true), statusType: .info, title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBNotificationAlertNoTitle() {
        let view = SBBNotification(isPresented: .constant(true), statusType: .alert, text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBNotificationWarningNoTitle() {
        let view = SBBNotification(isPresented: .constant(true), statusType: .warning, text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBNotificationSuccessNoTitle() {
        let view = SBBNotification(isPresented: .constant(true), statusType: .success, text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBNotificationInfoNoTitle() {
        let view = SBBNotification(isPresented: .constant(true), statusType: .info, text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBNotificationAlertCantBeClosed() {
        let view = SBBNotification(statusType: .info, title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBNotificationWarningCantBeClosedNoTitle() {
        let view = SBBNotification(statusType: .info, text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBNotificationSuccessCantBeClosedRetry() {
        let view = SBBNotification(statusType: .info, title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."), onRetry: {})
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBNotificationInfoCantBeClosedNoIcon() {
        let view = SBBNotification(statusType: .info, title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."), hideIcon: true)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
