//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct DividerViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Text(self.text)
                    .sbbFont(.body)
                SBBDivider()
                Text(self.text)
                    .sbbFont(.body)
                Spacer()
            }
        }
            .padding(16)
            .sbbStyle()
            .colorScheme(colorScheme)
    }
}

struct DividerViewDemo_Previews: PreviewProvider {
    @State static var lightScheme: ColorScheme = .light
    @State static var darkScheme: ColorScheme = .dark
    
    static var previews: some View {
        Group {
            DividerViewDemo(colorScheme: $lightScheme)
                .previewDisplayName("Light")
            DividerViewDemo(colorScheme: $darkScheme)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
