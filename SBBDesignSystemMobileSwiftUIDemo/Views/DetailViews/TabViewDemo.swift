//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct TabViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var selectedTab = 0
    @State private var nbTabs = 5
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                SBBFormGroup(title: "Number of Tabs") {
                    Stepper(value: $nbTabs, in: 0...6, label: { Text("\(nbTabs)") }, onEditingChanged: resetSelection)
                        .sbbFont(.body)
                        .padding(10)
                }
                    .padding(.top, 10)
                
                SBBTabView(selection: $selectedTab, contentAboveBar: true) {
                    for entry in FakeTabBarEntry.fakeTabEntries.prefix(upTo: nbTabs) {
                        entry
                    }
                }
            }
                .sbbScreenPadding([.horizontal])
                .navigationBarTitle("TabView")
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                .sbbStyle()
                .colorScheme(colorScheme)
        }
    }
    
    private func resetSelection(_ editingBegins: Bool) {
        if !editingBegins {
            selectedTab = min(selectedTab, nbTabs - 1) 
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
