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

public extension Font {
    
    static var sbbHeader: Font {
        .sbbLight(size: 22)
    }
    
    static var sbbHeadline: Font {
        .sbbBold(size: 18)
    }
    
    static var sbbTitleDefault: Font {
        .sbbBold(size: 16)
    }
    
    static var sbbTitleModul: Font {
        .sbbLight(size: 18)
    }
    
    static var sbbSubtitle: Font {
        .sbbBold(size: 14)
    }
    
    static var sbbCopy: Font {
        .sbbLight(size: 18)
    }
    
    static var sbbBody: Font {
        .sbbLight(size: 16)
    }
    
    static var sbbLegend: Font {
        .sbbLight(size: 14)
    }
    
    static var sbbLegendSmall: Font {
        .sbbLight(size: 12)
    }
    
    static var sbbTableHeader: Font {
        .sbbRoman(size: 14)
    }
    
    static func sbbBold(size: CGFloat) -> Font {
        Font.custom("SBBWeb-Bold", size: UIFontMetrics.default.scaledValue(for: size))
    }
    static func sbbBoldCondensed(size: CGFloat) -> Font {
        Font.custom("SBBWebCondensed-Bold", size: UIFontMetrics.default.scaledValue(for: size))
    }
    static func sbbHeavyCondensed(size: CGFloat) -> Font {
        Font.custom("SBBWebCondensed-Heavy", size: UIFontMetrics.default.scaledValue(for: size))
    }
    static func sbbItalic(size: CGFloat) -> Font {
        Font.custom("SBBWeb-Italic", size: UIFontMetrics.default.scaledValue(for: size))
    }
    static func sbbLight(size: CGFloat) -> Font {
        Font.custom("SBBWeb-Light", size: UIFontMetrics.default.scaledValue(for: size))
    }
    static func sbbRoman(size: CGFloat) -> Font {
        Font.custom("SBBWeb-Roman", size: UIFontMetrics.default.scaledValue(for: size))
    }
    static func sbbThin(size: CGFloat) -> Font {
        Font.custom("SBBWeb-Thin", size: UIFontMetrics.default.scaledValue(for: size))
    }
    static func sbbUltralight(size: CGFloat) -> Font {
        Font.custom("SBBWeb-UltraLight", size: UIFontMetrics.default.scaledValue(for: size))
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
    case tableHeader
    
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
        case .tableHeader: return FontParameters(name: "SBBWeb-Roman", size: 14, lineSpacing: 0)
        }
    }
}
