//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct InfoViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    @State var expanded1 = true
    @State var expanded2 = false
    
    var text = Text("In und um den Bahnhof Biel / Bienne wird viel gebaut. Das kann Auswirkungen auf Ihre Reise haben.")
    
    var body: some View {
        VStack {
            SBBInfoView(image: Image(sbbName: "station", size: .small)
, text: text)
            Spacer()
        }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .navigationBarTitle("InfoView")
            .sbbStyle()
            .colorScheme(colorScheme)
    }
}

struct InfoViewDemo_Previews: PreviewProvider {
    @State static var lightScheme: ColorScheme = .light
    @State static var darkScheme: ColorScheme = .dark
    
    static var previews: some View {
        Group {
            InfoViewDemo(colorScheme: $lightScheme)
                .previewDisplayName("Light")
            InfoViewDemo(colorScheme: $darkScheme)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
