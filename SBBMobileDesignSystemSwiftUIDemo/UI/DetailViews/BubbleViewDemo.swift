//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2019.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct BubbleViewDemo: View {
    var body: some View {
        Group {
            BubbleView(image: Image(systemName: "car"), title: "IC6 nach Basel", detail: "Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
        }
    }
}

struct BubbleViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        BubbleViewDemo()
    }
}
