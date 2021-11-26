//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension Slider {
    
    /**
     Applies SBB styling to a Slider View.
     
     ## Overview
     You create a normal Slider and apply the .sbbStyle() ViewModifier::
     ```swift
     var body: some View {
        Slider(value: .constant(50.0), in: 0.0...100.0, step: 1.0)
            .sbbStyle()
     }
     ```
     */
    func sbbStyle() -> some View {
        self.modifier(SBBSlider())
    }
    
    /**
     Applies SBB styling to a Slider View.
     
     ## Overview
     You create a normal Slider and apply the .sbbStyle() ViewModifier::
     ```swift
     var body: some View {
        Slider(value: .constant(50.0), in: 0.0...100.0, step: 1.0)
            .sbbStyle(imageLeft: Image(sbbName: "walk-slow", size: .small), imageRight: Image(sbbName: "walk-fast", size: .small))
     }
     ```
     ![SliderExtension](SliderExtension)
     
     - Parameters:
        - imageLeft: Image to show on the leading edge of the Slider View as a minimum limit (typically in size .small, images in other sizes will get resized if needed).
        - imageRight: Image to show on the trailing edge of the Slider View as a maximum limit (typically in size .small, images in other sizes will get resized if needed).
     */
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
            .accentColor(Color.sbbColor(.primary))
    }
}
