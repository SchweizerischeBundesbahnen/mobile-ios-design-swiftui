//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import SwiftUI

// Usage: .font(.sbbBody) or .font(.sbbLight(size: 12))

public extension Font {
        
    static var sbbHeader: Font {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 22) : sbbLight(size: 22)
    }
    
    static var sbbHeadline: Font {
        sbbBold(size: 18)
    }
    
    static var sbbTitleDefault: Font {
        sbbBold(size: 16)
    }
    
    static var sbbTitleModul: Font {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 18) : sbbLight(size: 18)
    }
    
    static var sbbSubtitle: Font {
        sbbBold(size: 14)
    }
    
    static var sbbCopy: Font {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 18) : sbbLight(size: 18)
    }
    
    static var sbbBody: Font {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 16) : sbbLight(size: 16)
    }
    
    static var sbbLegend: Font {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 14) : sbbLight(size: 14)
    }
    
    static var sbbLegendSmall: Font {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 12) : sbbLight(size: 12)
    }
    
    static var sbbTableHeader: Font {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 14) : sbbRoman(size: 14)
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
