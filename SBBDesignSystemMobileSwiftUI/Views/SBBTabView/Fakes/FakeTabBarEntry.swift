//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

/**
 Fake TabBarEntries used in test, demo and previews for ``SBBTabView``.
 */
public struct FakeTabBarEntry {
    
    public static let fakeTabContent1 = (Image(sbbIcon: .avatar_police_small), "Station")
    public static let fakeTabContent2 = (Image(sbbIcon: .clock_small), "Stop")
    public static let fakeTabContent3 = (Image(sbbIcon: .train_small), "En route")
    public static let fakeTabContent4 = (Image(sbbIcon: .fullscreen_small), "Finder")
    public static let fakeTabContent5 = (Image(sbbIcon: .gears_small), "Settings")
    
    public static let fakeTab1 = TabBarEntryView(imageView: fakeTabContent1.0, label: fakeTabContent1.1, tag: 0)
    public static let fakeTab2 = TabBarEntryView(imageView: fakeTabContent2.0, label: fakeTabContent2.1, tag: 1)
    public static let fakeTab3 = TabBarEntryView(imageView: fakeTabContent3.0, label: fakeTabContent3.1, tag: 2)
    public static let fakeTab4 = TabBarEntryView(imageView: fakeTabContent4.0, label: fakeTabContent4.1, tag: 3)
    public static let fakeTab5 = TabBarEntryView(imageView: fakeTabContent5.0, label: fakeTabContent5.1, tag: 4)
    
    public static let fakeTabEntries = [fakeTab1,
                                        fakeTab2,
                                        fakeTab3,
                                        fakeTab4,
                                        fakeTab5]
    
    public static let fakeTabContents = [fakeTabContent1,
                                         fakeTabContent2,
                                         fakeTabContent3,
                                         fakeTabContent4,
                                         fakeTabContent5]
    
}
