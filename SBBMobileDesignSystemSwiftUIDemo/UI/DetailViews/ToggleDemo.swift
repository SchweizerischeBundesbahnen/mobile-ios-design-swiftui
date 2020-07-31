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
                Toggle(isOn: $toggle2) {
                    Text("Toggle on disabled")
                }
                    .disabled(true)
                Toggle(isOn: $toggle3) {
                    Text("Toggle off")
                }
                Toggle(isOn: $toggle4) {
                    Text("Toggle off disabled")
                }
                    .disabled(true)
                Spacer()
            }
                .sbbFont(.body)
            Spacer()
        }
            .padding(16)
            .navigationBarTitle("Toggle")
            .background(SBBColor.background.edgesIgnoringSafeArea(.bottom))
            .colorScheme(colorScheme)
    }
}

struct ToggleDemo_Previews: PreviewProvider {
    static var previews: some View {
        ToggleDemo(colorScheme: .constant(.light))
    }
}
