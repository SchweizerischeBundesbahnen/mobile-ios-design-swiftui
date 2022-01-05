//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct CheckBoxView: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var isOn = true
    @State private var isOff = false
    @State private var isDisabled = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Toggle(isOn: $isDisabled) {
                    Text("Disable Checkboxes")
                        .sbbFont(.body)
                }
                    .toggleStyle(SBBSwitchStyle())
                VStack(alignment: .leading, spacing: 0) {
                    SBBCheckBox(isOn: $isOn, text: Text("Normal Checkbox"), showBottomLine: false)
                        .disabled(isDisabled)
                    SBBCheckBox(isOn: $isOn, image: Image(sbbName: "alarm-clock", size: .small), text: Text("Checkbox with Icon"), showBottomLine: false)
                        .disabled(isDisabled)
                    SBBCheckBox(isOn: $isOn, text: Text("Checkbox with subText"), subText: Text("Modell: iPhone 11 Pro\niOS Version: 14.0"), showBottomLine: false)
                        .disabled(isDisabled)
                }
                SBBFormGroup(title: "Checkbox in FormGroup") {
                    SBBCheckBox(isOn: $isOn, text: Text("Normal Checkbox with line"))
                        .disabled(isDisabled)
                    SBBCheckBox(isOn: $isOn, image: Image(sbbName: "alarm-clock", size: .small), text: Text("Checkbox with Icon and line"))
                        .disabled(isDisabled)
                    SBBCheckBox(isOn: $isOn, text: Text("Checkbox with subText"), subText: Text("Modell: iPhone 11 Pro\niOS Version: 14.0"), showBottomLine: false)
                        .disabled(isDisabled)
                }
                Spacer()
            }
                .sbbScreenPadding()
        }
        .navigationBarTitle("CheckBox")
        .sbbStyle()
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
