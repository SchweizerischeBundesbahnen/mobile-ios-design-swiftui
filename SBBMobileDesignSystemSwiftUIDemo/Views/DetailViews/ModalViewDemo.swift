//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct ModalViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @Binding var contentSizeCategory: ContentSizeCategory
    @State var showingModalFullView = false
    @State var showingModalPopupView = false
    @State var showingModalSheetView = false
    @State var showingModalCustomView = false
    @State var showBackButton = false
    @State var titleAlignment: SBBModalViewTitleAlignment = .center
    
    @State var backButtonCounter = 0
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                SBBFormGroup(title: "Configure ModalView") {
                    SBBCheckBox(isOn: self.$showBackButton, text: Text("Show back button"))
                    HStack {
                        Text("Title alignment")
                            .sbbFont(.body)
                        SBBSegmentedPicker(selection: self.$titleAlignment, tags: [SBBModalViewTitleAlignment.leading, SBBModalViewTitleAlignment.center]) {
                            Text("leading")
                            Text("center")
                        }
                    }
                        .padding(16)
                }
                Button(action: {
                    self.showingModalPopupView = true
                }) {
                    Text("Show Popup ModalView")
                }
                    .buttonStyle(SBBSecondaryButtonStyle())
                    .sbbModal(isPresented: self.$showingModalPopupView) {
                        SBBModalView(title: Text("Your title"), style: .popup, titleAlignment: self.titleAlignment, isPresented: self.$showingModalPopupView, showBackButton: self.showBackButton, actionOnBackButtonTouched: {
                            self.backButtonCounter += 1
                        }) {
                            VStack(spacing: 16) {
                                Text("Your custom content")
                                if self.showBackButton {
                                    Text("Back Button touched \(self.backButtonCounter) times")
                                }
                                Button(action: {
                                    self.showBackButton.toggle()
                                }) {
                                    Text(self.showBackButton ? "Hide Back Button" : "Show Back Button")
                                }
                                .buttonStyle(SBBPrimaryButtonStyle())
                            }
                                .sbbScreenPadding(.horizontal)
                        }                                .colorScheme(colorScheme)
                            .environment(\.sizeCategory, contentSizeCategory)
                    }
                Button(action: {
                    self.showingModalSheetView = true
                }) {
                    Text("Show Sheet ModalView")
                }
                    .buttonStyle(SBBSecondaryButtonStyle())
                    .sbbModal(isPresented: self.$showingModalSheetView) {
                        SBBModalView(title: Text("Your title"), style: .sheet, titleAlignment: self.titleAlignment, isPresented: self.$showingModalSheetView, showBackButton: self.showBackButton, actionOnBackButtonTouched: {
                            self.backButtonCounter += 1
                        }) {
                            VStack(spacing: 16) {
                                Text("Your custom content")
                                if self.showBackButton {
                                    Text("Back Button touched \(self.backButtonCounter) times")
                                }
                                Button(action: {
                                    self.showBackButton.toggle()
                                }) {
                                    Text(self.showBackButton ? "Hide Back Button" : "Show Back Button")
                                }
                                .buttonStyle(SBBPrimaryButtonStyle())
                            }
                                .sbbScreenPadding()
                        }
                            .colorScheme(colorScheme)
                            .environment(\.sizeCategory, contentSizeCategory)
                    }
                Button(action: {
                    self.showingModalFullView = true
                }) {
                    Text("Show Full ModalView")
                }
                    .buttonStyle(SBBSecondaryButtonStyle())
                    .sheet(isPresented: $showingModalFullView, content: {
                        SBBModalView(title: Text("Your title"), style: .full, titleAlignment: self.titleAlignment, isPresented: self.$showingModalFullView, showBackButton: self.showBackButton, actionOnBackButtonTouched: {
                                self.backButtonCounter += 1
                            }) {
                                VStack(spacing: 16) {
                                    Spacer()
                                    Text("Your custom content")
                                    if self.showBackButton {
                                        Text("Back Button touched \(self.backButtonCounter) times")
                                    }
                                    Spacer()
                                    Button(action: {
                                        self.showBackButton.toggle()
                                    }) {
                                        Text(self.showBackButton ? "Hide Back Button" : "Show Back Button")
                                    }
                                    .buttonStyle(SBBPrimaryButtonStyle())
                                }
                                    .sbbScreenPadding()
                            }
                                .colorScheme(colorScheme)
                                .environment(\.sizeCategory, contentSizeCategory)
                                .sbbStyle()
                        })
                Button(action: {
                    self.showingModalCustomView = true
                }) {
                    Text("Show Custom ModalView")
                }
                    .buttonStyle(SBBSecondaryButtonStyle())
                    .sbbModal(isPresented: self.$showingModalCustomView) {
                        Text("Your custom content here")
                            .environment(\.sizeCategory, contentSizeCategory)
                            .colorScheme(colorScheme)
                    }
            }
                .sbbScreenPadding()
        }
            .navigationBarTitle("ModalView")
            .sbbStyle()
            .colorScheme(colorScheme)
    }
}

struct ModalViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ModalViewDemo(colorScheme: .constant(.light), contentSizeCategory: .constant(.medium))
            ModalViewDemo(colorScheme: .constant(.dark), contentSizeCategory: .constant(.medium))
        }
    }
}
