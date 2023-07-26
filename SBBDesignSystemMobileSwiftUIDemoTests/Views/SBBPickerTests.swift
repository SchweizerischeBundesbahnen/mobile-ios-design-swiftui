//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBPickerTests: XCTestCase {
    
    let calendar = Calendar(identifier: .gregorian)
    var date: Date {
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = 7
        dateComponents.day = 26
        dateComponents.timeZone = TimeZone(abbreviation: "CET")
        dateComponents.hour = 14
        dateComponents.minute = 46

        // Create date from components
        return calendar.date(from: dateComponents)!
    }
    
    func testSBBDatePicker() {
        let view = SBBDatePicker(selection: .constant(date), pickerType: .dateTime)
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBDatePicker", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBDatePickerDateNotBoxed() {
        let view = SBBDatePicker(selection: .constant(date), pickerType: .date, isBoxed: false)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBDatePickerTimeNotBoxedLabel() {
        let view = SBBDatePicker(selection: .constant(date), pickerType: .time, isBoxed: false)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBDatePickerWithTimeRange() {
        let view = SBBDatePicker(fromTime: .constant(date), toTime: .constant(calendar.date(byAdding: .minute, value: 15, to: date)!))
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBDatePickerTimerange", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testSBBPicker() {
        let view = SBBPicker(.constant("Value 4"), tags: ["Value 1", "Value 2", "Value 3", "Value 4", "Value 5", "Value 6", "Value 7"]) { value in
            Text(value)
        }
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBPicker", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
}
