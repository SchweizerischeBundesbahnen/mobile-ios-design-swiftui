//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public struct SBBMapMarker: View {
    
    public enum Style {
        case red
        case blue
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
