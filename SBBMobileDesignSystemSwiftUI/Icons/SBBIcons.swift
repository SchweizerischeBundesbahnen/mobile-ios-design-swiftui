//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2019.
//

import Foundation
import SwiftUI

public extension Image {
    init(_ sbbIcon: SBBIcon) {
        if let img = UIImage(named: sbbIcon.rawValue, in: Helper.bundle, with: nil) {
            self.init(uiImage: img)
        } else {
            self.init(systemName: "photo")
        }
    }
}

public enum SBBIcon: String {
    case chevronSmallDown = "chevron_small_down"
    case chevronSmallUp = "chevron_small_up"
}
