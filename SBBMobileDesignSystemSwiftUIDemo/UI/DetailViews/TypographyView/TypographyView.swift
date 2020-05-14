//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct TypographyView: View {
    
    @Binding var colorScheme: ColorScheme
    @State var fontView: Int = 1
    
    var body: some View {
        VStack {
            SBBSegmentedPicker(selection: $fontView, tags: [1, 2]) {
                Text(".font")
                Text(".sbbFont")
            }
                .padding()
            ScrollView {
                if fontView == 1 {
                    TypographyFontView()
                } else if fontView == 2 {
                    TypographySBBFontView()
                }
            }
                .padding()
        }
            .navigationBarTitle("Typography")
            .background(SBBColor.background)
            .colorScheme(colorScheme)
            
    }
}

struct TypographyView_Previews: PreviewProvider {
    @State static var lightScheme: ColorScheme = .light
    @State static var darkScheme: ColorScheme = .dark
    
    static var previews: some View {
        Group {
            TypographyView(colorScheme: $lightScheme)
                .previewDisplayName("Light")
            TypographyView(colorScheme: $darkScheme)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
