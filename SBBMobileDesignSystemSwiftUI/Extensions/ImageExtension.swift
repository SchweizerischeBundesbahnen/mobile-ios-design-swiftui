//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

extension Image {
    public func resizeToContentSizeCategory(originalHeight: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: UIFontMetrics.default.scaledValue(for: originalHeight))
    }
}
