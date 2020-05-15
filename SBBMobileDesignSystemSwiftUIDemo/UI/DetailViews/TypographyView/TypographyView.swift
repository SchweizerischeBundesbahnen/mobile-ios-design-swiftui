//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct TypographyView: View {
    
    @Binding var colorScheme: ColorScheme
    @State var fontView: Int = 1
    @State var infoViewExpanded: Bool = true
    
    var body: some View {
        VStack(spacing: 16) {
            SBBSegmentedPicker(selection: $fontView, tags: [1, 2, 3]) {
                Text(".font")
                Text(".sbbFont")
                Text("custom")
            }
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    if fontView == 1 {
                        SBBInfoView(title: Text("ReadMe   -   .font"), detail: Text("Using the .font() View Modifier, you can select all available SBB Fonts. However this does not apply SBB specific LineSpacing. If you want SBB specific LineSpacing, use the .sbbFont() View Modifier instead."), expanded: $infoViewExpanded)
                        TypographyFontView()
                    } else if fontView == 2 {
                        SBBInfoView(title: Text("ReadMe   -   .sbbFont"), detail: Text("Using the .sbbFont() View Modifier, you can select all available SBB Fonts. SBB specific LineSpacing is also applied."), expanded: $infoViewExpanded)
                        TypographySBBFontView()
                    } else if fontView == 3 {
                        SBBInfoView(title: Text("ReadMe   -   Custom Font"), detail: Text("Using the .font(.sbbFont(size: 10)) you can create your own Font based on the available SBB Font Styles by specifying a size of your choice"), expanded: $infoViewExpanded)
                        TypographyCustomFontView()
                    }
                }
            }
        }
            .navigationBarTitle("Typography")
            .padding()
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
