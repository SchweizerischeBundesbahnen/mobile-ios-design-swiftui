//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension View {
    
    func sbbEnvironmentBanner(_ banner: SBBEnvironmentBanner?) -> some View {
        return ZStack(alignment: .topTrailing) {
            self
            if let banner = banner {
                EnvironmentBannerView(text: banner.text, textColor: banner.textColor, backgroundColor: banner.backgroundColor)
            }
        }
    }
    
    func sbbEnvironmentBanner(_ text: Text, textColor: Color = Color.sbbColor(.black), backgroundColor: Color = Color.sbbColor(.lemon)) -> some View {
        return ZStack(alignment: .topTrailing) {
            self
            EnvironmentBannerView(text: text, textColor: textColor, backgroundColor: backgroundColor)
        }
    }
}

public enum SBBEnvironmentBanner {
    case test
    case dev
    case int
    case poc
    
    var text: Text {
        switch self {
        case .test:
            return Text("test")
        case .dev:
            return Text("dev")
        case .int:
            return Text("int")
        case .poc:
            return Text("poc")
        }
    }

    var textColor: Color {
        switch self {
        case .dev:
            return Color.sbbColor(.black)
        case .test, .int, .poc:
            return Color.sbbColor(.white)
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .test:
            return Color.sbbColor(.night)
        case .dev:
            return Color.sbbColor(.lemon)
        case .int:
            return Color.sbbColor(.black)
        case .poc:
            return Color.sbbColor(.violet)
        }
    }
}

struct EnvironmentBannerView: View {
    
    let text: Text
    let textColor: Color
    let backgroundColor: Color
    
    var body: some View {
        text
            .frame(width: 300, height: 18, alignment: .center)
            .background(backgroundColor)
            .rotationEffect(.init(degrees: 45))
            .position(x: 44, y: 16)
            .sbbFont(.legendSmall)
            .foregroundColor(textColor)
            .clipped()
            .frame(width: 60, height: 44)
            .accessibility(hidden: true)
    }
}
