//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct InfoViewCollapsibleDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    @State var expanded1 = true
    @State var expanded2 = false
    
    var title = Text("Hinweis")
    var detail = Text("In und um den Bahnhof Biel / Bienne wird viel gebaut. Das kann Auswirkungen auf Ihre Reise haben. Beachten Sie deshalb den Onlinefahrplan und die aktuellen Anzeigen am Bahnhof, um über geänderte Gleise und Fahrpläne informiert zu sein.")
    
    var titleAccessibility = Text("Hinweis")
    var detailAccessibility = Text("In und um den Bahnhof Biel / Bienne wird viel gebaut. Das kann Auswirkungen auf Ihre Reise haben. Beachten Sie deshalb den Onlinefahrplan und die aktuellen Anzeigen am Bahnhof, um über geänderte Gleise und Fahrpläne informiert zu sein.")
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                SBBInfoViewCollapsible(title: title, detail: detail, expanded: $expanded1)
                Button(action: {
                    self.expanded1.toggle()
                }) {
                    Text("Toggle expanded state")
                }
                    .buttonStyle(SBBTertiaryButtonStyle(size: .small))
                SBBDivider()
                SBBInfoViewCollapsible(title: title, titleAccessibility: titleAccessibility, detail: detail, detailAccessibility: detailAccessibility, expanded: $expanded2)
                Button(action: {
                    self.expanded2.toggle()
                }) {
                    Text("Toggle expanded state")
                }
                    .buttonStyle(SBBTertiaryButtonStyle(size: .small))
                Spacer()
            }
            .padding(16)
        }
            .navigationBarTitle("InfoViewCollapsible")
            .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.bottom))
            .colorScheme(colorScheme)
    }
}

struct InfoViewCollapsibleDemo_Previews: PreviewProvider {
    @State static var lightScheme: ColorScheme = .light
    @State static var darkScheme: ColorScheme = .dark
    
    static var previews: some View {
        Group {
            InfoViewCollapsibleDemo(colorScheme: $lightScheme)
                .previewDisplayName("Light")
            InfoViewCollapsibleDemo(colorScheme: $darkScheme)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
