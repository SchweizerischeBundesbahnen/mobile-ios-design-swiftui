//
//  Copyright © 2020 SBB. All rights reserved.
//

import Foundation

internal struct SBBBundle {
    
    // we load the bundle for the fonts and assets from the Module (for swift package manager (SPM))
    internal static func getBundle() -> Bundle {
        return Bundle.module
    }
    
}

