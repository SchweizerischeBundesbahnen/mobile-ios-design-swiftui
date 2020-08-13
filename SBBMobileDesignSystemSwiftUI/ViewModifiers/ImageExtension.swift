//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public enum SBBIconSize: String {
    case small = "small"
    case medium = "medium"
    case large = "large"
}

extension Image {
    
    public init(sbbName: String) {
        self.init(sbbName, bundle: Helper.bundle)
    }
    
    public init(sbbName: String, size: SBBIconSize) {
        self.init("\(sbbName)-\(size.rawValue)", bundle: Helper.bundle)
    }
    
    public func resizeToContentSizeCategory(originalHeight: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: UIFontMetrics.default.scaledValue(for: originalHeight))
    }
}
