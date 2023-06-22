//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct PromotionBoxDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    @State var isPresented: Bool = true
    
    var body: some View {
        VStack(spacing: 8) {
            SBBPromotionBox(newIn: "l'application", title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus."), isPresented: $isPresented)
            
            if !isPresented {
                HStack {
                    Spacer()
                    Button(action: {
                        isPresented = true
                    }) {
                        Text("Show PromotionBox")
                    }
                    .buttonStyle(SBBTertiaryButtonStyle())
                    Spacer()
                }
            }
            Spacer()
        }
            .sbbScreenPadding(.vertical)
            .background(Color.sbbColor(.background))
            .navigationBarTitle("PromotionBox")
            .sbbStyle()
            .colorScheme(colorScheme)
    }
}
