//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

/// A  View that is used to highlight content on a map.
public struct SBBMapMarker: View {
   
    /// SBBMapMarker Style (background color, foreground color is always white).
    public enum Style {
        /// Red background for the SBBMapMarker.
        case red
        /// Blue background for the SBBMapMarker (mandatory when using SBB pictograms as icon).
        case blue
        /// Black background for the SBBMapMarker.
        case black
        
        var backgroundImage: Image {
            switch self {
            case .red:
                return Image("MapMarker_red", bundle: Helper.bundle)
            case .blue:
                return Image("MapMarker_blue", bundle: Helper.bundle)
            case .black:
                return Image("MapMarker_black", bundle: Helper.bundle)
            }
        }
    }
    
    private let icon: Image
    private let style: Style
    
    /**
     Returns a SBBMapMarker with an icon.
     
     - Parameters:
        - icon: The Image to be shown on the SBBMapMarker.
        - style: The background color style of the SBBMapMarker. Needs to be blue when using SBB pictograms as icon.
     */
    public init(icon: Image, style: Style = .red) {
        self.icon = icon
        self.style = style
    }
    
    public var body: some View {
        style.backgroundImage
            .frame(width: 24, height: 34)
            .overlay(
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .padding(.top, 4)
                    .foregroundColor(.sbbColor(.white))
                , alignment: .top)
            .accessibilityElement(children: .combine)
    }
}

struct SBBMapMarker_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBMapMarker(icon: Image(sbbName: "construction"))
                .previewDisplayName("Red, light")
            SBBMapMarker(icon: Image(sbbName: "construction"))
                .previewDisplayName("Red, dark")
                .environment(\.colorScheme, .dark)
            SBBMapMarker(icon: Image(sbbName: "Zug_r"), style: .blue)
                .previewDisplayName("Blue, light")
            SBBMapMarker(icon: Image(sbbName: "Zug_r"), style: .blue)
                .previewDisplayName("Blue, dark")
                .environment(\.colorScheme, .dark)
            SBBMapMarker(icon: Image(sbbName: "station", size: .small), style: .black)
                .previewDisplayName("Black, light")
            SBBMapMarker(icon: Image(sbbName: "station", size: .small), style: .black)
                .previewDisplayName("Black, dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}
