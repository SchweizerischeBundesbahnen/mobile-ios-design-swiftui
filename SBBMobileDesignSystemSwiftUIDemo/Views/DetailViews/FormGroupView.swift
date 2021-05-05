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
        Group {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    SBBFormGroup(title: "Title:") {
                        SBBTextField(text: self.$emptyText, label: "Placeholder")
                        SBBCheckBox(isOn: self.$isOn, label: "CheckBox")
                        SBBTextField(text: self.$text, label: "Placeholder")
                        SBBCheckBox(isOn: self.$isOn, label: "CheckBox", showBottomLine: false)
                    }
                    Text("No title:")
                    SBBFormGroup {
                        SBBCheckBox(isOn: self.$isOn, label: "CheckBox")
                        SBBTextField(text: self.$emptyText, label: "Placeholder")
                        SBBCheckBox(isOn: self.$isOn, label: "CheckBox")
                        SBBTextField(text: self.$text, label: "Placeholder", showBottomLine: false)
                    }
                    SBBFormGroup(title: "One row:") {
                        SBBTextArea(text: self.$text, label: "Placeholder", showBottomLine: false)
                            .frame(height: 100)
                    }
                    Spacer()
                }
                    .padding(16)
            }
                .navigationBarTitle("FormGroup")
                .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.bottom))
                .colorScheme(colorScheme)
        }
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
