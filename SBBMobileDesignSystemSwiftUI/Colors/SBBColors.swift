//
//  Copyright © 2020 SBB. All rights reserved.
//

import Foundation
import SwiftUI

public extension Color {
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
    static func sbbColor(_ name: SBBColorName) -> UIColor {
        return UIColor(named: name.rawValue, in: Helper.bundle, compatibleWith: nil) ?? UIColor.white
    }
}

internal extension UIColor {
    static func sbbColorInternal(_ name: SBBColorNameInternal) -> UIColor {
        return UIColor(named: name.rawValue, in: Helper.bundle, compatibleWith: nil) ?? UIColor.white
    }
}

