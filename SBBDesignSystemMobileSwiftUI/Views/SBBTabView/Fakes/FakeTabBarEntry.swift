//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

struct FakeTabBarEntry {
    static let fakeTab1 = TabBarEntryView(imageView: Image(sbbName: "station", size: .small), labelView: Text("Station"), tag: 0)
    static let fakeTab2 = VStack{}.sbbTag(1).sbbTabItem(image: Image(sbbName: "bus-stop", size: .small), label: Text("Stop"))
}
