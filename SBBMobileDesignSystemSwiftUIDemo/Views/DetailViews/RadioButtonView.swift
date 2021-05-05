//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct RadioButtonView: View {
    
    @Binding var colorScheme: ColorScheme
    @EnvironmentObject var model: RadioButtonViewModel
    @State private var isOff = false
    @State private var isDisabled = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Toggle(isOn: $isDisabled) {
                    Text("Disable RadioButtons")
                        .sbbFont(.body)
                }
                    .toggleStyle(SBBSwitchStyle())
                VStack(alignment: .leading, spacing: 0) {
                    SBBRadioButton(isOn: $model.isOn1, label: "Normal RadioButton", showBottomLine: false)
                        .disabled(isDisabled)
                    SBBRadioButton(isOn: $model.isOn2, image: Image(sbbName: "alarm-clock", size: .small), label: "RadioButton with Icon", showBottomLine: false)
                        .disabled(isDisabled)
                    SBBRadioButton(isOn: $model.isOn3, showBottomLine: false) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Custom RadioButton")
                                .sbbFont(.body)
                            Text("Favourite train: ICN")
                                .sbbFont(.legend)
                            Text("Best train company: SBB")
                                .sbbFont((.legend))
                        }
                    }
                        .disabled(isDisabled)
                }
                SBBFormGroup(title: "RadioButton in FormGroup") {
                    SBBRadioButton(isOn: $model.isOn1, label: "Normal RadioButton with line")
                        .disabled(isDisabled)
                    SBBRadioButton(isOn: $model.isOn2, image: Image(sbbName: "alarm-clock", size: .small), label: "RadioButton with Icon and line")
                        .disabled(isDisabled)
                    SBBRadioButton(isOn: $model.isOn3) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Custom RadioButton")
                                .sbbFont(.body)
                            Text("Favourite train: ICN")
                                .sbbFont(.legend)
                            Text("Best train company: SBB")
                                .sbbFont((.legend))
                        }
                    }
                        .disabled(isDisabled)
                }
                Spacer()
            }
                .padding(16)
        }
        .navigationBarTitle("RadioButton")
        .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.bottom))
        .colorScheme(colorScheme)
    }
}

struct RadioButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RadioButtonView(colorScheme: .constant(.light))
            RadioButtonView(colorScheme: .constant(.dark))
        }
            .environmentObject(RadioButtonViewModel())
    }
}
