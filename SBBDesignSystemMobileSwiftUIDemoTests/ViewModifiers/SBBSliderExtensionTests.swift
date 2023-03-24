//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBSliderExtensionTests: XCTestCase {
    
    var slider = Slider(value: .constant(50.0), in: 0.0...100.0, step: 1.0)

    func testSliderExtension() {
        let view = slider.sbbStyle()
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testSliderExtensionWithImages() {
        let view = slider.sbbStyle(imageLeft: Image(sbbIcon: .walk_slow_small), imageRight: Image(sbbIcon: .walk_fast_small))
        for colorScheme in ColorScheme.allCases {
            view.frame(minWidth: 200).recordDocumentationSnapshot(name: "SliderExtension", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
}
