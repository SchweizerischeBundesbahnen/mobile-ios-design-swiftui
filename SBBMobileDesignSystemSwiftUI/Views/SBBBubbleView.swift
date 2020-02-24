//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2019.
//

import SwiftUI

public struct SBBBubbleView: View {
    
    var image: Image
    var title: String
    var subtitle: String?
    var detail: String?
    @Binding var expanded: Bool
    
    var titleAccessibility: String?
    var subtitleAccessibility: String?
    var detailAccessibility: String?
        
    public init(image: Image, title: String, subtitle: String? = nil, detail: String? = nil, expanded: Binding<Bool>, titleAccessibility: String? = nil, subtitleAccessibility: String? = nil, detailAccessibility: String? = nil) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.detail = detail
        self._expanded = expanded
        
        self.titleAccessibility = titleAccessibility
        self.subtitleAccessibility = subtitleAccessibility
        self.detailAccessibility = detailAccessibility
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                //.fill(SBBColor.red)
                .fill(SBBColor.bubbleRedTODORemove)   // TODO - remove once translucency can be set to false for Navigationbar (current SwiftUI bug). Until then, we change the BubbleView Red color to match the SBBNavigationBar color.
                .frame(idealWidth: .infinity, minHeight: 35, maxHeight: 35)
            Group {
                Button(action: {
                    withAnimation {
                        self.expanded.toggle()
                    }
                }) {
                    HStack(alignment: .top, spacing: 16) {
                        image
                            .frame(width: 36, height: 36, alignment: .center)
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(alignment: .center) {
                                Text(LocalizedStringKey(self.title))
                                    .sbbFont(.titleDefault)
                                    .accessibility(label: Text(LocalizedStringKey(self.titleAccessibility ?? self.title)))
                                Spacer()
                                if (self.detail != nil) {
                                    if self.expanded {
                                        Image("chevron_small_up", bundle: Helper.bundle)
                                    } else {
                                        Image("chevron_small_down", bundle: Helper.bundle)
                                    }
                                }
                            }
                                .frame(minHeight: 36, maxHeight: 36)
                            if (self.subtitle != nil) {
                                Text(LocalizedStringKey(self.subtitle!))
                                    .sbbFont(.body)
                                    .accessibility(label: Text(LocalizedStringKey(self.subtitleAccessibility ?? self.subtitle!)))
                            }
                            if (self.detail != nil) && self.expanded {
                                Rectangle()     // Divider cannot be used here, since you cannot change its color
                                    .fill(SBBColor.divider)
                                    .frame(idealWidth: .infinity, minHeight: 1, maxHeight: 1)
                                Text(LocalizedStringKey(self.detail!))
                                    .sbbFont(.body)
                                    .padding(.top, 8)
                                    .accessibility(label: Text(LocalizedStringKey(self.detailAccessibility ?? self.detail!)))
                            }
                        }
                    }
                }
                    .disabled(self.detail == nil)
                    .padding(16)
                    .background(SBBColor.controlBackground)
                    .cornerRadius(16)
                    .accentColor(SBBColor.textBlack)
                    .accessibilityElement(children: .combine)
                    .accessibility(hint: self.expanded ? Text("collapse".localized) : Text("expand".localized))
            }
                .padding(.horizontal, 16)
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
