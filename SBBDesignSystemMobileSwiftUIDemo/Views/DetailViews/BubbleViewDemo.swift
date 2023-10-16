//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct BubbleViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @State var expanded1 = true
    @State var expanded2 = true
    @State var segmentedPickerSelection1 = 0
    @State var segmentedPickerSelection2 = 0
    @State var segmentedPickerSelection3 = 0
    @State var bubbleViewHeight: CGFloat = 0
    
    var image = Image(sbbIcon: .train_medium)
    var title = Text("IC6 nach Basel")
    var subtitle = Text("Gleis 2.")
    var detail1 = Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
    var detail2 = Text("ca. +2'")
    
    var titleAccessibility = Text("IC6 nach Basel")
    var subtitleAccessibility = Text("Heute auf Gleis 2.")
    var detail1Accessibility = Text("Wagen 3, Erste Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
    var detail2Accessibility = Text("circa +2 Minuten Verspätung.")
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    Group {
                        SBBDivider()
                        SBBBubbleView(image: image, title: title, subtitle: subtitle, extendNavigationBarBackground: false)
                        SBBDivider()
                        SBBBubbleView(image: image, title: title, titleAccessibility: titleAccessibility, expanded: $expanded1, extendNavigationBarBackground: false, expandableContent: {
                            self.detail1
                                .fixedSize(horizontal: false, vertical: true)
                                .accessibility(label: self.detail1Accessibility)
                            self.detail2
                                .foregroundColor(.sbbColor(.red))
                                .font(.medium_bold)
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
                    Group {
                        SBBDivider()
                        SBBBubbleView(image: image, title: title, extendNavigationBarBackground: false, subtitleContent: {
                            Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
                            Text("ca. +12'")
                                .foregroundColor(.sbbColor(.red))
                                .font(.medium_bold)
                                .padding(.top, 6)
                        }, fixedContent: {
                            SBBSegmentedPicker(selection: $segmentedPickerSelection3, tags: [0, 1], content: {
                                Text("Wagen")
                                Text("Perlschnur")
                            })
                        })
                    }
                }
                    .padding(.top, 16 + bubbleViewHeight)
            }
            SBBBubbleView(image: image, title: title)
                .overlay(
                    GeometryReader { geometry in
                        Color.clear.onAppear {
                            self.bubbleViewHeight = geometry.size.height
                        }
                    }
                )
        }
            .navigationBarTitle("BubbleView")
            .sbbStyle()
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
