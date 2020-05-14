//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import SwiftUI

// Usage: .font(.sbbBody) or .font(.sbbBody(size: 12))

public extension Font {
    
    static var sbbHeader: Font {
        sbbLight(size: 22)
    }
    
    static var sbbHeadline: Font {
        sbbBold(size: 18)
    }
    
    static var sbbTitleDefault: Font {
        sbbBold(size: 16)
    }
    
    static var sbbTitleModul: Font {
        sbbLight(size: 18)
    }
    
    static var sbbSubtitle: Font {
        sbbBold(size: 14)
    }
    
    static var sbbCopy: Font {
        sbbLight(size: 18)
    }
    
    static var sbbBody: Font {
        sbbLight(size: 16)
    }
    
    static var sbbLegend: Font {
        sbbLight(size: 14)
    }
    
    static var sbbLegendSmall: Font {
        sbbLight(size: 12)
    }
    
    static var sbbTableHeader: Font {
        sbbRoman(size: 14)
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
