//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2024.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI


class SBBHeaderTests: DSMTest {
    let content = {
        HStack {
            Image(sbbIcon: .city_small)
            Text("Some title")
        }
    }
    let additionalContent = {
        HStack {
            Image(sbbIcon: .sign_exclamation_point_small)
            Text("Additional text or information")
            Spacer()
            Image(sbbIcon: .circle_information_small)
           }
    }
    
    @Test func testSBBHeaderBox() {
        let view = SBBHeaderBox(content: content, pageContent: {})
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }

    @Test func testSBBHeaderBoxWithAdditionalContent() {
        let view = SBBHeaderBox(content: content, additionalContent: additionalContent)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testSBBHeaderBoxWithoutExtendedBackground() {
        let view = SBBHeaderBox(content: content, extendNavigationBarBackground: false, pageContent: {})
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testSBBHeaderWithAdditionalContentWithoutExtendedBackground() {
        let view = SBBHeaderBox(content: content, additionalContent: additionalContent, extendNavigationBarBackground: false)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
    
