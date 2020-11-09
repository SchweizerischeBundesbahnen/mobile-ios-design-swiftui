//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation

class Helper {
    
    static var bundle: Bundle {
        get {
            SBBBundle.getBundle()
        }
    }
}

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Helper.bundle, value: "", comment: "")
    }
}
