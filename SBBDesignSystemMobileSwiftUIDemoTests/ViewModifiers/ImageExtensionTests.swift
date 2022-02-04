//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class ImageExtensionTests: XCTestCase {

    func testFPLIcon() {
        let view = Image(sbbName: "product-ir-40")
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "ImageExtensionIconFPL", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testKOMIconSmall() {
        let view = Image(sbbName: "station", size: .small).foregroundColor(Color.sbbColor(.textBlack))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testKOMIconMedium() {
        let view = Image(sbbName: "station", size: .medium).foregroundColor(Color.sbbColor(.textBlack))
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "ImageExtensionIconKOM", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testKOMIconLarge() {
        let view = Image(sbbName: "station", size: .large).foregroundColor(Color.sbbColor(.textBlack))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testPictogramIcon() {
        let view = Image(sbbName: "Zug_r")
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "ImageExtensionIconPictogram", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
}
