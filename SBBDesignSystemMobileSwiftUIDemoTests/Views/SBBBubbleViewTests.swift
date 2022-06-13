//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBBubbleViewTests: XCTestCase {


    func testBubbleViewTitleOnly() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testBubbleViewSubtitle() {
        let view = SBBBubbleView(image: Image(sbbName: "station", size: .medium), title: Text("Biel / Bienne"), subtitle: Text("Gleis 2 und 3."))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testBubbleViewDetail() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), expanded: .constant(true), expandableContent: {
            Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
        })
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testBubbleViewDetailNoBackground() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), expanded: .constant(true), extendNavigationBarBackground: false, expandableContent: {
            Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
        })
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testBubbleViewAccessbilityExtraExtraLarge() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), expanded: .constant(true), expandableContent: {
            Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
        }).environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testBubbleViewDetailMultipleView() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), expanded: .constant(true), expandableContent: {
            Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
            Text("ca. +12'")
                .foregroundColor(.sbbColor(.red))
                .font(.sbbTitleDefault)
        })
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBBubbleView", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testBubbleViewLongTitle() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("R2 nach La Chaux-de-Fonds-Grenier, Armes-Réunies"), expanded: .constant(true), expandableContent: {
            Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
        })
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testBubbleViewFixedContent() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), fixedContent: {
            Text("Wagen")
        })
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
    
    func testBubbleViewExpandableFixedContent() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), expanded: .constant(true), expandableContent: {
            Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
        }, fixedContent: {
            SBBSegmentedPicker(selection: .constant(0), tags: [0, 1], content: {
                Text("Wagen")
                Text("Perlschnur")
            })
        })
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(traits: traitLightMode), record: recordNewReferenceSnapshots)
        }
    }
}
