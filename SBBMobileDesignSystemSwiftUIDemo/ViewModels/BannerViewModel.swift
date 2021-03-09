//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

class BannerViewModel: ObservableObject {
    @Published var none = true {
        didSet {
            if none {
                dev = false
                test = false
                int = false
            }
        }
    }
    @Published var dev = false {
        didSet {
            if dev {
                none = false
                test = false
                int = false
            }
        }
    }
    @Published var test = false {
        didSet {
            if test {
                none = false
                dev = false
                int = false
            }
        }
    }
    @Published var int = false {
        didSet {
            if int {
                none = false
                dev = false
                test = false
            }
        }
    }
}
