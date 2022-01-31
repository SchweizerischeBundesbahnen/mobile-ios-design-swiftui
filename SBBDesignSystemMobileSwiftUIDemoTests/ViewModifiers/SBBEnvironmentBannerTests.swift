//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBEnvironmentBannerTests: XCTestCase {
        
    func testEnvironmentBannerNone() {
        let view = NavigationView {
            EmptyView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("Title")
                .navigationBarItems(trailing: SBBNavigationBarSBBIcon())
        }.sbbEnvironmentBanner(.none)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testEnvironmentBannerDev() {
        let view = NavigationView {
            EmptyView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("Title")
                .navigationBarItems(trailing: SBBNavigationBarSBBIcon())
        }.sbbEnvironmentBanner(.dev)
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBEnvironmentBannerDev", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
}
