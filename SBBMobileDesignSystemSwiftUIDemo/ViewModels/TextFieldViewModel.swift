//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

class TextFieldViewModel: ObservableObject {
    @Published var showError = false {
        didSet {
            if showError {
                error = "Error"
            } else {
                error = nil
            }
        }
    }
    @Published var error: String? = nil
}
