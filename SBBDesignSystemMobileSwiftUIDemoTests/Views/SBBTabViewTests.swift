//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBTabViewTests: XCTestCase {
    
    private func getSBBTabView(nbTabs: Int) -> SBBTabView<Int> {
        return SBBTabView(selection: .constant(0), contentAboveBar: true) {
            for entry in FakeTabBarEntry.fakeTabEntries.prefix(upTo: nbTabs) {
                entry
            }
        }!
    }
    
    func testTabView() {
        for nbTabs in (2...5) {
            let view = getSBBTabView(nbTabs: nbTabs)
            for colorScheme in ColorScheme.allCases {
                assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
            }
        }
    }
    
    func testTabViewLandscape() {
        for nbTabs in (2...5) {
            let view = getSBBTabView(nbTabs: nbTabs)
            
            for colorScheme in ColorScheme.allCases {
                assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imageLandscape, record: recordNewReferenceSnapshots)
            }
        }
    }
}
