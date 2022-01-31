//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBLoadingIndicatorTests: XCTestCase {
    
    func testLoadingIndicatorNormalPrimary() {
        let view = SBBLoadingIndicator(size: .normal, style: .primary)
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBLoadingIndicator", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testLoadingIndicatorNormalGrey() {
        let view = SBBLoadingIndicator(size: .normal, style: .grey)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testLoadingIndicatorNormalWhite() {
        let view = SBBLoadingIndicator(size: .normal, style: .primaryBackground)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testLoadingIndicatorSmallPrimary() {
        let view = SBBLoadingIndicator(size: .small, style: .primary)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
}
