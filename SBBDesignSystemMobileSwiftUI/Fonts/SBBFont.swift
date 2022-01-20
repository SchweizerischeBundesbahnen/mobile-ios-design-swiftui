//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import SwiftUI

public extension View {
    
    /**
     Returns a SBB Font.
     
     - Parameters:
        - sbbFont: The SBBFont type to be returned.
     */
    func sbbFont(_ sbbFont: SBBFont) -> some View {
        return self.modifier(ScaledFont(sbbFont: sbbFont))  // workaround
        //return self.font(sbbFont.font).lineSpacing(sbbFont.lineSpacing)   // Leads to Segmentation Fault: 11 (if archiving XCode project using SwiftUI DSM over CocoaPods)
    }
}

struct ScaledFont: ViewModifier {
    var sbbFont: SBBFont
  
    func body(content: Content) -> some View {
        return content.font(sbbFont.font).lineSpacing(sbbFont.lineSpacing)
    }
}

/// SBBFont types.
public enum SBBFont {
    /// SBBFont type for headers.
    case header
    /// SBBFont type for headlines.
    case headline
    /// SBBFont type for default titles.
    case titleDefault
    /// SBBFont type for title modules.
    case titleModul
    /// SBBFont type for subtitles.
    case subtitle
    /// SBBFont type for copy styles.
    case copy
    /// SBBFont type for body.
    case body
    /// SBBFont type for legends.
    case legend
    /// SBBFont type for legends (small style).
    case legendSmall
    /// SBBFont type for table headers.
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
    
    var uiFont: UIFont {
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
