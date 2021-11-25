//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBMobileDesignSystemSwiftUI

class SBBCheckBoxTests: XCTestCase {
    
    func testCheckBoxTextOnlyLight() {
        let view = SBBCheckBox(isOn: .constant(true), text: Text("Label"))
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image, record: recordNewReferenceSnapshots)
    }
    
    func testCheckBoxTextOnlyDark() {
        let view = SBBCheckBox(isOn: .constant(true), text: Text("Label"))
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image, record: recordNewReferenceSnapshots)
    }
    
    func testCheckBoxWithImageLight() {
        let view = SBBCheckBox(isOn: .constant(false), image: Image(sbbName: "alarm-clock", size: .small), text: Text("Label"))
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image, record: recordNewReferenceSnapshots)
    }
    
    func testCheckBoxWithImageDark() {
        let view = SBBCheckBox(isOn: .constant(false), image: Image(sbbName: "alarm-clock", size: .small), text: Text("Label"))
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image, record: recordNewReferenceSnapshots)
    }
    
    func testCheckBoxDisabledLight() {
        let view = SBBCheckBox(isOn: .constant(true), image: Image(sbbName: "alarm-clock", size: .small), text: Text("Label"))
            .disabled(true)
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image, record: recordNewReferenceSnapshots)
    }
    
    func testCheckBoxDisabledDark() {
        let view = SBBCheckBox(isOn: .constant(true), image: Image(sbbName: "alarm-clock", size: .small), text: Text("Label"))
            .disabled(true)
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image, record: recordNewReferenceSnapshots)
    }
    
    func testCheckBoxSubTextLight() {
        let view = SBBCheckBox(isOn: .constant(true), text: Text("Ich möchte der SBB Informationen zum verwendeten Gerät übermitteln."), subText: Text("Modell: iPhone 11 Pro\niOS Version: 14.0"))
        assertSnapshot(matching: view.colorScheme(.light).toVC(), as: .image, record: recordNewReferenceSnapshots)
    }
                               
    func testCheckBoxSubTextDark() {
        let view = SBBCheckBox(isOn: .constant(true), text: Text("Ich möchte der SBB Informationen zum verwendeten Gerät übermitteln."), subText: Text("Modell: iPhone 11 Pro\niOS Version: 14.0"))
        assertSnapshot(matching: view.colorScheme(.dark).toVC(), as: .image, record: recordNewReferenceSnapshots)
    }
}
