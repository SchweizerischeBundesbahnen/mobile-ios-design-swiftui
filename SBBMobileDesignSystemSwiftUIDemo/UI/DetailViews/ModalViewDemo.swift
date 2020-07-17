//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct ModalViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @State var showingModalView = false
    
    var body: some View {
        Button(action: {
            self.showingModalView = true
        }) {
            Text("Click Me")
        }
            .sheet(isPresented: $showingModalView, content: {
                SBBModalView(title: Text("Your title"), isPresented: self.$showingModalView) {
                    VStack {
                        Spacer()
                        Text("Your custom content")
                        Spacer()
                    }
                }
            })
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
