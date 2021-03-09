//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension View {
    
    func sbbEnvironmentBanner(_ banner: SBBEnvironmentBanner?) -> some View {
        return ZStack(alignment: .topTrailing) {
            self
            if banner != nil {
                EnvironmentBannerView(text: banner!.text, textColor: banner!.textColor, backgroundColor: banner!.backgroundColor)
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
    
    var text: Text {
        switch self {
        case .test:
            return Text("test")
        case .dev:
            return Text("dev")
        case .int:
            return Text("int")
        }
    }

    var textColor: Color {
        switch self {
        case .test:
            return Color.sbbColor(.black)
        case .dev, .int:
            return Color.sbbColor(.white)
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .test:
            return Color.sbbColor(.lemon)
        case .dev:
            return Color.sbbColor(.night)
        case .int:
            return Color.sbbColor(.black)
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
