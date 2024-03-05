//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct PromotionBoxDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    @State var isPresented1: Bool = true
    @State var isPresented2: Bool = true
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 8) {
            ScrollView(showsIndicators: false) {
                SBBPromotionBox(newIn: "l'application", title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus."), isPresented: $isPresented1)
                
                if !isPresented1 {
                    HStack {
                        Spacer()
                        Button(action: {
                            isPresented1 = true
                        }) {
                            Text("Show PromotionBox")
                        }
                        .buttonStyle(SBBTertiaryButtonStyle())
                        Spacer()
                    }
                }
                
                SBBPromotionBox(newIn: "l'application", title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus."), isPresented: $isPresented2, onClick: {
                    self.showAlert = true
                })
                
                if !isPresented2 {
                    HStack {
                        Spacer()
                        Button(action: {
                            isPresented2 = true
                        }) {
                            Text("Show PromotionBox")
                        }
                        .buttonStyle(SBBTertiaryButtonStyle())
                        Spacer()
                    }
                }
                
                Spacer()
            }
        }
        .sbbScreenPadding()
        .background(Color.sbbColor(.background))
        .navigationBarTitle("PromotionBox")
        .sbbStyle()
        .colorScheme(colorScheme)
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Some action"), dismissButton: .cancel(Text("OK")))
        })
    }
}
