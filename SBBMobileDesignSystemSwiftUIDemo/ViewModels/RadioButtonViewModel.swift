//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

class RadioButtonViewModel: ObservableObject {
    @Published var isOn1 = true {
        didSet {
            if isOn1 {
                isOn2 = false
                isOn3 = false
            }
        }
    }
    @Published var isOn2 = false {
        didSet {
            if isOn2 {
                isOn1 = false
                isOn3 = false
            }
        }
    }
    @Published var isOn3 = false {
        didSet {
            if isOn3 {
                isOn1 = false
                isOn2 = false
            }
        }
    }
}
