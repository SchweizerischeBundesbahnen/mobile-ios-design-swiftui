//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct MapMarkerDemo: View {
    @Binding var colorScheme: ColorScheme
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                SBBInfoView(image: Image(sbbName: "circle-information", size: .small), text: Text("There are 3 available map marker styles: .red, .blue and .black. Use .blue style for pictograms."))
                HStack(spacing: 16) {
                    SBBMapMarker(icon: Image(sbbName: "construction"))
                    SBBMapMarker(icon: Image(sbbName: "Zug_r"), style: .blue)
                    SBBMapMarker(icon: Image(sbbName: "station", size: .small), style: .black)
                }
            }
                .padding(16)
        }
            .navigationBarTitle("Map Marker")
            .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.bottom))
            .colorScheme(colorScheme)
    }
}

struct MapMarkerDemo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MapMarkerDemo(colorScheme: .constant(.light))
                .previewDisplayName("Light")
            MapMarkerDemo(colorScheme: .constant(.dark))
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
            MapMarkerDemo(colorScheme: .constant(.light))
                .previewDisplayName("Accessibility XXXL")
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        }
    }
}
