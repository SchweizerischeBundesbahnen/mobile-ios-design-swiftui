//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

/**
 Fake TabBarEntries used in test, demo and previews for ``SBBTabView``.
 */
public struct FakeTabBarEntry {
    public static let fakeTab1 = TabBarEntryView(imageView: Image(sbbIcon: .station_small), label: "Station", tag: 0)
    public static let fakeTab2 = TabBarEntryView(imageView: Image(sbbIcon: .bus_stop_small), label: "Stop", tag: 1)
    public static let fakeTab3 = TabBarEntryView(imageView: Image(sbbIcon: .train_small), label: "En route", tag: 2)
    public static let fakeTab4 = TabBarEntryView(imageView: Image(sbbIcon: .fullscreen_small), label: "Finder", tag: 3)
    public static let fakeTab5 = TabBarEntryView(imageView: Image(sbbIcon: .lift_small), label: "Elevator", tag: 4)
    public static let fakeTab6 = TabBarEntryView(imageView: Image(sbbIcon: .gears_small), label: "Settings", tag: 5)
    
    public static let fakeTabEntries = [fakeTab1,
                                        fakeTab2,
                                        fakeTab3,
                                        fakeTab4,
                                        fakeTab5,
                                        fakeTab6]
}
