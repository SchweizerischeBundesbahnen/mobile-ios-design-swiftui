//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct DialogueDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @ObservedObject var model: DialogueViewModel
    
    private let title = Text("Title")
    private let label = Text("Multiline Text")
    private let errorCode = Text("ErrorCode: 404")
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 16) {
                        SBBFormGroup(title: "Style:") {
                            SBBRadioButton(isOn: $model.fullscreen, label: "Fullscreen", showTextFieldLine: false)
                            SBBRadioButton(isOn: $model.inline, label: "Inline", showTextFieldLine: false)
                            SBBRadioButton(isOn: $model.list, label: "List", showTextFieldLine: false)
                        }
                        Toggle(isOn: $model.showImage) {
                            Text("Show image:")
                                .sbbFont(.body)
                        }
                            .toggleStyle(SBBSwitchStyle())
                            .padding(.horizontal, 16)
                        if model.showImage {
                            SBBFormGroup {
                                SBBRadioButton(isOn: $model.happy, label: "Man happy", showTextFieldLine: false)
                                SBBRadioButton(isOn: $model.sad, label: "Man sad", showTextFieldLine: false)
                            }
                        }
                        SBBFormGroup(title: "Content:") {
                            SBBRadioButton(isOn: $model.customActions, label: "Custom Actions", showTextFieldLine: false)
                            SBBRadioButton(isOn: $model.retryAction, label: "Retry Action", showTextFieldLine: false)
                        }
                        if !model.showDialogue {
                            Button(action: { model.showDialogue = true }) {
                                Text("Show Dialogue")
                            }
                                .buttonStyle(SBBPrimaryButtonStyle())
                        }
                    }
                        .padding(16)
                    if model.showDialogue && !model.fullscreen {
                        SBBDialogue(title: title, label: label, errorCode: errorCode, style: model.inline ? .inline : .list, imageStyle: model.showImage ? (model.happy ? .happy : .sad) : nil) {
                            if model.customActions {
                            Button(action: { model.showDialogue = false }) {
                                Text("Button 3")
                            }
                                .buttonStyle(SBBSecondaryButtonStyle())
                            Button(action: { model.showDialogue = false }) {
                                Text("Button 2")
                            }
                                .buttonStyle(SBBSecondaryButtonStyle())
                            Button(action: { model.showDialogue = false }) {
                                Text("Button 1")
                            }
                                .buttonStyle(SBBPrimaryButtonStyle())
                            } else {    // model.retryAction
                                Button(action: { model.showDialogue = false }) {
                                    Image(sbbName: "arrows-circle", size: .small)
                                }
                                    .buttonStyle(SBBIconButtonStyle())
                            }
                        }
                    }
                }
            }
            if model.showDialogue && model.fullscreen {
                SBBDialogue(title: title, label: label, errorCode: errorCode, style: .fullscreen, imageStyle: model.showImage ? (model.happy ? .happy : .sad) : nil) {
                    if model.customActions {
                        Button(action: { model.showDialogue = false }) {
                            Text("Button 3")
                        }
                            .buttonStyle(SBBSecondaryButtonStyle())
                        Button(action: { model.showDialogue = false }) {
                            Text("Button 2")
                        }
                            .buttonStyle(SBBSecondaryButtonStyle())
                        Button(action: { model.showDialogue = false }) {
                            Text("Button 1")
                        }
                            .buttonStyle(SBBPrimaryButtonStyle())
                    } else {    // model.retryAction
                        Button(action: { model.showDialogue = false }) {
                            Image(sbbName: "arrows-circle", size: .small)
                        }
                            .buttonStyle(SBBIconButtonStyle())
                    }
                }
            }
        }
        .navigationBarTitle("Dialogue")
        .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.bottom))
        .colorScheme(colorScheme)
    }
}

struct DialogueDemo_Previews: PreviewProvider {
    
    private static var model = DialogueViewModel()
    
    static var previews: some View {
        DialogueDemo(colorScheme: .constant(.light), model: model)
        DialogueDemo(colorScheme: .constant(.dark), model: model)
    }
}
