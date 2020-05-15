//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import SwiftUI

// Usage: .sbbFont(.sbb_legend)
// Custom font dynamic sizing does not seem to work inside the PreviewProvider atm (SwiftUI bug?)

public extension View {
    func sbbFont(_ sbbFont: SBBFont) -> some View {
        return self.font(sbbFont.font).lineSpacing(sbbFont.lineSpacing)
    }
}

public enum SBBFont {
    case header
    case headline
    case titleDefault
    case titleModul
    case subtitle
    case copy
    case body
    case legend
    case legendSmall
    case tableHeader
    
    var font: Font {
        switch self {
        case .header: return .sbbHeader
        case .headline: return .sbbHeadline
        case .titleDefault: return .sbbTitleDefault
        case .titleModul: return .sbbTitleModul
        case .subtitle: return .sbbSubtitle
        case .copy: return .sbbCopy
        case .body: return .sbbBody
        case .legend: return .sbbLegend
        case .legendSmall: return .sbbLegendSmall
        case .tableHeader: return .sbbTableHeader
        }
    }
    
    var lineSpacing: CGFloat {
        switch self {
        case .header: return 2
        case .headline: return 4
        case .titleDefault: return 6
        case .titleModul: return 8
        case .subtitle: return 6
        case .copy: return 6
        case .body: return 4
        case .legend: return 6
        case .legendSmall: return 8
        case .tableHeader: return 0
        }
    }
}
