//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBNavigationBarWithSBBIconTests: XCTestCase {
    
    func testNavigationBarWithSBBIcon() {
        let view = NavigationView {
            EmptyView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("Title")
                .navigationBarItems(trailing: SBBNavigationBarSBBIcon())
        }
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375, height: 44).recordDocumentationSnapshot(name: "SBBNavigationBarWithSBBIcon", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
}
