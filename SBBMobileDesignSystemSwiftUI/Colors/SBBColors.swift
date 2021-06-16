//
//  Copyright © 2020 SBB. All rights reserved.
//

import Foundation
import SwiftUI

public extension Color {
    /**
     Returns a SBB Color.
     
     - Parameters:
        - name: The SBBColorName of the color to be returned.
     */
    static func sbbColor(_ name: SBBColorName) -> Color {
        return Color(UIColor.sbbColor(name))
    }
}

internal extension Color {
    static func sbbColorInternal(_ name: SBBColorNameInternal) -> Color {
        return Color(UIColor.sbbColorInternal(name))
    }
}

public extension UIColor {
    /**
     Returns a SBB UIColor.
     
     - Parameters:
        - name: The SBBColorName of the color to be returned.
     */
    static func sbbColor(_ name: SBBColorName) -> UIColor {
        return UIColor(named: name.rawValue, in: Helper.bundle, compatibleWith: nil) ?? UIColor.white
    }
}

internal extension UIColor {
    static func sbbColorInternal(_ name: SBBColorNameInternal) -> UIColor {
        return UIColor(named: name.rawValue, in: Helper.bundle, compatibleWith: nil) ?? UIColor.white
    }
}

