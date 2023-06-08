//
//  Copyright © 2023 SBB. All rights reserved.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

final class SBBUpDnCounterTests: XCTestCase {
    
    var label = Text("Label")
    var footnote = Text("Footnote")
    var image = Image(sbbIcon: .station_small)
    
    @State var counter = 5

    func testUpDnCounterWithLabel() throws {
        let view = SBBUpDnCounterView(label: label, value: $counter)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testUpDnCounterWithLabelAndIcon() throws {
        let view = SBBUpDnCounterView(leftIcon: image, label: label, value: $counter)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testUpDnCounterWithLabelAndSubtext() throws {
        let view = SBBUpDnCounterView(label: label, subtext: footnote, value: $counter)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testUpDnCounterWithLabelImageAndSubtext() throws {
        let view = SBBUpDnCounterView(leftIcon: image, label: label, subtext: footnote, value: $counter)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }

    func testUpDnCounterWithLabelMinimum() throws {
        let view = SBBUpDnCounterView(label: label, value: $counter, range: 5...10)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    func testUpDnCounterWithLabelMaximum() throws {
        let view = SBBUpDnCounterView(label: label, value: $counter, range: 0...5)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
