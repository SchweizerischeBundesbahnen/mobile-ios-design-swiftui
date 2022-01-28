//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct TabViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var selectedTab = 0
    @State private var nbTabs = 5.0
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                SBBFormGroup(title: "Number of Tabs") {
                    Stepper(value: $nbTabs, in: 2...6, label: { Text("\(Int(nbTabs))") }, onEditingChanged: { _ in resetSelection() })
                        .sbbFont(.body)
                        .padding(10)
                }
            }
            .sbbScreenPadding()
            .sbbStyle()
            
            switch (nbTabs) {
            case 2:
                SBBTabView(selection: $selectedTab) {
                    FakeTabBarEntry.fakeTab1
                    FakeTabBarEntry.fakeTab2
                }
            case 3:
                SBBTabView(selection: $selectedTab) {
                    FakeTabBarEntry.fakeTab1
                    FakeTabBarEntry.fakeTab2
                    FakeTabBarEntry.fakeTab3
                }
            case 4:
                SBBTabView(selection: $selectedTab) {
                    FakeTabBarEntry.fakeTab1
                    FakeTabBarEntry.fakeTab2
                    FakeTabBarEntry.fakeTab3
                    FakeTabBarEntry.fakeTab4
                }
            case 5:
                SBBTabView(selection: $selectedTab) {
                    FakeTabBarEntry.fakeTab1
                    FakeTabBarEntry.fakeTab2
                    FakeTabBarEntry.fakeTab3
                    FakeTabBarEntry.fakeTab4
                    FakeTabBarEntry.fakeTab5
                }
            case 6:
                SBBTabView(selection: $selectedTab) {
                    FakeTabBarEntry.fakeTab1
                    FakeTabBarEntry.fakeTab2
                    FakeTabBarEntry.fakeTab3
                    FakeTabBarEntry.fakeTab4
                    FakeTabBarEntry.fakeTab5
                    FakeTabBarEntry.fakeTab6
                }
            default:
                SBBTabView(selection: $selectedTab) {
                    FakeTabBarEntry.fakeTab1
                    FakeTabBarEntry.fakeTab2
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
            
            if #available(iOS 15.0, *) {
                TabViewDemo(colorScheme: .constant(.light))
                    .previewInterfaceOrientation(.landscapeLeft)
                TabViewDemo(colorScheme: .constant(.dark))
                    .previewInterfaceOrientation(.landscapeLeft)
            }
        }
    }
}
