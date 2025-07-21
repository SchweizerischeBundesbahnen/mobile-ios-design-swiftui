//
// Copyright (c) Schweizerische Bundesbahnen SBB, 2025
//  
import SwiftUI

extension View {
    public func multiline(alignment: TextAlignment, lineLimit: Int? = nil, minScaleFactor: CGFloat = 0.1) -> some View {
        self
            .multilineTextAlignment(alignment)
            .lineLimit(lineLimit)
            .minimumScaleFactor(minScaleFactor)
            .fixedSize(horizontal: false, vertical: true)
    }
}
