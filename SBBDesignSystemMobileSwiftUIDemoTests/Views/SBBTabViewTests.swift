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
        for nbTabs in (2...6) {
            let view = getSBBTabView(nbTabs: nbTabs)
            for colorScheme in ColorScheme.allCases {
                //view.frame(minWidth: 375, minHeight: 812).recordDocumentationSnapshot(name: "SBBTabView", colorScheme: colorScheme)
                assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
            }
        }
    }
    
    func testTabViewLandscape() {
        for nbTabs in (2...6) {
            let view = getSBBTabView(nbTabs: nbTabs)
                //.environment(\.horizontalSizeClass, .regular)
                //.environment(\.verticalSizeClass, .regular)
            
            for colorScheme in ColorScheme.allCases {
                //view.frame(minWidth: 812, minHeight: 375).recordDocumentationSnapshot(name: "SBBTabViewLandscape", colorScheme: colorScheme)
                assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(on: .iPhoneX(.landscape), traits: traitLightMode), record: recordNewReferenceSnapshots)
            }
        }
    }
}
