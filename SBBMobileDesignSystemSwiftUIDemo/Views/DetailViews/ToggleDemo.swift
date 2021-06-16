//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct ToggleDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    @State private var toggle1 = true
    @State private var toggle2 = true
    @State private var toggle3 = false
    @State private var toggle4 = false
    
    var body: some View {
        HStack {
            Spacer()
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
                Spacer()
            }
                .sbbFont(.body)
            Spacer()
        }
            .padding(16)
            .navigationBarTitle("Toggle")
            .sbbStyle()
            .colorScheme(colorScheme)
    }
}

struct ToggleDemo_Previews: PreviewProvider {
    static var previews: some View {
        ToggleDemo(colorScheme: .constant(.light))
    }
}
