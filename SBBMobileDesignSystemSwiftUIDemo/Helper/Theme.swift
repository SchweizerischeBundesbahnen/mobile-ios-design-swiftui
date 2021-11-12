//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import Foundation
import SBBMobileDesignSystemSwiftUI

enum Theme: CaseIterable {
    
    case sbbDefault
    case night
    
    var sbbTheme: SBBTheme {
        switch self {
        case .sbbDefault:
            return SBBTheme()
        case .night:
            return SBBTheme(primaryColor: .sbbColor(.night), secondaryColor: .sbbColor(.blue))
        }
    }
}
