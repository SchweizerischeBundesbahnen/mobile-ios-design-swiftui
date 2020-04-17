//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct ButtonDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var counter = 0
    @State private var disabled = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            
            // init using button style
            Button(action: increment) {
                Text("My button with style")
            }
            .buttonStyle(SBBPrimaryButtonStyle())
            .disabled(disabled)
            
            // init using shortcut
            Button(action: increment) {
                Text("My .sbbPrimary() button")
            }
            .sbbPrimary()
            .disabled(disabled)
            
            Spacer()
            Text("Counter: \(counter)").padding()
            SBBCheckBox(isOn: $disabled, label: "Disabled")
            Spacer()
        }
        .padding(16)
        .navigationBarTitle("Buttons")
        .background(SBBColor.background)
        .colorScheme(colorScheme)
    }
    
    private func increment() {
        counter += 1
    }
}

struct ButtonDemo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ButtonDemo(colorScheme: .constant(.light))
            ButtonDemo(colorScheme: .constant(.dark))
        }
    }
}
