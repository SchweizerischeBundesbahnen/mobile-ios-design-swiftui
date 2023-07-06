//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct TabViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    @State private var selectedTab = 0
    @State private var showSettings = false
    @State private var nbTabs = 5
    @State private var selectedExtra = 0
    @State private var selectedBadgeNumber = 0
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                SBBTabView(selection: $selectedTab, contentAboveBar: true) {
                    for index in 0..<nbTabs {
                        if selectedExtra == 1 {
                            let content = FakeTabBarEntry.fakeTabContents[index]
                            VStack {
                                Text(content.1)
                                content.0
                            }
                            .sbbTabItem(image: content.0, label: content.1, tag: index, warningBackground: true)
                        } else if selectedExtra == 2 {
                            let content = FakeTabBarEntry.fakeTabContents[index]
                            VStack {
                                Text(content.1)
                                content.0
                            }
                            .sbbTabItem(image: content.0, label: content.1, tag: index, badge: true, badgeView: selectedBadgeNumber == 0 ? nil : selectedBadgeNumber == 1 ? AnyView(Image(sbbIcon: .tick_small)
                                            .resizable()
                                            .frame(width: 16, height: 16)) :
                                AnyView(Text("\(selectedBadgeNumber)")
                                    .bold()
                                    .sbbFont(.legend)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.1)
                            ))
                        } else {
                            FakeTabBarEntry.fakeTabEntries[index]
                        }
                    }
                }
                
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            showSettings = true
                        }) {
                            Image(sbbIcon: .controls_medium)
                        }
                        .buttonStyle(SBBIconButtonStyle())
                        .padding(10)
                        
                    }
                    Spacer()
                }
            }
                .sbbScreenPadding(.horizontal)
                .navigationBarTitle("TabView")
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                .sbbStyle()
                .colorScheme(colorScheme)
        }
        .sbbModal(isPresented: $showSettings) {
            SBBModalView(title: Text("Settings"), style: .bottom, isPresented: $showSettings) {
                VStack(spacing: 10) {
                    SBBFormGroup(title: "Number of tabs") {
                        Stepper(value: $nbTabs, in: 0...5, label: { Text("\(nbTabs)") }, onEditingChanged: resetSelection)
                            .sbbFont(.body)
                            .padding(10)
                    }
                    
                    SBBFormGroup(title: "Extra features") {
                        SBBRadioButtonGroup(selection: $selectedExtra, tags: [0, 1, 2]) {
                            SBBRadioButton(text: Text("Normal"))
                                .tag(0)
                            SBBRadioButton(text: Text("With warning background"))
                                .tag(1)
                            SBBRadioButton(text: Text("With badges"), showBottomLine: false)
                                .tag(2)
                        }
                    }
                    
                    if selectedExtra == 2 {
                        SBBFormGroup(title: "View on badge") {
                            SBBRadioButtonGroup(selection: $selectedBadgeNumber, tags: [0, 8, 24, 136, 1]) {
                                SBBRadioButton(text: Text("nil"))
                                    .tag(0)
                                SBBRadioButton(text: Text("8"))
                                    .tag(8)
                                SBBRadioButton(text: Text("24"))
                                    .tag(24)
                                SBBRadioButton(text: Text("136"), showBottomLine: false)
                                    .tag(136)
                                SBBRadioButton(text: Text("checkmark"), showBottomLine: false)
                                    .tag(1)
                            }
                        }
                    }
                }
                .padding(10)
                .padding(.bottom, 16)
            }
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
