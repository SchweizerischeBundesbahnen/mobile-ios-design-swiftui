//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import Testing
import SnapshotTesting
import SwiftUI
@testable import SBBDesignSystemMobileSwiftUI

class SBBToastTests: DSMTest {
    
    var text = Text("This Toast has multiple lines, in fact it might be longer than 2 IC2000 compositions linked together.")

    @Test func testToast() {
        let view = ToastView(viewModel: SBBToast(label: text, isPresented: true))
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBToast", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
