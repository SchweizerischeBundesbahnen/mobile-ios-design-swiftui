//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct FormGroupView: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var text = "My Value"
    @State private var emptyText = ""
    @State private var isOn = true
    
    var body: some View {
        VStack(spacing: 24) {
            SBBFormGroup(title: "Title:", hideDivider: true) {
                SBBTextField(text: $emptyText, label: "Placeholder")
                SBBCheckBox(isOn: $isOn, label: "CheckBox")
                SBBTextField(text: $text, label: "Placeholder")
                SBBCheckBox(isOn: $isOn, label: "CheckBox")
            }
            Text("No title:")
            SBBFormGroup(hideDivider: true) {
                SBBCheckBox(isOn: $isOn, label: "CheckBox")
                SBBTextField(text: $emptyText, label: "Placeholder")
                SBBCheckBox(isOn: $isOn, label: "CheckBox")
                SBBTextField(text: $text, label: "Placeholder")
            }
            SBBFormGroup(title: "One row:") {
                SBBTextArea(text: $text)
            }
            Spacer()
        }
        .padding(16)
        .navigationBarTitle("FormGroup")
        .background(SBBColor.background)
        .colorScheme(colorScheme)
    }
}

struct FormGroupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FormGroupView(colorScheme: .constant(.light))
            FormGroupView(colorScheme: .constant(.dark))
        }
    }
}
