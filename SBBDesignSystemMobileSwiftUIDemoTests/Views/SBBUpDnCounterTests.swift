//
//  Copyright © 2023 SBB. All rights reserved.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

final class SBBUpDnCounterTests: DSMTest {
    
    var label = Text("Label")
    var footnote = Text("Footnote")
    var image = Image(sbbIcon: .station_small)
    
    @State var counter = 5

    @Test func testUpDnCounterWithLabel() throws {
        let view = SBBUpDnCounterView(label: label, value: $counter)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testUpDnCounterWithLabelAndIcon() throws {
        let view = SBBUpDnCounterView(leftIcon: image, label: label, value: $counter)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testUpDnCounterWithLabelAndSubtext() throws {
        let view = SBBUpDnCounterView(label: label, subtext: footnote, value: $counter)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testUpDnCounterWithLabelImageAndSubtext() throws {
        let view = SBBUpDnCounterView(leftIcon: image, label: label, subtext: footnote, value: $counter)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }

    @Test func testUpDnCounterWithLabelMinimum() throws {
        let view = SBBUpDnCounterView(label: label, value: $counter, range: 5...10)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testUpDnCounterWithLabelMaximum() throws {
        let view = SBBUpDnCounterView(label: label, value: $counter, range: 0...5)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
