//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2019.
//

import SwiftUI

public struct SBBInfoView: View {
    
    var title: LocalizedStringKey
    var detail: LocalizedStringKey
    @Binding var expanded: Bool
    
    var titleAccessibility: LocalizedStringKey
    var detailAccessibility: LocalizedStringKey
        
    public init(title: String, detail: String, expanded: Binding<Bool>, titleAccessibility: String? = nil, detailAccessibility: String? = nil) {
        self.title = LocalizedStringKey(title)
        self.titleAccessibility = LocalizedStringKey(titleAccessibility ?? title)
        
        self.detail = LocalizedStringKey(detail)
        self.detailAccessibility = LocalizedStringKey(detailAccessibility ?? detail)
        
        self._expanded = expanded
    }
    
    public var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center) {
                        Text(self.title)
                            .sbbFont(.titleDefault)
                            .accessibility(label: Text(self.titleAccessibility))
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
                        Text(self.detail)
                            .sbbFont(.body)
                            .accessibility(label: Text(self.detailAccessibility))
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

struct SBBInfoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBInfoView(title: "Hinweis", detail: "In und um den Bahnhof Biel / Bienne wird viel gebaut. Das kann Auswirkungen auf Ihre Reise haben. Beachten Sie deshalb den Onlinefahrplan und die aktuellen Anzeigen am Bahnhof, um über geänderte Gleise und Fahrpläne informiert zu sein.", expanded: .constant(false))
                .previewDisplayName("Detail collapsed")
            SBBInfoView(title: "Hinweis", detail: "In und um den Bahnhof Biel / Bienne wird viel gebaut. Das kann Auswirkungen auf Ihre Reise haben. Beachten Sie deshalb den Onlinefahrplan und die aktuellen Anzeigen am Bahnhof, um über geänderte Gleise und Fahrpläne informiert zu sein.", expanded: .constant(true))
                .previewDisplayName("Detail expanded")
            SBBInfoView(title: "Hinweis", detail: "In und um den Bahnhof Biel / Bienne wird viel gebaut. Das kann Auswirkungen auf Ihre Reise haben. Beachten Sie deshalb den Onlinefahrplan und die aktuellen Anzeigen am Bahnhof, um über geänderte Gleise und Fahrpläne informiert zu sein.", expanded: .constant(true))
                .previewDisplayName("Detail expanded, dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}
