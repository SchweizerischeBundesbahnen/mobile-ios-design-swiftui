//
//  Copyright © 2020 SBB. All rights reserved.
//

import Foundation
import SwiftUI

public extension Color {
    
    /// The primary color set in SBBTheme which is used for many UI elements (e.g. NavigationBar background, SBBPrimaryButton).
    static var sbbPrimary: Color = Color.sbbColor(.red)
    
    /// The secondary color set in SBBTheme which is used for pressed states/backgrounds of some UI elements (e.g. SBBPrimaryButton in pressed state).
    static var sbbSecondary: Color = Color.sbbColor(.red150)
    
    /**
     Returns a SBB Color.
     
     - Parameters:
        - name: The SBBColorName of the color to be returned.
     */
    static func sbbColor(_ name: SBBColorName) -> Color {
        if name == .primary {
            return sbbPrimary
        } else if name == .secondary {
            return sbbSecondary
        }
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

