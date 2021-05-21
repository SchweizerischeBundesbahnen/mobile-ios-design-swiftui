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
                poc = false
            }
        }
    }
    @Published var dev = false {
        didSet {
            if dev {
                none = false
                test = false
                int = false
                poc = false
            }
        }
    }
    @Published var test = false {
        didSet {
            if test {
                none = false
                dev = false
                int = false
                poc = false
            }
        }
    }
    @Published var int = false {
        didSet {
            if int {
                none = false
                dev = false
                test = false
                poc = false
            }
        }
    }
    @Published var poc = false {
        didSet {
            if poc {
                none = false
                dev = false
                test = false
                int = false
            }
        }
    }
}
