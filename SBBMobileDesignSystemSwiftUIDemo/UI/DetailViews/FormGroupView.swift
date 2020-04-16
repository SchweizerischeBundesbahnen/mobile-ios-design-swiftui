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
        VStack {
            SBBFormGroup(title: "Title:") {
                Text("My Text").sbbFont(.body).padding(16)
                SBBTextField(text: $emptyText, label: "Placeholder")
                SBBTextField(text: $text, label: "Placeholder")
                SBBCheckBox(isOn: $isOn, label: "CheckBox")
            }
            Text("No title:").padding(16)
            SBBFormGroup() {
                Text("My Text").sbbFont(.body).padding(16)
                SBBTextField(text: $emptyText, label: "Placeholder")
                SBBTextField(text: $text, label: "Placeholder")
                SBBCheckBox(isOn: $isOn, label: "CheckBox")
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
