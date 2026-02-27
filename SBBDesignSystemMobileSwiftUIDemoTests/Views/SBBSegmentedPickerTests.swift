//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBSegmentedPickerTests: DSMTest {

    @Test func testSegmentedPickerPrimaryColor() {
        let view = SBBSegmentedPicker(selection: .constant(0), tags: [0, 1, 2], style: .primaryColor) {
            Text("Opt 1")
            Text("Opt 2")
            Text("Opt 3")
        }
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testSegmentedPickerIcon() {
        let view = SBBSegmentedPicker(selection: .constant(0), tags: [0, 1]) {
            Image(sbbIcon: .timetable_small)
            Image(sbbIcon: .platform_display_small)
        }
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    @Test func testSegmentedPickerIconAndText() {
        let view = SBBSegmentedPicker(selection: .constant(0), tags: [0, 1]) {
            HStack {
                Image(sbbIcon: .timetable_small)
                Text("Departures")
            }
            HStack {
                Image(sbbIcon: .platform_display_small)
                Text("Platform")
            }
        }
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBSegmentedPicker", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
