//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2019.
//

import SwiftUI

struct BubbleView: View {
    
    @State var image: Image
    @State var title: String
    @State var subtitle: String?
    @State var detail: String?
    @State var expanded: Bool = true
    
    var body: some View {
        HStack {
            image
            VStack {
                HStack {
                    Text(self.title)
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
                if (self.detail != nil) {
                    Divider()
                    Text(self.detail!)
                }
            }
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
            
        }
            .previewLayout(.sizeThatFits)
    }
}
