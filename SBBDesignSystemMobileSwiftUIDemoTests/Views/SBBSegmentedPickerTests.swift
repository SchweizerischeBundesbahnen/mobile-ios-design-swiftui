//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBMobileDesignSystemSwiftUI

class SBBSegmentedPickerTests: XCTestCase {

    func testSegmentedPickerPrimaryColor() {
        let view = SBBSegmentedPicker(selection: .constant(0), tags: [0, 1, 2], style: .primaryColor) {
            Text("Opt 1")
            Text("Opt 2")
            Text("Opt 3")
        }
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSegmentedPickerIcon() {
        let view = SBBSegmentedPicker(selection: .constant(0), tags: [0, 1]) {
            Image(sbbName: "timetable", size: .small)
            Image(sbbName: "platform-display", size: .small)
        }
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
    func testSegmentedPickerIconAndText() {
        let view = SBBSegmentedPicker(selection: .constant(0), tags: [0, 1]) {
            HStack {
                Image(sbbName: "timetable", size: .small)
                Text("Departures")
            }
            HStack {
                Image(sbbName: "platform-display", size: .small)
                Text("Platform")
            }
        }
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBSegmentedPicker", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
}
