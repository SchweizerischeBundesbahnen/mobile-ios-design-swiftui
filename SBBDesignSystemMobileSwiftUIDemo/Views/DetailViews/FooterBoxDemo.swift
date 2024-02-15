//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2024.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct FooterBoxDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    @State private var showTabBar: Bool = true
    @State private var selectedTab: Int = 0
    
    private struct ContentView: View {
        @Binding var showTabBar: Bool
        
        @State private var showFooter: Bool = false
        @State private var count: Int = 0
        
        var body: some View {
            VStack {
                SBBFormGroup {
                    Toggle("Tab bar", isOn: $showTabBar)
                        .toggleStyle(SBBSwitchStyle())
                        .sbbScreenPadding()
                }
                Spacer()
                if !showFooter {
                    Button(action: {
                        count = 0
                        showFooter = true
                    }) {
                        Text("Show Footer")
                    }
                    .buttonStyle(SBBTertiaryButtonStyle())
                } else {
                    SBBFormGroup {
                        Text("This text is disabled for accessibility as it is in the background.")
                            .sbbScreenPadding()
                    }
                }
                Spacer()
            }
            .sbbScreenPadding()
            .background(Color.sbbColor(.background))
            .footer(isPresented: $showFooter) {
                SBBFooterBox(content: {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Title")
                            Spacer()
                            Button(action: {
                                showFooter = false
                            }) {
                                Image(sbbIcon: .cross_small)
                            }
                                .buttonStyle(SBBIconButtonStyle(size: .small))
                        }
                        Text("This is some information. Button clicked: \(count) times.")
                        Button(action: {
                            count += 1
                        }) {
                            Text("Some action")
                        }
                            .buttonStyle(SBBPrimaryButtonStyle())
                    }
                }, hasTabBar: showTabBar)
            }
        }
        
    }
    
    var body: some View {
        Group {
            if showTabBar {
                SBBTabView(selection: $selectedTab) {
                    ContentView(showTabBar: $showTabBar)
                        .sbbTabItem(image: Image(sbbIcon: .city_small), label: "Tab 1", tag: 0)
                    
                    ContentView(showTabBar: $showTabBar)
                        .sbbTabItem(image: Image(sbbIcon: .house_small), label: "Tab 2", tag: 1)
                }
            } else {
                ContentView(showTabBar: $showTabBar)
            }
        }
        .navigationBarTitle("Footer")
        .sbbStyle()
        .colorScheme(colorScheme)
    }
}

struct FooterDemo_Previews: PreviewProvider {
    @State static var lightScheme: ColorScheme = .light
    @State static var darkScheme: ColorScheme = .dark
    
    static var previews: some View {
        Group {
            FooterBoxDemo(colorScheme: $lightScheme)
                .previewDisplayName("Light")
            FooterBoxDemo(colorScheme: $darkScheme)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
