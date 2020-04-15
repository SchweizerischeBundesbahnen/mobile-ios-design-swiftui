//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct InfoViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    @State var expanded1 = true
    @State var expanded2 = false
    
    var title = "Hinweis"
    var detail = "In und um den Bahnhof Biel / Bienne wird viel gebaut. Das kann Auswirkungen auf Ihre Reise haben. Beachten Sie deshalb den Onlinefahrplan und die aktuellen Anzeigen am Bahnhof, um über geänderte Gleise und Fahrpläne informiert zu sein."
    
    var titleAccessibility = "Hinweis"
    var detailAccessibility = "In und um den Bahnhof Biel / Bienne wird viel gebaut. Das kann Auswirkungen auf Ihre Reise haben. Beachten Sie deshalb den Onlinefahrplan und die aktuellen Anzeigen am Bahnhof, um über geänderte Gleise und Fahrpläne informiert zu sein."
    
    var body: some View {
        VStack {
            SBBInfoView(title: title, detail: detail, expanded: $expanded1)
            Button(action: {
                self.expanded1.toggle()
            }) {
                Text("toggle expanded state from Parentview")
            }
            SBBDivider()
            SBBInfoView(title: "\(title) - voiceover", detail: detail, expanded: $expanded2, titleAccessibility: titleAccessibility, detailAccessibility: detailAccessibility)
            Button(action: {
                self.expanded2.toggle()
            }) {
                Text("toggle expanded state from Parentview")
            }
            Spacer()
        }
            .padding(16)
            .navigationBarTitle("InfoView")
            .background(SBBColor.background)
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
