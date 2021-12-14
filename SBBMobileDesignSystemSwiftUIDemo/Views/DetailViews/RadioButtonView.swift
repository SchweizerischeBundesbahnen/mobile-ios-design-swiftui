//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct RadioButtonView: View {
    
    enum TrainCompany: CaseIterable {
        case SBB
        case SNCF
    }
    
    @Binding var colorScheme: ColorScheme
    
    @State private var isDisabled = false
    
    // Single SBBRadioButton
    @State private var radioButton1IsSelected = true
    @State private var radioButton2IsSelected = false
    
    // SBBRadioButtonGroup
    @State private var selectedRadioButton = 0
    @State private var selectedCustomRadioButton: TrainCompany = .SBB
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Toggle(isOn: $isDisabled) {
                    Text("Disable RadioButtons")
                        .sbbFont(.body)
                }
                    .toggleStyle(SBBSwitchStyle())
                VStack(alignment: .leading, spacing: 0) {
                    SBBRadioButton(text: Text("Normal RadioButton"), showBottomLine: false)
                        .isSelected(radioButton1IsSelected)
                        .highPriorityGesture(
                            TapGesture().onEnded {
                                withAnimation {
                                    radioButton1IsSelected = true
                                    radioButton2IsSelected = false
                                }
                            }
                        )
                    SBBRadioButton(image: Image(sbbName: "alarm-clock", size: .small), text: Text("RadioButton with Icon"), showBottomLine: false)
                        .isSelected(radioButton2IsSelected)
                        .highPriorityGesture(
                            TapGesture().onEnded {
                                withAnimation {
                                    radioButton1IsSelected = false
                                    radioButton2IsSelected = true
                                }
                            }
                        )
                }
                    .disabled(isDisabled)
                SBBRadioButtonGroup(title: "SBBRadioButtonGroup", selection: $selectedRadioButton, tags: [0, 1, 2]) {
                    SBBRadioButton(text: Text("Normal RadioButton with line"))
                    SBBRadioButton(image: Image(sbbName: "alarm-clock", size: .small), text: Text("RadioButton with Icon and line"))
                    SBBRadioButton(text: Text("RadioButton without line"), showBottomLine: false)
                }
                    .disabled(isDisabled)
                SBBRadioButtonGroup(title: "With custom SBBRadioButtons", selection: $selectedCustomRadioButton, tags: TrainCompany.allCases) {
                    SBBRadioButton(text: Text("RadioButton with subText"), subText: Text("Favourite train: ICN\nBest train company: SBB"))
                    SBBRadioButton(text: Text("RadioButton with subText"), subText: Text("Favourite train: TGV\nBest train company: SNCF"), showBottomLine: false) 
                }
                    .disabled(isDisabled)
                Spacer()
            }
                .sbbScreenPadding()
        }
        .navigationBarTitle("RadioButton")
        .sbbStyle()
        .colorScheme(colorScheme)
    }
}

struct RadioButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RadioButtonView(colorScheme: .constant(.light))
            RadioButtonView(colorScheme: .constant(.dark))
        }
    }
}
