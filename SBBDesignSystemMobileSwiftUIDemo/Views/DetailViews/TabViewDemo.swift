//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct TabViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var selectedTab = 0
    @State private var nbTabs = 5.0
    
    let viewsArray = [
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
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                SBBFormGroup(title: "Number of Tabs") {
                    Stepper(value: $nbTabs, in: 2...6, label: { Text("\(Int(nbTabs))") }, onEditingChanged: { _ in resetSelection() })
                        .sbbFont(.body)
                        .padding(16)
                }
            }
            .sbbScreenPadding()
            .sbbStyle()
            
            switch (nbTabs) {
            case 2:
                SBBTabView(selection: $selectedTab) {
                    viewsArray[0]
                    viewsArray[1]
                }
            case 3:
                SBBTabView(selection: $selectedTab) {
                    viewsArray[0]
                    viewsArray[1]
                    viewsArray[2]
                }
            case 4:
                SBBTabView(selection: $selectedTab) {
                    viewsArray[0]
                    viewsArray[1]
                    viewsArray[2]
                    viewsArray[3]
                }
            case 5:
                SBBTabView(selection: $selectedTab) {
                    viewsArray[0]
                    viewsArray[1]
                    viewsArray[2]
                    viewsArray[3]
                    viewsArray[4]
                }
            case 6:
                SBBTabView(selection: $selectedTab) {
                    viewsArray[0]
                    viewsArray[1]
                    viewsArray[2]
                    viewsArray[3]
                    viewsArray[4]
                    viewsArray[5]
                }
            default:
                SBBTabView(selection: $selectedTab) {
                    viewsArray[0]
                    viewsArray[1]
                }
            }
        }
        .sbbScreenPadding()
        .sbbStyle()
        .colorScheme(colorScheme)
        
    }
    
    private func resetSelection() {
        if self.selectedTab >= Int(self.nbTabs) {
            self.selectedTab = Int(self.nbTabs) - 1
        }
    }
    
}

struct TabViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabViewDemo(colorScheme: .constant(.light))
            TabViewDemo(colorScheme: .constant(.dark))
        }
    }
}
