//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct ToggleDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    @State private var toggle1 = true
    @State private var toggle2 = true
    @State private var toggle3 = false
    @State private var toggle4 = false
    
    @State private var toggle5 = false
    @State private var toggle6 = false
    @State private var toggle7 = false
    @State private var toggle8 = false
    
    @State private var errorMessage1: Text? = nil
    @State private var errorMessage2: Text? = nil
    @State private var errorCode1: Text? = nil
    @State private var errorCode2: Text? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Toggle(isOn: $toggle1) {
                    Text("Toggle on")
                }
                    .toggleStyle(SBBSwitchStyle())
                Toggle(isOn: $toggle2) {
                    Text("Toggle on disabled")
                }
                    .toggleStyle(SBBSwitchStyle())
                    .disabled(true)
                Toggle(isOn: $toggle3) {
                    Text("Toggle off")
                }
                    .toggleStyle(SBBSwitchStyle())
                Toggle(isOn: $toggle4) {
                    Text("Toggle off disabled")
                }
                    .toggleStyle(SBBSwitchStyle())
                    .disabled(true)
                
                HStack {
                    Spacer()
                    Toggle("", isOn: $toggle1)
                        .toggleStyle(SBBSwitchButtonStyle())
                    Spacer()
                    Toggle("", isOn: $toggle2)
                        .toggleStyle(SBBSwitchButtonStyle())
                        .disabled(true)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Toggle("", isOn: $toggle3)
                        .toggleStyle(SBBSwitchButtonStyle())
                    Spacer()
                    Toggle("", isOn: $toggle4)
                        .toggleStyle(SBBSwitchButtonStyle())
                        .disabled(true)
                    Spacer()
                }
                
                VStack(spacing: 0) {
                    SBBSwitchItem(isOn: $toggle5, label: Text("Label"), labelAccessibility: nil, image: Image(sbbIcon: .unicorn_small), showTopLine: true, actionOnEnable: returnTrueAfterDelay, actionOnDisable: returnTrueAfterDelay)
                    SBBSwitchItem(isOn: $toggle2, label: Text("Label on disabled"), labelAccessibility: nil, image: Image(sbbIcon: .unicorn_small), actionOnEnable: returnTrueAfterDelay, actionOnDisable: returnTrueAfterDelay)
                        .disabled(true)
                    SBBSwitchItem(isOn: $toggle6, label: Text("Label error"), labelAccessibility: nil, image: Image(sbbIcon: .unicorn_small), errorMessage: errorMessage1, errorCode: errorCode1, actionOnEnable: returnFalseAfterDelay1, actionOnDisable: returnFalseAfterDelay1)
                }
                
                SBBSwitchItem(isOn: $toggle7, label: Text("Label"), labelAccessibility: nil, image: Image(sbbIcon: .unicorn_small), type: .standalone, actionOnEnable: returnTrueAfterDelay, actionOnDisable: returnTrueAfterDelay)
                SBBSwitchItem(isOn: $toggle2, label: Text("Label off disabled"), labelAccessibility: nil, image: Image(sbbIcon: .unicorn_small), type: .standalone, actionOnEnable: returnTrueAfterDelay, actionOnDisable: returnTrueAfterDelay)
                    .disabled(true)
                SBBSwitchItem(isOn: $toggle8, label: Text("Label error"), labelAccessibility: nil, image: Image(sbbIcon: .unicorn_small), type: .standalone, errorMessage: errorMessage2, errorCode: errorCode2, actionOnEnable: returnFalseAfterDelay2, actionOnDisable: returnFalseAfterDelay2)
                Spacer()
            }
                .sbbFont(.medium_light)
        }
            .sbbScreenPadding()
            .navigationBarTitle("Toggle")
            .sbbStyle()
            .colorScheme(colorScheme)
    }
    
    func returnTrueAfterDelay() async -> Bool {
        try? await Task.sleep(nanoseconds: 800_000_000)
        return true
    }
    
    func returnFalseAfterDelay1() async -> Bool {
        try? await Task.sleep(nanoseconds: 800_000_000)
        self.errorMessage1 = Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut.")
        self.errorCode1 = Text("Fehler-Code 12334")
        return false
    }
    
    func returnFalseAfterDelay2() async -> Bool {
        try? await Task.sleep(nanoseconds: 800_000_000)
        self.errorMessage2 = Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut.")
        self.errorCode2 = Text("Fehler-Code 12334")
        return false
    }
}

struct ToggleDemo_Previews: PreviewProvider {
    static var previews: some View {
        ToggleDemo(colorScheme: .constant(.light))
    }
}
