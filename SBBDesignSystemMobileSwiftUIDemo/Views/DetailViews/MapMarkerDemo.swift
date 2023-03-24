//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct MapMarkerDemo: View {
    @Binding var colorScheme: ColorScheme
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                SBBInfoView(image: Image(sbbIcon: .circle_information_small), text: Text("There are 3 available map marker styles: .primary, .blue and .black. Use .blue style for pictograms."))
                HStack(spacing: 16) {
                    SBBMapMarker(icon: Image(sbbIcon: .construction))
                    SBBMapMarker(icon: Image(sbbIcon: .Zug_r), style: .blue)
                    SBBMapMarker(icon: Image(sbbIcon: .station_small), style: .black)
                }
            }
                .sbbScreenPadding()
        }
            .navigationBarTitle("Map Marker")
            .sbbStyle()
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
