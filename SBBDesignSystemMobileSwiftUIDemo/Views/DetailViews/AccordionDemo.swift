//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct AccordionDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    @State var expanded = true
    
    var title = Text("Hinweis")
    var text = Text("In und um den Bahnhof Biel / Bienne wird viel gebaut. Das kann Auswirkungen auf Ihre Reise haben. Beachten Sie deshalb den Onlinefahrplan und die aktuellen Anzeigen am Bahnhof, um über geänderte Gleise und Fahrpläne informiert zu sein.")
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                SBBAccordion(title: title, text: text, expanded: $expanded)
                Button(action: {
                    self.expanded.toggle()
                }) {
                    Text("Toggle expanded state")
                }
                    .buttonStyle(SBBTertiaryButtonStyle(size: .small))
                Spacer()
            }
                .sbbScreenPadding()
        }
            .navigationBarTitle("Accordion")
            .sbbStyle()
            .colorScheme(colorScheme)
    }
}

struct AccordionDemo_Previews: PreviewProvider {
    @State static var lightScheme: ColorScheme = .light
    @State static var darkScheme: ColorScheme = .dark
    
    static var previews: some View {
        Group {
            AccordionDemo(colorScheme: $lightScheme)
                .previewDisplayName("Light")
            AccordionDemo(colorScheme: $darkScheme)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
