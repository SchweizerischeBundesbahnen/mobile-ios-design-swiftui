//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2019.
//

import SwiftUI

public struct BubbleView: View {
    
    var image: Image
    var title: String
    var subtitle: String?
    var detail: String?
    @State var expanded: Bool
    
    var titleVoiceover: String?
    var subtitleVoiceover: String?
    var detailVoiceover: String?
        
    public init(image: Image, title: String, subtitle: String? = nil, detail: String? = nil, expanded: Bool = true, titleVoiceover: String? = nil, subtitleVoiceover: String? = nil, detailVoiceover: String? = nil) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.detail = detail
        _expanded = State(initialValue: expanded)
        
        self.titleVoiceover = titleVoiceover
        self.subtitleVoiceover = subtitleVoiceover
        self.detailVoiceover = detailVoiceover
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(SBBColor.red)
                .frame(idealWidth: .infinity, minHeight: 35, maxHeight: 35)
            Group {
                Button(action: {
                    self.expanded.toggle()
                }) {
                    HStack(alignment: .top, spacing: 16) {
                        image
                            .frame(width: 36, height: 36, alignment: .center)
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(alignment: .center) {
                                Text(self.title)
                                    .sbbFont(.titleDefault)
                                    .accessibility(label: Text(self.titleVoiceover ?? self.title))
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
                                Text(self.subtitle!)
                                    .sbbFont(.body)
                                    .accessibility(label: Text(self.subtitleVoiceover ?? self.subtitle!))
                            }
                            if (self.detail != nil) && self.expanded {
                                Rectangle()     // Divider cannot be used here, since you cannot change its color
                                    .fill(SBBColor.divider)
                                    .frame(idealWidth: .infinity, minHeight: 1, maxHeight: 1)
                                Text(self.detail!)
                                    .sbbFont(.body)
                                    .padding(.top, 8)
                                    .accessibility(label: Text(self.detailVoiceover ?? self.detail!))
                            }
                        }
                    }
                }
                    .disabled(self.detail == nil)
                    .padding(16)
                    .background(SBBColor.viewBackground)
                    .cornerRadius(16)
                    .accentColor(SBBColor.textBlack)
                    .accessibilityElement(children: .combine)
                    .accessibility(hint: self.expanded ? Text("collapse".localize()) : Text("expand".localize()))
            }
                .padding(.horizontal, 16)
        }
    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BubbleView(image: Image(systemName: "car"), title: "IC6 nach Basel")
                .previewDisplayName("Title only")
            BubbleView(image: Image(systemName: "car"), title: "Biel / Bienne", subtitle: "Gleis 2 und 3.")
                .previewDisplayName("Subtitle")
            BubbleView(image: Image(systemName: "car"), title: "IC6 nach Basel", detail: "Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
                .previewDisplayName("Detail")
            BubbleView(image: Image(systemName: "car"), title: "IC6 nach Basel", detail: "Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
                .previewDisplayName("Detail dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}
