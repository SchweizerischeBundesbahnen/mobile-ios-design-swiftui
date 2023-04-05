//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBPaginationViewTests: XCTestCase {
    
    @State var currentPageIndex: Int = 0


    func testPaginationView() {
        let view = SBBPaginationView(currentPageIndex: $currentPageIndex, numberOfPages: 3)
        for colorScheme in ColorScheme.allCases {
            view.recordDocumentationSnapshot(name: "SBBPaginationView", colorScheme: colorScheme)
            assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: imagePortrait, record: recordNewReferenceSnapshots)
        }
    }
}
