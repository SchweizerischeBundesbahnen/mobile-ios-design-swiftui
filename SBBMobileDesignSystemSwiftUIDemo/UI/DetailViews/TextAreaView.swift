//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct TextAreaView: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var text = ""//"My nice text"
    
    var body: some View {
        VStack {
            SBBTextArea(text: $text, placeholder: "Placeholder")
                .frame(maxHeight: 100)
            Spacer()
        }
        .padding(16)
        .navigationBarTitle("Textarea")
        .background(SBBColor.background)
        .colorScheme(colorScheme)
    }
}

struct TextAreaView_Previews: PreviewProvider {
    @State static var lightScheme: ColorScheme = .light
    @State static var darkScheme: ColorScheme = .dark
    
    static var previews: some View {
        Group {
            TextAreaView(colorScheme: $lightScheme)
            TextAreaView(colorScheme: $darkScheme)
        }
    }
}
