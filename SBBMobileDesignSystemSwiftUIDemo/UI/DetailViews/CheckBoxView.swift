//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct CheckBoxView: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var isOn = true
    @State private var isOff = false
    @State private var isDisabled = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Checkbox").sbbFont(.tableHeader)
            SBBCheckBox(isOn: $isOn).padding(16).disabled(isDisabled)
            SBBCheckBox(isOn: $isOff).padding(16).disabled(isDisabled)
            SBBCheckBox(isOn: $isOn, label: "Label").disabled(isDisabled)
            SBBCheckBox(isOn: $isOff, label: "Label").disabled(isDisabled)
            SBBCheckBox(isOn: $isDisabled, label: "Disabled")
            Spacer()
        }
        .padding(16)
        .navigationBarTitle("CheckBox")
        .background(SBBColor.background.edgesIgnoringSafeArea(.bottom))
        .colorScheme(colorScheme)
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CheckBoxView(colorScheme: .constant(.light))
            CheckBoxView(colorScheme: .constant(.dark))
        }
    }
}
