//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct TextFieldView: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var text1 = ""
    @State private var text2 = "My nice Text"
    @State private var text3 = ""
    @State private var text4 = "My nice Text"
    @State private var disabled = false
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Without placeholder:")
            SBBTextField(text: $text1).disabled(disabled)
            SBBTextField(text: $text2).disabled(disabled)
            Text("With placeholder:")
            SBBTextField(text: $text3, label: "Placeholder").disabled(disabled)
            SBBTextField(text: $text4, label: "Placeholder").disabled(disabled)
            SBBCheckBox(isOn: $disabled, label: "Disabled", showTextFieldLine: false)
            Spacer()
        }
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
