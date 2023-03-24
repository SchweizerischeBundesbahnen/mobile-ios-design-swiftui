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
        self.modifier(SBBSliderModifier())
    }
    
    /**
     Applies SBB styling to a Slider View.
     
     ## Overview
     You create a normal Slider and apply the .sbbStyle() ViewModifier::
     ```swift
     var body: some View {
        Slider(value: .constant(50.0), in: 0.0...100.0, step: 1.0)
            .sbbStyle(imageLeft: Image(sbbIcon: .walk_slow_small), imageRight: Image(sbbIcon: .walk_fast_small))
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
            self.modifier(SBBSliderModifier())
            imageRight
                .resizeToContentSizeCategory(originalHeight: 24)
        }
    }
}

struct SBBSliderModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear {
                UISlider.appearance().minimumTrackTintColor = UIColor(Color.sbbColor(.red))
                UISlider.appearance().maximumTrackTintColor = UIColor(Color.sbbColorInternal(.sliderSwitchInactive))
            }
    }
}

