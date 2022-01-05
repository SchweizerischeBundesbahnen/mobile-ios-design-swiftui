//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import Foundation

enum CheckBoxAndRadioButtonContainerType {
    case checkbox
    case radioButton
    
    var iconPrefix: String {
        switch self {
        case .checkbox:
            return "Checkbox"
        case .radioButton:
            return "RadioButton"
        }
    }
}
