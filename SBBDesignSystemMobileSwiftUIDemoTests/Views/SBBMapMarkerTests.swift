//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBMapMarkerTests: DSMTest {
    
    @Test func testMapMarkerPrimary() {
        let view = SBBMapMarker(icon: Image(sbbIcon: .construction), style: .red)
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBMapMarker", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testMapMarkerBlue() {
        let view = SBBMapMarker(icon: Image(sbbIcon: .construction), style: .blue)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testMapMarkerBlack() {
        let view = SBBMapMarker(icon: Image(sbbIcon: .construction), style: .black)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
