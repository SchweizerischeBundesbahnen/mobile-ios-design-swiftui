//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct DialogueDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @Binding var contentSizeCategory: ContentSizeCategory

    @State var showDialogue = false
    @State var showImage = true
    @State var style = SBBDialogue<EmptyView>.Style.inline
    @State var imageStyle = SBBDialogue<EmptyView>.ImageStyle.happy
    @State var actionType = 0 // 0: customActions, 1: retryAction
    
    private let title = Text("Title")
    private let label = Text("Multiline Text")
    private let errorCode = Text("ErrorCode: 404")
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 16) {
                    SBBRadioButtonGroup(title: "Style", selection: $style, tags: SBBDialogue<EmptyView>.Style.allCases) {
                        SBBRadioButton(text: Text("Fullscreen"))
                        SBBRadioButton(text: Text("Inline"))
                        SBBRadioButton(text: Text("List"), showBottomLine: false)
                    }
                    Toggle(isOn: $showImage) {
                        Text("Show image:")
                            .sbbFont(.medium_light)
                    }
                        .toggleStyle(SBBSwitchStyle())
                        .padding(.horizontal, 16)
                    if showImage {
                        SBBRadioButtonGroup(selection: $imageStyle, tags: SBBDialogue<EmptyView>.ImageStyle.allCases) {
                            SBBRadioButton(text: Text("Man happy"))
                            SBBRadioButton(text: Text("Man sad"), showBottomLine: false)
                        }
                    }
                    
                    
                    SBBRadioButtonGroup(title: "Content", selection: $actionType, tags: [0, 1]) {
                        SBBRadioButton(text: Text("Custom Actions"))
                        SBBRadioButton(text: Text("Retry Action"), showBottomLine: false)
                    }
                    if !showDialogue {
                        Button(action: { showDialogue = true }) {
                            Text("Show Dialogue")
                        }
                            .buttonStyle(SBBPrimaryButtonStyle())
                    }
                }
                    .sbbScreenPadding()
                if showDialogue && !(style == .fullscreen) {
                    SBBDialogue(title: title, label: label, errorCode: errorCode, style: style == .inline ? .inline : style == .fullscreen ? .fullscreen : .list, imageStyle: showImage ? (imageStyle == .happy ? .happy : .sad) : nil) {
                        if actionType == 0 {    // customActions
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
                        } else {    // retryAction
                            Button(action: { showDialogue = false }) {
                                Image(sbbIcon: .arrow_circle_small)
                            }
                                .buttonStyle(SBBIconButtonStyle())
                        }
                    }
                }
            }
        }
            .sbbModal(isPresented: style == .fullscreen ? $showDialogue : .constant(false)) {
                SBBDialogue(title: title, label: label, errorCode: errorCode, style: .fullscreen, imageStyle: showImage ? (imageStyle == .happy ? .happy : .sad) : nil) {
                    if actionType == 0 {    // customActions
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
                            Image(sbbIcon: .arrow_circle_small)
                        }
                            .buttonStyle(SBBIconButtonStyle())
                    }
                }
                    .colorScheme(colorScheme)
                    .environment(\.sizeCategory, contentSizeCategory)
            }
            .navigationBarTitle("Dialogue")
            .sbbStyle()
            .colorScheme(colorScheme)
    }
}

struct DialogueDemo_Previews: PreviewProvider {
        
    static var previews: some View {
        DialogueDemo(colorScheme: .constant(.light), contentSizeCategory: .constant(.medium))
        DialogueDemo(colorScheme: .constant(.dark), contentSizeCategory: .constant(.medium))
    }
}
