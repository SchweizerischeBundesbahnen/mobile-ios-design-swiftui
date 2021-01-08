//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public struct SliderDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @State var sliderValue = 50.0
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                Slider(value: $sliderValue, in: 0.0...100.0, step: 1.0)
                    .sbbStyle()
                Slider(value: $sliderValue, in: 0.0...100.0, step: 1.0)
                    .sbbStyle(imageLeft: Image(sbbName: "walk-slow", size: .small), imageRight: Image(sbbName: "walk-fast", size: .small))
                Text("Selected value: \(Int(sliderValue))%")
                    .sbbFont(.body)
            }
            .padding(16)
        }
            .navigationBarTitle("SBBSlider")
            .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.bottom))
            .colorScheme(colorScheme)
    }
}

struct SliderDemo_Previews: PreviewProvider {
    @State static var lightScheme: ColorScheme = .light
    @State static var darkScheme: ColorScheme = .dark
    
    static var previews: some View {
        Group {
            SliderDemo(colorScheme: $lightScheme)
                .previewDisplayName("Light")
            SliderDemo(colorScheme: $darkScheme)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
            SliderDemo(colorScheme: $lightScheme)
                .previewDisplayName("Accessibility XXXL")
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        }
            .previewLayout(.sizeThatFits)
    }
}
