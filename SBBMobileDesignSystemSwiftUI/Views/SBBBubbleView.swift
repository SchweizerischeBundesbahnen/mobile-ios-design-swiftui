//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBBubbleView: View {
    
    var image: Image
    var title: LocalizedStringKey
    var subtitle: LocalizedStringKey?
    var detail: LocalizedStringKey?
    @Binding var expanded: Bool
    
    var titleAccessibility: LocalizedStringKey
    var subtitleAccessibility: LocalizedStringKey?
    var detailAccessibility: LocalizedStringKey?
        
    public init(image: Image, title: String, subtitle: String? = nil, detail: String? = nil, expanded: Binding<Bool>, titleAccessibility: String? = nil, subtitleAccessibility: String? = nil, detailAccessibility: String? = nil) {
        self.image = image
        
        self.title = LocalizedStringKey(title)
        self.titleAccessibility = LocalizedStringKey(titleAccessibility ?? title)
        
        if let subtitle = subtitle {
            self.subtitle = LocalizedStringKey(subtitle)
            self.subtitleAccessibility = LocalizedStringKey(subtitleAccessibility ?? subtitle)
        } else {
            self.subtitle = nil
            self.subtitleAccessibility = nil
        }
        
        if let detail = detail {
            self.detail = LocalizedStringKey(detail)
            self.detailAccessibility = LocalizedStringKey(detailAccessibility ?? detail)
        } else {
            self.detail = nil
            self.detailAccessibility = nil
        }
        
        self._expanded = expanded
        
        
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(SBBColor.red)
                .frame(idealWidth: .infinity, minHeight: 35, maxHeight: 35)
            HStack {
                HStack(alignment: .top, spacing: 16) {
                    image
                        .frame(width: 36, height: 36, alignment: .center)
                        .accessibility(hidden: true)
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(alignment: .center) {
                                Text(self.title)
                                    .sbbFont(.titleDefault)
                                    .accessibility(label: Text(self.titleAccessibility))
                                    .padding([.bottom, .top], 8)
                                Spacer()
                                if (self.detail != nil) {
                                    Group {
                                        Image("chevron_small_up", bundle: Helper.bundle)
                                            .rotationEffect(.degrees(self.expanded ? 0 : 180))
                                    }
                                        .accessibility(hidden: true)
                                        .frame(width: 32, height: 32)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(SBBColor.border))
                                }
                            }
                            if (self.subtitle != nil) {
                                Text(self.subtitle!)
                                    .sbbFont(.body)
                                    .accessibility(label: Text(self.subtitleAccessibility!))
                            }
                        }
                        if (self.detail != nil) && self.expanded {
                            SBBDivider()
                            Text(self.detail!)
                                .sbbFont(.body)
                                .accessibility(label: Text(self.detailAccessibility!))
                        }
                    }
                        .accessibilityElement(children: .combine)   // TODO - delete once SwiftUI bug is solved
                }
                    .disabled(self.detail == nil)
                    .padding(16)
                    .background(SBBColor.tabViewBackground)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.1), radius: 5)
                    .accentColor(SBBColor.textBlack)
                    //.accessibilityElement(children: .combine) / TODO - uncomment once SwiftUI bug (.combine does not reload voiceover if children element Strings are changed) is solved
                    .accessibility(hint: ((self.detail == nil) ? Text("") : self.expanded ? Text("collapse".localized) : Text("expand".localized)))
            }
                .padding(.horizontal, 16)
                .onTapGesture {
                    withAnimation{
                        self.expanded.toggle()
                    }
                }
        }
    }
}

struct SBBBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBBubbleView(image: Image(systemName: "car"), title: "IC6 nach Basel", expanded: .constant(true))
                .previewDisplayName("Title only")
            SBBBubbleView(image: Image(systemName: "car"), title: "Biel / Bienne", subtitle: "Gleis 2 und 3.", expanded: .constant(true))
                .previewDisplayName("Subtitle")
            SBBBubbleView(image: Image(systemName: "car"), title: "IC6 nach Basel", detail: "Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.", expanded: .constant(true))
                .previewDisplayName("Detail")
            SBBBubbleView(image: Image(systemName: "car"), title: "IC6 nach Basel", detail: "Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.", expanded: .constant(true))
                .previewDisplayName("Detail dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}
