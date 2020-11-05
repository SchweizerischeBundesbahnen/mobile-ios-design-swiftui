//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct TextFieldView: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var text = "I like trains"
    @State private var disabled = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                SBBFormGroup(title: "With placeholder") {
                    SBBTextField(text: $text, label: "Placeholder")
                        .disabled(disabled)
                }
                SBBFormGroup(title: "Without placeholder") {
                    SBBTextField(text: $text)
                        .disabled(disabled)
                }
                Text("Content is: \(text)")
                Button("Set default text") {
                    self.text = "I like trains"
                }
                    .buttonStyle(SBBTertiaryButtonStyle(size: .small))
                Button("Clear text") {
                    self.text = ""
                }
                    .buttonStyle(SBBTertiaryButtonStyle(size: .small))
                SBBCheckBox(isOn: $disabled, label: "Disabled", showTextFieldLine: false)
            }
        }
        .padding(16)
        .navigationBarTitle("TextField")
        .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.bottom))
        .colorScheme(colorScheme)
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextFieldView(colorScheme: .constant(.light))
            TextFieldView(colorScheme: .constant(.dark))
        }
    }
}
