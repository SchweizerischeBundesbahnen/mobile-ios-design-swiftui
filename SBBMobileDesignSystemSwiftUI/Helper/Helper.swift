//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation

class Helper {
    
    static var bundle: Bundle {
        get {
            Bundle(for: Helper.self)
        }
    }
}

extension String {
    func localize() -> String{
        let s =  NSLocalizedString(self, tableName: nil, bundle: Helper.bundle, value: "", comment: "")
        return s
    }
}
