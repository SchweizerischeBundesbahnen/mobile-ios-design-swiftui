//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2024.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBHeaderTests: XCTestCase {
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
    
    func testSBBHeaderBox() {
        let view = SBBHeaderBox(content: content)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBHeaderBoxWithAdditionalContent() {
        let view = SBBHeaderBox(content: content, additionalContent: additionalContent)
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBHeaderBox", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBHeaderBoxWithoutExtendedBackground() {
        let view = SBBHeaderBox(content: content, extendNavigationBarBackground: false)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBHeaderWithAdditionalContentWithoutExtendedBackground() {
        let view = SBBHeaderBox(content: content, additionalContent: additionalContent, extendNavigationBarBackground: false)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
}
    
