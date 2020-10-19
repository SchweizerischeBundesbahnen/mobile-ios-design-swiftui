//
//  Copyright © 2020 SBB. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
static var sbbHeader: UIFont {
    UIAccessibility.isBoldTextEnabled ? sbbBold(size: 22) : sbbLight(size: 22)
}

static var sbbHeadline: UIFont {
    sbbBold(size: 18)
}

static var sbbTitleDefault: UIFont {
    sbbBold(size: 16)
}

static var sbbTitleModul: UIFont {
    UIAccessibility.isBoldTextEnabled ? sbbBold(size: 18) : sbbLight(size: 18)
}

static var sbbSubtitle: UIFont {
    sbbBold(size: 14)
}

static var sbbCopy: UIFont {
    UIAccessibility.isBoldTextEnabled ? sbbBold(size: 18) : sbbLight(size: 18)
}

static var sbbBody: UIFont {
    UIAccessibility.isBoldTextEnabled ? sbbBold(size: 16) : sbbLight(size: 16)
}

static var sbbLegend: UIFont {
    UIAccessibility.isBoldTextEnabled ? sbbBold(size: 14) : sbbLight(size: 14)
}

static var sbbLegendSmall: UIFont {
    UIAccessibility.isBoldTextEnabled ? sbbBold(size: 12) : sbbLight(size: 12)
}

static var sbbTableHeader: UIFont {
    UIAccessibility.isBoldTextEnabled ? sbbBold(size: 14) : sbbRoman(size: 14)
}

static func sbbBold(size: CGFloat) -> UIFont {
    UIFont(name: "SBBWeb-Bold", size: UIFontMetrics.default.scaledValue(for: size))
        ?? .systemFont(ofSize: size, weight: .bold)
}
static func sbbBoldCondensed(size: CGFloat) -> UIFont {
    UIFont(name: "SBBWebCondensed-Bold", size: UIFontMetrics.default.scaledValue(for: size))
        ?? .systemFont(ofSize: size, weight: .semibold)
}
static func sbbHeavyCondensed(size: CGFloat) -> UIFont {
    UIFont(name: "SBBWebCondensed-Heavy", size: UIFontMetrics.default.scaledValue(for: size))
        ?? .systemFont(ofSize: size, weight: .heavy)
}
static func sbbItalic(size: CGFloat) -> UIFont {
    UIFont(name: "SBBWeb-Italic", size: UIFontMetrics.default.scaledValue(for: size))
        ?? .italicSystemFont(ofSize: UIFontMetrics.default.scaledValue(for: size))
}
static func sbbLight(size: CGFloat) -> UIFont {
    UIFont(name: "SBBWeb-Light", size: UIFontMetrics.default.scaledValue(for: size))
        ?? .systemFont(ofSize: size, weight: .light)
}
static func sbbRoman(size: CGFloat) -> UIFont {
    UIFont(name: "SBBWeb-Roman", size: UIFontMetrics.default.scaledValue(for: size))
        ?? .systemFont(ofSize: size, weight: .regular)
}
static func sbbThin(size: CGFloat) -> UIFont {
    UIFont(name: "SBBWeb-Thin", size: UIFontMetrics.default.scaledValue(for: size))
        ?? .systemFont(ofSize: size, weight: .thin)
}
static func sbbUltralight(size: CGFloat) -> UIFont {
    UIFont(name: "SBBWeb-UltraLight", size: UIFontMetrics.default.scaledValue(for: size))
        ?? .systemFont(ofSize: size, weight: .ultraLight)
}
}
