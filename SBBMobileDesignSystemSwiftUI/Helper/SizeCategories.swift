//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

// Because .isAccessibilityCategory is only available from iOS >= 13.4, we need this workaround, see https://developer.apple.com/documentation/swiftui/contentsizecategory/3516388-isaccessibilitycategory?changes=_8
public struct SizeCategories {
    public static let accessibility: [ContentSizeCategory] = [.accessibilityMedium, .accessibilityLarge, .accessibilityExtraLarge, .accessibilityExtraExtraLarge, .accessibilityExtraExtraExtraLarge]
    public static let xlToXXXL: [ContentSizeCategory] = [.extraLarge, .extraExtraLarge, .extraExtraExtraLarge]
}
