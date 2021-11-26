//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/**
 A  View that is used to display a collapsible text.
 
 ## Overview
 You create a SBBAccordion  by providing a expanded state binding, a title and a collapsible text:
 ```swift
 @State var expanded = false

 var body: some View {
    SBBAccordion(title: Text("Your title"), text: Text("Your long text"), expanded: $expanded)
 }
 ```
 ![SBBAccordion](SBBAccordion)
 */
public struct SBBAccordion: View {
    
    private let title: Text
    private let text: Text
    @Binding private var expanded: Bool
    
    /**
     Returns a SBBAccordion displaying collapsible Text.
     
     - Parameters:
        - title: The Text to display as title.
        - text: The collapsible detail Text to display.
        - expanded: Sets the collapsed/expanded state of the SBBAccordion.
     */
    public init(title: Text, text: Text, expanded: Binding<Bool>) {
        self.title = title
        self.text = text
        self._expanded = expanded
    }
    
    public var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center) {
                        self.title
                            .sbbFont(.titleDefault)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                        Group {
                            Image(sbbName: "chevron-small-up", size: .small)
                                .rotationEffect(.degrees(self.expanded ? 0 : 180))
                        }
                            .accessibility(hidden: true)
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.sbbColor(.border)))
                    }
                    if self.expanded {
                        self.text
                            .sbbFont(.body)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                    .padding(16)
                    .background(Color.sbbColor(.viewBackground))
                    .cornerRadius(16)
                    .accentColor(.sbbColor(.textBlack))
                    .accessibilityElement(children: .combine)
                    .accessibility(identifier: "infoViewCollapsible")
                    .accessibility(hint: self.expanded ? Text("collapse".localized) : Text("expand".localized))
                    .onTapGesture {
                        withAnimation{
                            self.expanded.toggle()
                        }
                    }
            }
        }
    }
}

struct SBBAccordion_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBAccordion(title: Text("Hinweis"), text: Text("In und um den Bahnhof Biel / Bienne wird viel gebaut. Das kann Auswirkungen auf Ihre Reise haben. Beachten Sie deshalb den Onlinefahrplan und die aktuellen Anzeigen am Bahnhof, um über geänderte Gleise und Fahrpläne informiert zu sein."), expanded: .constant(false))
                .previewDisplayName("Detail collapsed")
            SBBAccordion(title: Text("Hinweis"), text: Text("In und um den Bahnhof Biel / Bienne wird viel gebaut. Das kann Auswirkungen auf Ihre Reise haben. Beachten Sie deshalb den Onlinefahrplan und die aktuellen Anzeigen am Bahnhof, um über geänderte Gleise und Fahrpläne informiert zu sein."), expanded: .constant(true))
                .previewDisplayName("Detail expanded")
            SBBAccordion(title: Text("Hinweis"), text: Text("In und um den Bahnhof Biel / Bienne wird viel gebaut. Das kann Auswirkungen auf Ihre Reise haben. Beachten Sie deshalb den Onlinefahrplan und die aktuellen Anzeigen am Bahnhof, um über geänderte Gleise und Fahrpläne informiert zu sein."), expanded: .constant(true))
                .previewDisplayName("Detail expanded, dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}
