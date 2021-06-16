//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct DialogueDemo: View {
    
    @State var showDialogue = false

    @Binding var colorScheme: ColorScheme
    @ObservedObject var model: DialogueViewModel
    
    private let title = Text("Title")
    private let label = Text("Multiline Text")
    private let errorCode = Text("ErrorCode: 404")
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 16) {
                    SBBFormGroup(title: "Style:") {
                        SBBRadioButton(isOn: $model.fullscreen, label: "Fullscreen")
                        SBBRadioButton(isOn: $model.inline, label: "Inline")
                        SBBRadioButton(isOn: $model.list, label: "List", showBottomLine: false)
                    }
                    Toggle(isOn: $model.showImage) {
                        Text("Show image:")
                            .sbbFont(.body)
                    }
                        .toggleStyle(SBBSwitchStyle())
                        .padding(.horizontal, 16)
                    if model.showImage {
                        SBBFormGroup {
                            SBBRadioButton(isOn: $model.happy, label: "Man happy")
                            SBBRadioButton(isOn: $model.sad, label: "Man sad", showBottomLine: false)
                        }
                    }
                    SBBFormGroup(title: "Content:") {
                        SBBRadioButton(isOn: $model.customActions, label: "Custom Actions")
                        SBBRadioButton(isOn: $model.retryAction, label: "Retry Action", showBottomLine: false)
                    }
                    if !showDialogue {
                        Button(action: { showDialogue = true }) {
                            Text("Show Dialogue")
                        }
                            .buttonStyle(SBBPrimaryButtonStyle())
                    }
                }
                    .padding(16)
                if showDialogue && !model.fullscreen {
                    SBBDialogue(title: title, label: label, errorCode: errorCode, style: model.inline ? .inline : .list, imageStyle: model.showImage ? (model.happy ? .happy : .sad) : nil) {
                        if model.customActions {
                        Button(action: { showDialogue = false }) {
                            Text("Button 3")
                        }
                            .buttonStyle(SBBSecondaryButtonStyle())
                        Button(action: { showDialogue = false }) {
                            Text("Button 2")
                        }
                            .buttonStyle(SBBSecondaryButtonStyle())
                        Button(action: { showDialogue = false }) {
                            Text("Button 1")
                        }
                            .buttonStyle(SBBPrimaryButtonStyle())
                        } else {    // model.retryAction
                            Button(action: { showDialogue = false }) {
                                Image(sbbName: "arrows-circle", size: .small)
                            }
                                .buttonStyle(SBBIconButtonStyle())
                        }
                    }
                }
            }
        }
            .sbbModal(isPresented: model.fullscreen ? $showDialogue : .constant(false)) {
                SBBDialogue(title: title, label: label, errorCode: errorCode, style: .fullscreen, imageStyle: model.showImage ? (model.happy ? .happy : .sad) : nil) {
                    if model.customActions {
                        Button(action: { showDialogue = false }) {
                            Text("Button 3")
                        }
                            .buttonStyle(SBBSecondaryButtonStyle())
                        Button(action: { showDialogue = false }) {
                            Text("Button 2")
                        }
                            .buttonStyle(SBBSecondaryButtonStyle())
                        Button(action: { showDialogue = false }) {
                            Text("Button 1")
                        }
                            .buttonStyle(SBBPrimaryButtonStyle())
                    } else {    // model.retryAction
                        Button(action: { showDialogue = false }) {
                            Image(sbbName: "arrows-circle", size: .small)
                        }
                            .buttonStyle(SBBIconButtonStyle())
                    }
                }
            }
            .sbbModalContainer()
            .navigationBarTitle("Dialogue")
            .sbbStyle()
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
