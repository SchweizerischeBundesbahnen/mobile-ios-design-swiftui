//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBMobileDesignSystemSwiftUI

class SBBPaginationViewTests: XCTestCase {
    
    @State var currentPageIndex: Int = 0


    func testPaginationViewLight() {
        let view = SBBPaginationView(currentPageIndex: $currentPageIndex, numberOfPages: 3)
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image, record: false)
    }
    
    func testPaginationViewDark() {
        let view = SBBPaginationView(currentPageIndex: $currentPageIndex, numberOfPages: 3)
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image, record: false)
    }
}
