//
//  Copyright © 2020 SBB. All rights reserved.
//

import Foundation
import UIKit

public extension UIFont {
    
    /// SBB Font for headers.
    static var sbbHeader: UIFont {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 22) : sbbLight(size: 22)
    }

    /// SBB Font for headlines.
    static var sbbHeadline: UIFont {
        sbbBold(size: 18)
    }

    /// SBB Font for default titles.
    static var sbbTitleDefault: UIFont {
        sbbBold(size: 16)
    }

    /// SBB Font for title modules.
    static var sbbTitleModul: UIFont {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 18) : sbbLight(size: 18)
    }

    /// SBB Font for subtitles.
    static var sbbSubtitle: UIFont {
        sbbBold(size: 14)
    }

    /// SBB Font in copy style.
    static var sbbCopy: UIFont {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 18) : sbbLight(size: 18)
    }

    /// SBB Font for body.
    static var sbbBody: UIFont {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 16) : sbbLight(size: 16)
    }

    /// SBB Font for legends.
    static var sbbLegend: UIFont {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 14) : sbbLight(size: 14)
    }

    /// SBB Font for legends (small size).
    static var sbbLegendSmall: UIFont {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 12) : sbbLight(size: 12)
    }

    /// SBB Font for table headers.
    static var sbbTableHeader: UIFont {
        UIAccessibility.isBoldTextEnabled ? sbbBold(size: 14) : sbbRoman(size: 14)
    }

    /**
     Returns a SBB Font with bold style.
     
     - Parameters:
        - size: The size of the Font.
     */
    static func sbbBold(size: CGFloat) -> UIFont {
        UIFont(name: "SBBWeb-Bold", size: UIFontMetrics.default.scaledValue(for: size))
            ?? .systemFont(ofSize: size, weight: .bold)
    }
    
    /**
     Returns a SBB Font with bold and condensed style.
     
     - Parameters:
        - size: The size of the Font.
     */
    static func sbbBoldCondensed(size: CGFloat) -> UIFont {
        UIFont(name: "SBBWebCondensed-Bold", size: UIFontMetrics.default.scaledValue(for: size))
            ?? .systemFont(ofSize: size, weight: .semibold)
    }
    
    /**
     Returns a SBB Font with heavy and condensed style.
     
     - Parameters:
        - size: The size of the Font.
     */
    static func sbbHeavyCondensed(size: CGFloat) -> UIFont {
        UIFont(name: "SBBWebCondensed-Heavy", size: UIFontMetrics.default.scaledValue(for: size))
            ?? .systemFont(ofSize: size, weight: .heavy)
    }
    
    /**
     Returns a SBB Font with italic style.
     
     - Parameters:
        - size: The size of the Font.
     */
    static func sbbItalic(size: CGFloat) -> UIFont {
        UIFont(name: "SBBWeb-Italic", size: UIFontMetrics.default.scaledValue(for: size))
            ?? .italicSystemFont(ofSize: UIFontMetrics.default.scaledValue(for: size))
    }
    
    /**
     Returns a SBB Font with light style.
     
     - Parameters:
        - size: The size of the Font.
     */
    static func sbbLight(size: CGFloat) -> UIFont {
        UIFont(name: "SBBWeb-Light", size: UIFontMetrics.default.scaledValue(for: size))
            ?? .systemFont(ofSize: size, weight: .light)
    }
    
    /**
     Returns a SBB Font with roman style.
     
     - Parameters:
        - size: The size of the Font.
     */
    static func sbbRoman(size: CGFloat) -> UIFont {
        UIFont(name: "SBBWeb-Roman", size: UIFontMetrics.default.scaledValue(for: size))
            ?? .systemFont(ofSize: size, weight: .regular)
    }
    
    /**
     Returns a SBB Font with thin style.
     
     - Parameters:
        - size: The size of the Font.
     */
    static func sbbThin(size: CGFloat) -> UIFont {
        UIFont(name: "SBBWeb-Thin", size: UIFontMetrics.default.scaledValue(for: size))
            ?? .systemFont(ofSize: size, weight: .thin)
    }
    
    /**
     Returns a SBB Font with ultralight style.
     
     - Parameters:
        - size: The size of the Font.
     */
    static func sbbUltralight(size: CGFloat) -> UIFont {
        UIFont(name: "SBBWeb-UltraLight", size: UIFontMetrics.default.scaledValue(for: size))
            ?? .systemFont(ofSize: size, weight: .ultraLight)
    }
}
