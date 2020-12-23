//
//  SBBDividerTests.swift
//  SBBMobileDesignSystemSwiftUIDemoTests
//
//  Created by Terence Alberti on 23.12.20.
//  Copyright © 2020 SBB. All rights reserved.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBMobileDesignSystemSwiftUI

class SBBDividerTests: XCTestCase {
    
    func testDividerLight() {
        let view = SBBDivider()
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image)
    }

    func testDividerDark() {
        let view = SBBDivider()
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image)
    }
}
