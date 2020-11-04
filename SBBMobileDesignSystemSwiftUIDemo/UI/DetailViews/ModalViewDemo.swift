//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct ModalViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @State var showingModalView = false
    @State var showBackButton = false
    @State var titleAlignment: SBBModalViewTitleAlignment = .center
    
    @State var backButtonCounter = 0
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    SBBFormGroup(title: "Configure ModalView") {
                        SBBCheckBox(isOn: self.$showBackButton, label: "Show back button")
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
                    Spacer()
                }
            }
            Button(action: {
                self.showingModalView = true
            }) {
                Text("Show ModalView")
            }
                .buttonStyle(SBBPrimaryButtonStyle())
                .sheet(isPresented: $showingModalView, content: {
                    SBBModalView(title: Text("Your title"), titleAlignment: self.titleAlignment, isPresented: self.$showingModalView, showBackButton: self.$showBackButton, actionOnBackButtonTouched: {
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
                            .padding(16)
                    }
                })
        }
            .padding(16)
            .navigationBarTitle("ModalView")
            .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.bottom))
            .colorScheme(colorScheme)
    }
}

struct ModalViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ModalViewDemo(colorScheme: .constant(.light))
            ModalViewDemo(colorScheme: .constant(.dark))
        }
    }
}
