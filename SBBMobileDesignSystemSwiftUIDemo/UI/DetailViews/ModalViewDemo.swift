//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct ModalViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @State var showingModalView = false
    @State var showBackButton = false
    
    @State var backButtonCounter = 0
    
    var body: some View {
        VStack(spacing: 16) {
            Button(action: {
                self.showingModalView = true
            }) {
                Text("Show ModalView")
            }
                .buttonStyle(SBBPrimaryButtonStyle())
                .sheet(isPresented: $showingModalView, content: {
                    SBBModalView(title: Text("Your title"), isPresented: self.$showingModalView, showBackButton: self.$showBackButton, actionOnBackButtonTouched: {
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
            Spacer()
        }
            .padding(16)
            .navigationBarTitle("ModalView")
            .background(SBBColor.background.edgesIgnoringSafeArea(.bottom))
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
