//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import SwiftUI

// Usage: .sbbFont(.sbb_legend)
// Custom font dynamic sizing does not seem to work inside the PreviewProvider atm (SwiftUI bug?)

struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var font: SBBFont
  
    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: font.fontParameters.size)
        return content.font(.custom(font.fontParameters.name, size: scaledSize))
    }
}

public extension View {
    func sbbFont(_ font: SBBFont) -> some View {
        return self.modifier(ScaledFont(font: font))
    }
}

struct FontParameters {
    let name: String
    let size: CGFloat
}

public enum SBBFont {
    case header
    case headline
    case titleDefault
    case titleModul
    case subtitle
    case copy
    case body
    case legend
    case legendSmall
    
    var fontParameters: FontParameters {
        switch self {
        case .header: return FontParameters(name: "SBBWeb-Light", size: 22)
        case .headline: return FontParameters(name: "SBBWeb-Bold", size: 18)
        case .titleDefault: return FontParameters(name: "SBBWeb-Bold", size: 16)
        case .titleModul: return FontParameters(name: "SBBWeb-Light", size: 18)
        case .subtitle: return FontParameters(name: "SBBWeb-Bold", size: 14)
        case .copy: return FontParameters(name: "SBBWeb-Light", size: 18)
        case .body: return FontParameters(name: "SBBWeb-Light", size: 16)
        case .legend: return FontParameters(name: "SBBWeb-Light", size: 14)
        case .legendSmall: return FontParameters(name: "SBBWeb-Light", size: 12)
        }
    }
}
