//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBTabViewTests: DSMTest {
    
    private func getSBBTabView(nbTabs: Int) -> SBBTabView<Int> {
        return SBBTabView(selection: .constant(0), contentAboveBar: true) {
            for entry in FakeTabBarEntry.fakeTabEntries.prefix(upTo: nbTabs) {
                entry
            }
        }!
    }
    
    @Test func testTabView() {
        for nbTabs in (2...5) {
            let view = getSBBTabView(nbTabs: nbTabs)
            for colorScheme in ColorScheme.allCases {
                assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
            }
        }
    }
    
    @Test func testTabViewLandscape() {
        for nbTabs in (2...5) {
            let view = getSBBTabView(nbTabs: nbTabs)
            
            for colorScheme in ColorScheme.allCases {
                assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imageLandscape, record: recordNewReferenceSnapshots)
            }
        }
    }
}
