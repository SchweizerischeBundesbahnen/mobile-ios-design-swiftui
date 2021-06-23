//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import UIKit

/// SBBIcon sizes (for KOM icons).
public enum SBBIconSize: String {
    /// Small SBBIcon size
    case small = "small"
    /// Medium SBBIcon size
    case medium = "medium"
    /// Large SBBIcon size
    case large = "large"
}

public extension Image {
    
    /**
     Checks whether a SBB Icon asset exists in the SBBMobileDesignSystemSwiftUI library for the name.
     
     - Parameters:
        - sbbName: The name of the SBB Icon.
     
     - Returns: A boolean value indicating, whether the specified SBB Icon exists.
     */
    static func exists(sbbName: String) -> Bool {
        return UIImage(named: sbbName, in: Helper.bundle, with: nil) != nil
    }
    
    /**
     Returns a SBB Icon (FPL Icons and Pictograms) as Image.
     
     - Parameters:
        - sbbName: The name of the FPL Icon or Pictogram.
     */
    init(sbbName: String) {
        self.init(sbbName, bundle: Helper.bundle)
    }
    
    /**
     Returns a SBB Icon (KOM Icon) as Image.
     
     - Parameters:
        - sbbName: The name of the KOM Icon (without size appendix).
        - size: The size of the KOM Icon.
     */
    init(sbbName: String, size: SBBIconSize) {
        self.init("\(sbbName)-\(size.rawValue)", bundle: Helper.bundle)
    }
    
    /**
     Modifies the size of an Image proportionally to the current ContentSizeCategory.
     
     - Parameters:
        - originalHeight: The height of the Image for the .normal ContentSizeCategory.
     
     - Returns: A View containing the proportionally scaled image.
     */
    func resizeToContentSizeCategory(originalHeight: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: UIFontMetrics.default.scaledValue(for: originalHeight))
    }
}
