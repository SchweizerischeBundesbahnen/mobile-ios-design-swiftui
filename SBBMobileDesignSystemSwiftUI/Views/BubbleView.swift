//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2019.
//

import SwiftUI

public struct BubbleView: View {
    
    var image: Image
    var title: String
    var subtitle: String?
    var detail: String?
    @State var expanded: Bool = true
    
    public init(image: Image, title: String, subtitle: String? = nil, detail: String? = nil, expanded: Bool = true) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.detail = detail
        self.expanded = expanded
    }
    
    public var body: some View {
        HStack(alignment: .top) {
            image
                .padding(.trailing, 16)
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(self.title)
                        .sbbFont(.titleDefault)
                    Spacer()
                    if (self.detail != nil) {
                        Button(action: {
                            self.expanded.toggle()
                        }) {
                            if self.expanded {
                                Image(systemName: "chevron.up")
                            } else {
                                Image(systemName: "chevron.down")
                            }
                        }
                    }
                }
                if (self.detail != nil) && self.expanded {
                    Divider()
                    Text(self.detail!)
                        .sbbFont(.body)
                }
            }
        }
            .padding(16)
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
