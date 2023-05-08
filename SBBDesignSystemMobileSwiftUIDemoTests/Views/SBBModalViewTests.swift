//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBModalViewTests: XCTestCase {
    
    let modalViewContent = AnyView (
        VStack(spacing: 16) {
            Text("Your custom content")
            Button(action: {}) {
                Text("Custom Button")
            }
                .buttonStyle(SBBPrimaryButtonStyle())
        }
            .sbbScreenPadding(.horizontal)
    )
    
    func testModalViewPopup() {
        let view = SBBModalView(title: Text("Your title"), style: .popup, titleAlignment: .center, isPresented: .constant(true)) {
            self.modalViewContent
        }
        for colorScheme in ColorScheme.allCases {
            view.frame(width: 375).recordDocumentationSnapshot(name: "SBBModalView", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
