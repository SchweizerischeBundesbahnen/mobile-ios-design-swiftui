//
//  SBBCheckBoxTests.swift
//  SBBMobileDesignSystemSwiftUIDemoTests
//
//  Created by Terence Alberti on 23.12.20.
//  Copyright © 2020 SBB. All rights reserved.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBMobileDesignSystemSwiftUI

class SBBCheckBoxTests: XCTestCase {
    
    
    func testCheckBoxTextOnlyLight() {
        let view = SBBCheckBox(isOn: .constant(true), label: "Label")
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image)
    }
    
    func testCheckBoxTextOnlyDark() {
        let view = SBBCheckBox(isOn: .constant(true), label: "Label")
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image)
    }
    
    func testCheckBoxWithImageLight() {
        let view = SBBCheckBox(isOn: .constant(false), image: Image(sbbName: "alarm-clock", size: .small), label: "Label")
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image)
    }
    
    func testCheckBoxWithImageDark() {
        let view = SBBCheckBox(isOn: .constant(false), image: Image(sbbName: "alarm-clock", size: .small), label: "Label")
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image)
    }
    
    func testCheckBoxDisabledLight() {
        let view = SBBCheckBox(isOn: .constant(true), image: Image(sbbName: "alarm-clock", size: .small), label: "Label")
            .disabled(true)
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image)
    }
    
    func testCheckBoxDisabledDark() {
        let view = SBBCheckBox(isOn: .constant(true), image: Image(sbbName: "alarm-clock", size: .small), label: "Label")
            .disabled(true)
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image)
    }
    
    func testCheckBoxCustomContentLight() {
        let view = SBBCheckBox(isOn: .constant(true)) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Ich möchte der SBB Informationen zum verwendeten Gerät übermitteln.")
                    .sbbFont(.body)
                Text("Modell: iPhone 11 Pro\niOS Version: 14.0")
                    .sbbFont((.legend))
            }
        }
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image)
    }
    
    func testCheckCustomContentDark() {
        let view = SBBCheckBox(isOn: .constant(true)) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Ich möchte der SBB Informationen zum verwendeten Gerät übermitteln.")
                    .sbbFont(.body)
                Text("Modell: iPhone 11 Pro\niOS Version: 14.0")
                    .sbbFont((.legend))
            }
        }
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image)
    }
}