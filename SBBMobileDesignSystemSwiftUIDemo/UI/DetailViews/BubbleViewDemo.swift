//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct BubbleViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    @State var expanded = true
    
    var image = Image(systemName: "car")
    var title = Text("IC6 nach Basel")
    var subtitle = Text("Gleis 2.")
    var detail1 = Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
    var detail2 = Text("ca. +2'")
    
    var titleAccessibility = Text("IC6 nach Basel")
    var subtitleAccessibility = Text("Heute auf Gleis 2.")
    var detail1Accessibility = Text("Wagen 3, Erste Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
    var detail2Accessibility = Text("circa +2 Minuten Verspätung.")
    
    var body: some View {
        VStack {
            SBBBubbleView(image: image, title: title, expanded: .constant(false))
            SBBDivider()
            SBBBubbleView(image: image, title: title, subtitle: subtitle, expanded: .constant(false))
            SBBDivider()
            SBBBubbleView(image: image, title: title, titleAccessibility: titleAccessibility, expanded: $expanded) {
                self.detail1
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibility(label: self.detail1Accessibility)
                self.detail2
                    .foregroundColor(SBBColor.red)
                    .font(.sbbTitleDefault)
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibility(label: self.detail2Accessibility)
            }
            Button(action: {
                self.expanded.toggle()
            }) {
                Text("toggle expanded state from Parentview")
            }
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
