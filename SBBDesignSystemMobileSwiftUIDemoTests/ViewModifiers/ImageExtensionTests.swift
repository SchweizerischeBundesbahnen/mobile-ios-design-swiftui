//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class ImageExtensionTests: XCTestCase {

    func testFPLIcon() {
        let view = Image(sbbIcon: .ir_40)
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "ImageExtensionIconFPL", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testKOMIconSmall() {
        let view = Image(sbbIcon: .station_small).foregroundColor(Color.sbbColor(.textBlack))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testKOMIconMedium() {
        let view = Image(sbbIcon: .station_medium).foregroundColor(Color.sbbColor(.textBlack))
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "ImageExtensionIconKOM", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testKOMIconLarge() {
        let view = Image(sbbIcon: .station_large).foregroundColor(Color.sbbColor(.textBlack))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testPictogramIcon() {
        let view = Image(sbbIcon: .Zug_r)
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "ImageExtensionIconPictogram", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
