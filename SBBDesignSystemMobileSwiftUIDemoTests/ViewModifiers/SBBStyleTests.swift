//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBStyleTests: XCTestCase {
    
    func testNavigationBarWithSBBIcon() {
        let view = NavigationView {
            Group {
                Text("This text has SBB styling.")
            }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("Title")
                .sbbStyle()
        }
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375, height: 667).recordDocumentationSnapshot(name: "SBBStyle", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
}
