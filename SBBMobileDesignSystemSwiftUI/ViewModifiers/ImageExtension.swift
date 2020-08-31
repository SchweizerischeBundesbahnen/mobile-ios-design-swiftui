//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public enum SBBIconSize: String {
    case small = "small"
    case medium = "medium"
    case large = "large"
}

public extension Image {
    
    init(sbbName: String) {
        self.init(sbbName, bundle: Helper.bundle)
    }
    
    init(sbbName: String, size: SBBIconSize) {
        self.init("\(sbbName)-\(size.rawValue)", bundle: Helper.bundle)
    }
    
    func resizeToContentSizeCategory(originalHeight: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: UIFontMetrics.default.scaledValue(for: originalHeight))
    }
}
