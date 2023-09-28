//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import Foundation

public enum StatusType: CaseIterable {
    /// Used for alert: red
    case alert
    /// Used for warnings: yellow
    case warning
    /// Used for successes: green
    case success
    /// Used for info: grey
    case info
}
