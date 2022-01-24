//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import XCTest
import SnapshotTesting
import SwiftUI
import SBBDesignSystemMobileSwiftUI

class SBBTabViewTests: XCTestCase {
    
    private let viewsArray = [
        VStack {
            Text("Station")
            Image(sbbName: "station", size:.small)
        }
            .sbbTag(0)
            .sbbTabItem(
                image: Image(sbbName: "station", size:.small),
                label: Text("Station")
            ),
        
        VStack {
            Text("Stop")
            Image(sbbName: "bus-stop", size:.small)
        }
            .sbbTag(1)
            .sbbTabItem(
                image: Image(sbbName: "bus-stop", size:.small),
                label: Text("Stop")
            ),
        
        VStack {
            Text("En route")
            Image(sbbName: "train", size:.small)
        }
            .sbbTag(2)
            .sbbTabItem(
                image: Image(sbbName: "train", size:.small),
                label: Text("En route")
            ),
        
        VStack {
            Text("Finder")
            Image(sbbName: "fullscreen", size:.small)
        }
            .sbbTag(3)
            .sbbTabItem(
                image: Image(sbbName: "fullscreen", size:.small),
                label: Text("Finder")
            ),
        
        VStack {
            Text("Elevator")
            Image(sbbName: "lift", size:.small)
        }
            .sbbTag(4)
            .sbbTabItem(
                image: Image(sbbName: "lift", size:.small),
                label: Text("Elevator")
            ),
        
        VStack {
            Text("Settings")
            Image(sbbName: "gears", size:.small)
        }
            .sbbTag(5)
            .sbbTabItem(
                image: Image(sbbName: "gears", size:.small),
                label: Text("Settings")
            )
    ]
    
    private func getSBBTabView(nbTabs: Int) -> SBBTabView<Int> {
        switch (nbTabs) {
        case 2:
            return SBBTabView(selection: .constant(0)) {
                viewsArray[0]
                viewsArray[1]
            }
        case 3:
            return SBBTabView(selection: .constant(0)) {
                viewsArray[0]
                viewsArray[1]
                viewsArray[2]
            }
        case 4:
            return SBBTabView(selection: .constant(0)) {
                viewsArray[0]
                viewsArray[1]
                viewsArray[2]
                viewsArray[3]
            }
        case 5:
            return SBBTabView(selection: .constant(0)) {
                viewsArray[0]
                viewsArray[1]
                viewsArray[2]
                viewsArray[3]
                viewsArray[4]
            }
        case 6:
            return SBBTabView(selection: .constant(0)) {
                viewsArray[0]
                viewsArray[1]
                viewsArray[2]
                viewsArray[3]
                viewsArray[4]
                viewsArray[5]
            }
        default:
            return SBBTabView(selection: .constant(0)) {
                viewsArray[0]
                viewsArray[1]
            }
        }
    }
    
    func testTabView() {
        for nbTabs in (2...6) {
            let view = getSBBTabView(nbTabs: nbTabs)
            
            for colorScheme in ColorScheme.allCases {
                assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image, record: recordNewReferenceSnapshots)
            }
        }
    }
    
    func testTabViewLandscape() {
        for nbTabs in (2...6) {
            let view = getSBBTabView(nbTabs: nbTabs)
            
            for colorScheme in ColorScheme.allCases {
                assertSnapshot(matching: view.colorScheme(colorScheme).toVC(), as: .image(on: .iPhoneX(.landscape)), record: recordNewReferenceSnapshots)
            }
        }
    }
}
