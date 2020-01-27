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
    var size: CGFloat?
    var lineSpacing: CGFloat?
  
    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size ?? font.fontParameters.size)
        return content.font(.custom(font.fontParameters.name, size: scaledSize)).lineSpacing(lineSpacing ?? font.fontParameters.lineSpacing)
    }
}

public extension View {
    func sbbFont(_ font: SBBFont, size: CGFloat? = nil, lineSpacing: CGFloat? = nil) -> some View {
        return self.modifier(ScaledFont(font: font, size: size, lineSpacing: lineSpacing))
    }
}

struct FontParameters {
    let name: String
    let size: CGFloat
    let lineSpacing: CGFloat
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
        case .header: return FontParameters(name: "SBBWeb-Light", size: 22, lineSpacing: 2)
        case .headline: return FontParameters(name: "SBBWeb-Bold", size: 18, lineSpacing: 4)
        case .titleDefault: return FontParameters(name: "SBBWeb-Bold", size: 16, lineSpacing: 6)
        case .titleModul: return FontParameters(name: "SBBWeb-Light", size: 18, lineSpacing: 8)
        case .subtitle: return FontParameters(name: "SBBWeb-Bold", size: 14, lineSpacing: 6)
        case .copy: return FontParameters(name: "SBBWeb-Light", size: 18, lineSpacing: 6)
        case .body: return FontParameters(name: "SBBWeb-Light", size: 16, lineSpacing: 4)
        case .legend: return FontParameters(name: "SBBWeb-Light", size: 14, lineSpacing: 6)
        case .legendSmall: return FontParameters(name: "SBBWeb-Light", size: 12, lineSpacing: 8)
        }
    }
}
