//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct TypographyCustomFontView: View {
    
    @State var fontSize: CGFloat = 16
    
    let padding: CGFloat = 4
    
    var body: some View {
        VStack {
            Slider(value: $fontSize, in: 4...50, step: 1)
                .accentColor(.sbbColor(.primary))
            Text("Custom Font Size: \(Int(fontSize))")
                .font(.sbbBody)
            SBBDivider()
            Group {
                Text("SBB Bold")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.sbbBold(size: fontSize))
                    .foregroundColor(.sbbColor(.textBlack))
                    .padding(self.padding)
                Text("SBB Bold Condensed")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.sbbBoldCondensed(size: fontSize))
                    .foregroundColor(.sbbColor(.textBlack))
                    .padding(self.padding)
                Text("SBB Heavy Condensed")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.sbbHeavyCondensed(size: fontSize))
                    .foregroundColor(.sbbColor(.textBlack))
                    .padding(self.padding)
                Text("SBB Italic")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.sbbItalic(size: fontSize))
                    .foregroundColor(.sbbColor(.textBlack))
                    .padding(self.padding)
                Text("SBB Light")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.sbbLight(size: fontSize))
                    .foregroundColor(.sbbColor(.textBlack))
                    .padding(self.padding)
                Text("SBB Roman")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.sbbRoman(size: fontSize))
                    .foregroundColor(.sbbColor(.textBlack))
                    .padding(self.padding)
                Text("SBB Thin")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.sbbThin(size: fontSize))
                    .foregroundColor(.sbbColor(.textBlack))
                    .padding(self.padding)
                Text("SBB UltraLight")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.sbbUltralight(size: fontSize))
                    .foregroundColor(.sbbColor(.textBlack))
                    .padding(self.padding)
            }
        }
    }
}

struct TypographyCustomFontView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TypographyCustomFontView()
                .previewDisplayName("Light")
            TypographyCustomFontView()
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
