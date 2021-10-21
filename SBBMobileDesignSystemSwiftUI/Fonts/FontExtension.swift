//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import SwiftUI

// Usage: .font(.sbbBody) or .font(.sbbLight(size: 12))

public extension Font {
        
    /// SBB Font for headers.
    static var sbbHeader: Font {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 22) : sbbLight(size: 22)
    }
    
    /// SBB Font for headlines.
    static var sbbHeadline: Font {
        sbbBold(size: 18)
    }
    
    /// SBB Font for default titles.
    static var sbbTitleDefault: Font {
        sbbBold(size: 16)
    }
    
    /// SBB Font for title modules.
    static var sbbTitleModul: Font {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 18) : sbbLight(size: 18)
    }
    
    /// SBB Font for subtitles.
    static var sbbSubtitle: Font {
        sbbBold(size: 14)
    }
    
    /// SBB Font in copy style.
    static var sbbCopy: Font {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 18) : sbbLight(size: 18)
    }
    
    /// SBB Font for body.
    static var sbbBody: Font {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 16) : sbbLight(size: 16)
    }
    
    /// SBB Font for legends.
    static var sbbLegend: Font {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 14) : sbbLight(size: 14)
    }
    
    /// SBB Font for legends (small size).
    static var sbbLegendSmall: Font {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 12) : sbbLight(size: 12)
    }
    
    /// SBB Font for table headers.
    static var sbbTableHeader: Font {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 14) : sbbRoman(size: 14)
    }
    
    /**
     Returns a SBB Font with bold style.
     
     - Parameters:
        - size: The size of the Font.
     */
    static func sbbBold(size: CGFloat) -> Font {
        return Font.custom("SBBWeb-Bold", size: size, relativeTo: .body)
    }
    
    /**
     Returns a SBB Font with bold and condensed style.
     
     - Parameters:
        - size: The size of the Font.
     */
    static func sbbBoldCondensed(size: CGFloat) -> Font {
        return Font.custom("SBBWebCondensed-Bold", size: size, relativeTo: .body)
    }
    
    /**
     Returns a SBB Font with heavy and condensed style.
     
     - Parameters:
        - size: The size of the Font.
     */
    static func sbbHeavyCondensed(size: CGFloat) -> Font {
        return Font.custom("SBBWebCondensed-Heavy", size: size, relativeTo: .body)
    }
    
    /**
     Returns a SBB Font with italic style.
     
     - Parameters:
        - size: The size of the Font.
     */
    static func sbbItalic(size: CGFloat) -> Font {
        return Font.custom("SBBWeb-Italic", size: size, relativeTo: .body)
    }
    
    /**
     Returns a SBB Font with light style.
     
     - Parameters:
        - size: The size of the Font.
     */
    static func sbbLight(size: CGFloat) -> Font {
        return Font.custom("SBBWeb-Light", size: size, relativeTo: .body)
    }
    
    /**
     Returns a SBB Font with roman style.
     
     - Parameters:
        - size: The size of the Font.
     */
    static func sbbRoman(size: CGFloat) -> Font {
        return Font.custom("SBBWeb-Roman", size: size, relativeTo: .body)
    }
    
    /**
     Returns a SBB Font with thin style.
     
     - Parameters:
        - size: The size of the Font.
     */
    static func sbbThin(size: CGFloat) -> Font {
        return Font.custom("SBBWeb-Thin", size: size, relativeTo: .body)
    }
    
    /**
     Returns a SBB Font with ultralight style.
     
     - Parameters:
        - size: The size of the Font.
     */
    static func sbbUltralight(size: CGFloat) -> Font {
        return Font.custom("SBBWeb-UltraLight", size: size, relativeTo: .body)
    }
}
