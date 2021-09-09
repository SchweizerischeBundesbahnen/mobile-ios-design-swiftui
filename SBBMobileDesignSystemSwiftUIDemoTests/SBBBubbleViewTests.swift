//
//  SBBBubbleViewTests.swift
//  SBBMobileDesignSystemSwiftUIDemoTests
//
//  Created by Terence Alberti on 23.12.20.
//  Copyright © 2020 SBB. All rights reserved.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBMobileDesignSystemSwiftUI

class SBBBubbleViewTests: XCTestCase {


    func testBubbleViewTitleOnlyLight() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"))
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image, record: false)
    }
    
    func testBubbleViewTitleOnlyDark() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"))
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image, record: false)
    }
    
    func testBubbleViewSubtitleLight() {
        let view = SBBBubbleView(image: Image(sbbName: "station", size: .medium), title: Text("Biel / Bienne"), subtitle: Text("Gleis 2 und 3."))
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image, record: false)
    }
    
    func testBubbleViewSubtitleDark() {
        let view = SBBBubbleView(image: Image(sbbName: "station", size: .medium), title: Text("Biel / Bienne"), subtitle: Text("Gleis 2 und 3."))
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image, record: false)
    }
    
    func testBubbleViewDetailLight() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), expanded: .constant(true), expandableContent: {
            Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
        })
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image, record: false)
    }
    
    func testBubbleViewDetailDark() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), expanded: .constant(true), expandableContent: {
            Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
        })
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image, record: false)
    }
    
    func testBubbleViewDetailNoBackgroundLight() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), expanded: .constant(true), extendNavigationBarBackground: false, expandableContent: {
            Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
        })
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image, record: false)
    }
    
    func testBubbleViewDetailNoBackgroundDark() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), expanded: .constant(true), extendNavigationBarBackground: false, expandableContent: {
            Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
        })
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image, record: false)
    }
    
    func testBubbleViewAccessbilityExtraExtraLargeLight() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), expanded: .constant(true), expandableContent: {
            Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
        }).environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image, record: false)
    }
    
    func testBubbleViewAccessbilityExtraExtraLargeDark() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), expanded: .constant(true), expandableContent: {
            Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
        }).environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image, record: false)
    }
    
    func testBubbleViewDetailMultipleViewLight() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), expanded: .constant(true), expandableContent: {
            Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
            Text("ca. +12'")
                .foregroundColor(.sbbColor(.red))
                .font(.sbbTitleDefault)
        })
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image, record: false)
    }
    
    func testBubbleViewDetailMultipleViewDark() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), expanded: .constant(true), expandableContent: {
            Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
            Text("ca. +12'")
                .foregroundColor(.sbbColor(.red))
                .font(.sbbTitleDefault)
        })
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image, record: false)
    }
    
    func testBubbleViewLongTitleLight() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("R2 nach La Chaux-de-Fonds-Grenier, Armes-Réunies"), expanded: .constant(true), expandableContent: {
            Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
        })
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image, record: false)
    }
    
    func testBubbleViewLongTitleDark() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("R2 nach La Chaux-de-Fonds-Grenier, Armes-Réunies"), expanded: .constant(true), expandableContent: {
            Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
        })
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image, record: false)
    }
    
    func testBubbleViewFixedContentLight() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), fixedContent: {
            Text("Wagen")
        })
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image, record: false)
    }
    
    func testBubbleViewFixedContentDark() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), fixedContent: {
            Text("Wagen")
        })
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image, record: false)
    }
    
    func testBubbleViewExpandableFixedContentLight() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), expanded: .constant(true), expandableContent: {
            Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
        }, fixedContent: {
            SBBSegmentedPicker(selection: .constant(0), tags: [0, 1], content: {
                Text("Wagen")
                Text("Perlschnur")
            })
        })
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image, record: false)
    }
    
    func testBubbleViewExpandableFixedContentDark() {
        let view = SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), expanded: .constant(true), expandableContent: {
            Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
        }, fixedContent: {
            SBBSegmentedPicker(selection: .constant(0), tags: [0, 1], content: {
                Text("Wagen")
                Text("Perlschnur")
            })
        })
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image, record: false)
    }
}
