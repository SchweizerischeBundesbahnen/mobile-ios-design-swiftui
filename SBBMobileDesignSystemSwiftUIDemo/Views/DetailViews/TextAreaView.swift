//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct TextAreaView: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var text = "I like trains"
    @State private var emptyText = ""
    @State private var disabled = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                SBBFormGroup(title: "With placeholder") {
                    SBBTextArea(text: $text, label: "Placeholder")
                        .frame(height: 100)
                        .disabled(disabled)
                }
                SBBFormGroup(title: "Without placeholder") {
                    SBBTextArea(text: $text)
                        .frame(height: 100)
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
        .navigationBarTitle("TextArea")
        .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.bottom))
        .colorScheme(colorScheme)
    }
}

struct TextAreaView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextAreaView(colorScheme: .constant(.light))
            TextAreaView(colorScheme: .constant(.dark))
        }
    }
}