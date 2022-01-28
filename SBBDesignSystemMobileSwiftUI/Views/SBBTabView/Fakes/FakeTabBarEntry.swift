//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

/**
 Fake TabBarEntries used in test, demo and previews for ``SBBTabView``.
 */
public struct FakeTabBarEntry {
    public static let fakeTab1 = TabBarEntryView(imageView: Image(sbbName: "station", size: .small), labelView: Text("Station"), tag: 0)
    public static let fakeTab2 = TabBarEntryView(imageView: Image(sbbName: "bus-stop", size: .small), labelView: Text("Stop"), tag: 1)
    public static let fakeTab3 = TabBarEntryView(imageView: Image(sbbName: "train", size: .small), labelView: Text("En route"), tag: 2)
    public static let fakeTab4 = TabBarEntryView(imageView: Image(sbbName: "fullscreen", size: .small), labelView: Text("Finder"), tag: 3)
    public static let fakeTab5 = TabBarEntryView(imageView: Image(sbbName: "lift", size: .small), labelView: Text("Elevator"), tag: 4)
    public static let fakeTab6 = TabBarEntryView(imageView: Image(sbbName: "gears", size: .small), labelView: Text("Settings"), tag: 5)
}
