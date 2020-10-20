//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct BubbleViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @State var expanded1 = true
    @State var expanded2 = true
    @State var segmentedPickerSelection1 = 0
    @State var segmentedPickerSelection2 = 0
    
    var image = Image(sbbName: "train", size: .medium)
    var title = Text("IC6 nach Basel")
    var subtitle = Text("Gleis 2.")
    var detail1 = Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
    var detail2 = Text("ca. +2'")
    
    var titleAccessibility = Text("IC6 nach Basel")
    var subtitleAccessibility = Text("Heute auf Gleis 2.")
    var detail1Accessibility = Text("Wagen 3, Erste Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
    var detail2Accessibility = Text("circa +2 Minuten Verspätung.")
    
    var body: some View {
        VStack(spacing: 0) {
            SBBBubbleView(image: image, title: title)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    SBBDivider()
                    SBBBubbleView(image: image, title: title, subtitle: subtitle, extendNavigationBarBackground: false)
                    SBBDivider()
                    SBBBubbleView(image: image, title: title, titleAccessibility: titleAccessibility, expanded: $expanded1, extendNavigationBarBackground: false, expandableContent: {
                        self.detail1
                            .fixedSize(horizontal: false, vertical: true)
                            .accessibility(label: self.detail1Accessibility)
                        self.detail2
                            .foregroundColor(.sbbColor(.red))
                            .font(.sbbTitleDefault)
                            .fixedSize(horizontal: false, vertical: true)
                            .accessibility(label: self.detail2Accessibility)
                    })
                    Button(action: {
                        self.expanded1.toggle()
                    }) {
                        Text("toggle expanded state from Parentview")
                    }
                        .buttonStyle(SBBTertiaryButtonStyle())
                    SBBDivider()
                    SBBBubbleView(image: image, title: title, titleAccessibility: titleAccessibility, extendNavigationBarBackground: false, fixedContent: {
                        SBBSegmentedPicker(selection: self.$segmentedPickerSelection1, tags: [0, 1], content: {
                            Text("Wagen")
                            Text("Perlschnur")
                        })
                    })
                    SBBDivider()
                    SBBBubbleView(image: image, title: title, titleAccessibility: titleAccessibility, expanded: $expanded2, extendNavigationBarBackground: false, expandableContent: {
                        self.detail1
                            .fixedSize(horizontal: false, vertical: true)
                            .accessibility(label: self.detail1Accessibility)
                    }, fixedContent: {
                        SBBSegmentedPicker(selection: self.$segmentedPickerSelection2, tags: [0, 1], content: {
                            Text("Wagen")
                            Text("Perlschnur")
                        })
                    })
                    Button(action: {
                        self.expanded2.toggle()
                    }) {
                        Text("toggle expanded state from Parentview")
                    }
                        .buttonStyle(SBBTertiaryButtonStyle())
                }
                    .padding(.top, 16)
            }
        }
            .navigationBarTitle("BubbleView")
            .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.bottom))
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
