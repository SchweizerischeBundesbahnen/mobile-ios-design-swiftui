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
     Checks whether a SBB Icon asset exists in the SBBDesignSystemMobileSwiftUI library for the name.
     
     - Parameters:
        - sbbName: The name of the SBB Icon.
     
     - Returns: A boolean value indicating, whether the specified SBB Icon exists.
     */
    @available(*, deprecated, message: "Please use exists(sbbIcon: SBBIcon)")
    static func exists(sbbName: String) -> Bool {
        return UIImage(named: sbbName, in: Helper.bundle, with: nil) != nil
    }
    
    /**
     Checks whether a SBB Icon asset exists in the SBBDesignSystemMobileSwiftUI library for the name.
     
     - Parameters:
        - sbbIcon: The name of the SBB Icon.
     
     - Returns: A boolean value indicating, whether the specified SBB Icon exists.
     */
    static func exists(sbbIcon: SBBIcon) -> Bool {
        return UIImage(named: sbbIcon.rawValue, in: Helper.bundle, with: nil) != nil
    }
    /**
     Returns a SBB Icon as Image.
        
     Sources:
     Icons: https://digital.sbb.ch/de/brand_elemente/icons
     Fahrplan-Icons: https://digital.sbb.ch/de/brand_elemente/fahrplan-icons
     Piktogramme: https://digital.sbb.ch/de/brand_elemente/piktogramme
     
     There are some images that support changing its color. These are indicated in this file: https://github.com/sbb-design-systems/sbb-icons/blob/main/icons/index.json
     
     ## Overview
     You create an Image using the custom initializer:
     ```swift
     var body: some View {
        Image(sbbIcon: .Zug_r)
        Image(sbbIcon: .ir_40")
     }
     ```
     ![ImageExtensionIconFPL](ImageExtensionIconFPL)
     ![ImageExtensionIconPictogram](ImageExtensionIconPictogram)
     
     - Parameters:
        - sbbIcon: The name of the FPL Icon or Pictogram.
     */
    init(sbbIcon: SBBIcon) {
        self.init(sbbIcon.rawValue, bundle: Helper.bundle)
        self = self.renderingMode(.original)
        if SBBIconsHelper.shared.hasColor(iconName: sbbIcon.rawValue) {
           self = self.renderingMode(.template)
        }
        
    }
    
    /**
     Returns a SBB Icon (FPL Icons and Pictograms) as Image.
     
     ## Overview
     You create an Image using the custom initializer:
     ```swift
     var body: some View {
        Image(sbbName: "Zug_r")
        Image(sbbName: "product-ir-40")
     }
     ```
     ![ImageExtensionIconFPL](ImageExtensionIconFPL)
     ![ImageExtensionIconPictogram](ImageExtensionIconPictogram)
     
     - Parameters:
        - sbbName: The name of the FPL Icon or Pictogram.
     */
    @available(*, deprecated, message: "Please use the init(sbbIcon:) initialiser")
    init(sbbName: String) {
        self.init(sbbName, bundle: Helper.bundle)
    }
    
    /**
     Returns a SBB Icon (KOM Icon) as Image.
     
     ## Overview
     KOM Icons are available in different ``SBBIconSize``s and are rendered as template image (you can change their color). You create an Image using the custom initializer:
     ```swift
     var body: some View {
        Image(sbbName: "station", size: .small)
            .foregroundColor(Color.sbbColor(.textBlack))
     }
     ```
     ![ImageExtensionIconKOM](ImageExtensionIconKOM)
     
     - Parameters:
        - sbbName: The name of the KOM Icon (without size appendix).
        - size: The size of the KOM Icon.
     */
    @available(*, deprecated, message: "Please use the init(sbbIcon:) initialiser")
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
