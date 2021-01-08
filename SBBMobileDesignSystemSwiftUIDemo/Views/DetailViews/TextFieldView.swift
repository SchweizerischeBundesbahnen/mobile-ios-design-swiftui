//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct TextFieldView: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var text = "I like trains"
    @State private var disabled = false
    @EnvironmentObject var model: TextFieldViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                SBBFormGroup(title: "With placeholder") {
                    SBBTextField(text: $text, label: "Placeholder", error: model.error)
                        .disabled(disabled)
                }
                SBBFormGroup(title: "Without placeholder") {
                    SBBTextField(text: $text, error: model.error)
                        .disabled(disabled)
                }
                SBBFormGroup(title: "With placeholder & icon") {
                    SBBTextField(text: $text, label: "Placeholder", error: model.error, icon: Image(sbbName: "route-circle-start", size: .small))
                        .disabled(disabled)
                }
                SBBFormGroup(title: "Without placeholder, with icon") {
                    SBBTextField(text: $text, error: model.error, icon: Image(sbbName: "route-circle-start", size: .small))
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
                SBBCheckBox(isOn: $model.showError, label: "Show Error", showTextFieldLine: false)
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
        .environmentObject(TextFieldViewModel())
    }
}
