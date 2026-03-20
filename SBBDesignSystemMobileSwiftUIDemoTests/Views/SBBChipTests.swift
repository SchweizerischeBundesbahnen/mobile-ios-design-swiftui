//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import Testing
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBChipTests: DSMTest {
    
    var title = Text("Hinweis")
    var text = Text("In und um den Bahnhof Biel / Bienne wird viel gebaut. Das kann Auswirkungen auf Ihre Reise haben. Beachten Sie deshalb den Onlinefahrplan und die aktuellen Anzeigen am Bahnhof, um über geänderte Gleise und Fahrpläne informiert zu sein.")

    @Test func testChipSelected() {
        let view = SBBChip(label: Text("Chip label"), isSelected: .constant(true), numberOfItems: 2)
        for colorScheme in ColorScheme.allCases {
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
    
    @Test func testChipUnselected() {
        let view = SBBChip(label: Text("Chip label"), isSelected: .constant(false), numberOfItems: 2)
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBChip", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
