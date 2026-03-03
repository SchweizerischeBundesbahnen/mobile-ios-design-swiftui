//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBEnvironmentBannerTests: DSMTest {
        
    @Test func testEnvironmentBannerNone() {
        let view = NavigationView {
            EmptyView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("Title")
                .navigationBarItems(trailing: SBBNavigationBarSBBIcon())
        }.sbbEnvironmentBanner(.none)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testEnvironmentBannerDev() {
        let view = NavigationView {
            EmptyView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("Title")
                .navigationBarItems(trailing: SBBNavigationBarSBBIcon())
        }.sbbEnvironmentBanner(.dev)
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBEnvironmentBannerDev", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
