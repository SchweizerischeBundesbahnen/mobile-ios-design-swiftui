//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct SBBAccordionTests: DSMTest {
    
    var title = Text("Hinweis")
    var text = Text("In und um den Bahnhof Biel / Bienne wird viel gebaut. Das kann Auswirkungen auf Ihre Reise haben. Beachten Sie deshalb den Onlinefahrplan und die aktuellen Anzeigen am Bahnhof, um über geänderte Gleise und Fahrpläne informiert zu sein.")

    @Test func testAccordionExpanded() {
        let view = SBBAccordion(title: title, text: text, expanded: .constant(true))
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBAccordion", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testAccordionCollapsed() {
        let view = SBBAccordion(title: title, text: text, expanded: .constant(false))
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
