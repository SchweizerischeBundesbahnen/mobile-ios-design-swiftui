//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2019.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct BubbleViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    var image = Image(systemName: "car")
    var title = "IC6 nach Basel"
    var subtitle = "Gleis 2 und 3."
    var detail = "Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03."
    
    var body: some View {
        VStack {
            BubbleView(image: image, title: title, detail: detail)
            BubbleView(image: image, title: title, detail: detail, expanded: false)
            BubbleView(image: image, title: title)
            BubbleView(image: image, title: title, subtitle: subtitle)
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
