//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct TextAreaView: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var text = "My nice text"
    @State private var emptyText = ""
    @State private var disabled = false
    
    var body: some View {
        VStack {
            SBBTextArea(text: $text, label: "Placeholder")
                .frame(maxHeight: 100)
                .disabled(disabled)
            Text("Content is: \(text)")
            Button("Set default text") {
                self.text = "My Nice text"
            }
            Button("Clear text") {
                self.text = ""
            }
            SBBTextArea(text: $emptyText, label: "Placeholder")
                .frame(maxHeight: 100)
                .disabled(disabled)
            Text("Without label:")
            SBBTextArea(text: $text)
                .frame(maxHeight: 100)
                .disabled(disabled)
            SBBCheckBox(isOn: $disabled, label: "Disabled", showTextFieldLine: false)
            Spacer()
        }
        .padding(16)
        .navigationBarTitle("TextArea")
        .background(SBBColor.background.edgesIgnoringSafeArea(.bottom))
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
