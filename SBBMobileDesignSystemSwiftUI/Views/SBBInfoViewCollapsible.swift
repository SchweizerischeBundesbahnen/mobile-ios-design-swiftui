//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBInfoViewCollapsible: View {
    
    private let title: Text
    private let titleAccessibility: Text?
    private let detail: Text
    private let detailAccessibility: Text?
    @Binding private var expanded: Bool
    
    public init(title: Text, titleAccessibility: Text? = nil, detail: Text, detailAccessibility: Text? = nil, expanded: Binding<Bool>) {
        self.title = title
        self.titleAccessibility = titleAccessibility
        self.detail = detail
        self.detailAccessibility = detailAccessibility
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
                            .accessibility(label: self.titleAccessibility ?? self.title)
                        Spacer()
                        Group {
                            Image("chevron_small_up", bundle: Helper.bundle)
                                .rotationEffect(.degrees(self.expanded ? 0 : 180))
                        }
                            .accessibility(hidden: true)
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(SBBColor.border))
                    }
                    if self.expanded {
                        self.detail
                            .sbbFont(.body)
                            .fixedSize(horizontal: false, vertical: true)
                            .accessibility(label: self.detailAccessibility ?? self.detail)
                    }
                }
                    .padding(16)
                    .background(SBBColor.viewBackground)
                    .cornerRadius(16)
                    .accentColor(SBBColor.textBlack)
                    .accessibilityElement(children: .combine)
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

struct SBBInfoViewCollapsible_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBInfoViewCollapsible(title: Text("Hinweis"), detail: Text("In und um den Bahnhof Biel / Bienne wird viel gebaut. Das kann Auswirkungen auf Ihre Reise haben. Beachten Sie deshalb den Onlinefahrplan und die aktuellen Anzeigen am Bahnhof, um über geänderte Gleise und Fahrpläne informiert zu sein."), expanded: .constant(false))
                .previewDisplayName("Detail collapsed")
            SBBInfoViewCollapsible(title: Text("Hinweis"), detail: Text("In und um den Bahnhof Biel / Bienne wird viel gebaut. Das kann Auswirkungen auf Ihre Reise haben. Beachten Sie deshalb den Onlinefahrplan und die aktuellen Anzeigen am Bahnhof, um über geänderte Gleise und Fahrpläne informiert zu sein."), expanded: .constant(true))
                .previewDisplayName("Detail expanded")
            SBBInfoViewCollapsible(title: Text("Hinweis"), detail: Text("In und um den Bahnhof Biel / Bienne wird viel gebaut. Das kann Auswirkungen auf Ihre Reise haben. Beachten Sie deshalb den Onlinefahrplan und die aktuellen Anzeigen am Bahnhof, um über geänderte Gleise und Fahrpläne informiert zu sein."), expanded: .constant(true))
                .previewDisplayName("Detail expanded, dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}
