//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2019.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct BubbleViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    @State var expanded1 = true
    @State var expanded2 = false
    
    var image = Image(systemName: "car")
    var title = "IC6 nach Basel"
    var subtitle = "Gleis 2 und 3."
    var detail = "Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03."
    
    var titleAccessibility = "IC6 nach Basel"
    var subtitleAccessibility = "Gleis 2 und 3."
    var detailAccessibility = "Wagen 3, Erste Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03."
    
    var body: some View {
        VStack {
            SBBBubbleView(image: image, title: title, detail: detail, expanded: $expanded1)
            Button(action: {
                self.expanded1.toggle()
            }) {
                Text("toggle expanded state from Parentview")
            }
            Divider()
            SBBBubbleView(image: image, title: "\(title) - voiceover", detail: detail, expanded: $expanded2, titleAccessibility: titleAccessibility, detailAccessibility: detailAccessibility)
            Button(action: {
                self.expanded2.toggle()
            }) {
                Text("toggle expanded state from Parentview")
            }
            Divider()
            SBBBubbleView(image: image, title: title, expanded: .constant(false))
            Divider()
            SBBBubbleView(image: image, title: title, subtitle: subtitle, expanded: .constant(false))
            Spacer()
        }
            .navigationBarTitle("BubbleView")
            .background(SBBColor.background)
            .colorScheme(colorScheme)
    }
}

struct BubbleViewDemo_Previews: PreviewProvider {
    @State static var lightScheme: ColorScheme = .light
    @State static var darkScheme: ColorScheme = .dark
    
    static var previews: some View {
        Group {
            BubbleViewDemo(colorScheme: $lightScheme)
                .previewDisplayName("Light")
            BubbleViewDemo(colorScheme: $darkScheme)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
