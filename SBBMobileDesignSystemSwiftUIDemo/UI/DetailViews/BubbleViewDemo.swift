//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct BubbleViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    @State var expanded1 = true
    @State var expanded2 = true
    
    var image = Image(systemName: "car")
    var title = Text("IC6 nach Basel")
    var subtitle = Text("Gleis 2.")
    var detail1 = Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
    var detail2 = Text("ca. +2'").foregroundColor(SBBColor.red).font(.sbbTitleDefault)
    
    var titleAccessibility = Text("IC6 nach Basel")
    var subtitleAccessibility = Text("Heute auf Gleis 2.")
    var detail1Accessibility = Text("Wagen 3, Erste Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
    var detail2Accessibility = Text("circa +5 Minuten Verspätung.")
    
    var body: some View {
        VStack {
            SBBBubbleView(image: image, title: title, expanded: .constant(false))
            SBBDivider()
            SBBBubbleView(image: image, title: title, subtitle: subtitle, expanded: .constant(false))
            SBBDivider()
            SBBBubbleView(image: image, title: title, detail: [detail1], expanded: $expanded1)
            Button(action: {
                self.expanded1.toggle()
            }) {
                Text("toggle expanded state from Parentview")
            }
            SBBDivider()
            SBBBubbleView(image: image, title: title, titleAccessibility: titleAccessibility, detail: [detail1, detail2], detailAccessibility: [detail1Accessibility, detail2Accessibility], expanded: $expanded2)
            Button(action: {
                self.expanded2.toggle()
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
