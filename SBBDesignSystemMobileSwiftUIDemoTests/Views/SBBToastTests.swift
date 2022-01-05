//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import SBBMobileDesignSystemSwiftUI

class SBBToastTests: XCTestCase {
    
    var text = Text("This Toast has multiple lines, in fact it might be longer than 2 IC2000 compositions linked together.")

    func testToast() {
        let view = ToastView(viewModel: SBBToast(label: text, isPresented: true))
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBToast", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
        }
    }
}
