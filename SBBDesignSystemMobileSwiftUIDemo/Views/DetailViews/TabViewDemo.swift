//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct TabViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var selectedTab = 0
    
    var body: some View {
        SBBTabView(selection: self.$selectedTab) {
            VStack {
                Text("Bahnhof")
                Image(sbbName: "station", size:.small)
            }
            .sbbTag(0)
            .sbbTabItem(
                image: Image(sbbName: "station", size:.small),
                label: Text("Bahnhof")
            )
            
            VStack {
                Text("Haltestelle")
                Image(sbbName: "bus-stop", size:.small)
            }
            .sbbTag(1)
            .sbbTabItem(
                image: Image(sbbName: "bus-stop", size:.small),
                label: Text("Haltestelle")
            )
            
            VStack {
                Text("Unterwegs")
                Image(sbbName: "train", size:.small)
            }
            .sbbTag(2)
            .sbbTabItem(
                image: Image(sbbName: "train", size:.small),
                label: Text("Unterwegs")
            )
            
            VStack {
                Text("Türknopf")
                Image(sbbName: "fullscreen", size:.small)
            }
            .sbbTag(3)
            .sbbTabItem(
                image: Image(sbbName: "fullscreen", size:.small),
                label: Text("Türknopf")
            )
            
            VStack {
                Text("Einstellungen")
                Image(sbbName: "gears", size:.small)
            }
            .sbbTag(4)
            .sbbTabItem(
                image: Image(sbbName: "gears", size:.small),
                label: Text("Einstellungen")
            )
        }
        .edgesIgnoringSafeArea(.all)
        .colorScheme(colorScheme)
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
