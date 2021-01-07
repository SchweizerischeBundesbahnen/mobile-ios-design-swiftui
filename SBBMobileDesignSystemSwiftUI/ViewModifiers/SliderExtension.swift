//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension Slider {
    func sbbStyle() -> some View {
        self.modifier(SBBSlider())
    }
    
    func sbbStyle(imageLeft: Image, imageRight: Image) -> some View {
        HStack(alignment: .center, spacing: 4) {
            imageLeft
                .resizeToContentSizeCategory(originalHeight: 24)
            self.modifier(SBBSlider())
            imageRight
                .resizeToContentSizeCategory(originalHeight: 24)
        }
    }
}

struct SBBSlider: ViewModifier {
    func body(content: Content) -> some View {
        content
            .accentColor(Color.sbbColor(.red))
    }
}
