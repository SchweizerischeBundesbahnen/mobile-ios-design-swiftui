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
    
    case xlarge_light
    case large_light
    case large_bold
    case medium_light
    case medium_bold
    case small_light
    case small_bold
    case xsmall_light
    case xsmall_bold
    
    /// SBBFont type for headers.
    @available(*, deprecated, message: "not used anymore in DSM")
    case header
    /// SBBFont type for headlines.
    @available(*, deprecated, message: "use large_bold instead")
    case headline
    /// SBBFont type for default titles.
    @available(*, deprecated, message: "use medium_bold instead")
    case titleDefault
    /// SBBFont type for title modules.
    @available(*, deprecated, message: "use large_light instead")
    case titleModul
    /// SBBFont type for subtitles.
    @available(*, deprecated, message: "use small_bold instead")
    case subtitle
    /// SBBFont type for copy styles.
    @available(*, deprecated, message: "use large_light instead")
    case copy
    /// SBBFont type for body.
    @available(*, deprecated, message: "use medium_light instead")
    case body
    /// SBBFont type for legends.
    @available(*, deprecated, message: "use small_light instead")
    case legend
    /// SBBFont type for legends (small style).
    @available(*, deprecated, message: "use xsmall_light instead")
    case legendSmall
    
    /// SBBFont type for table headers.
    case tableHeader
    
    var font: Font {
        switch self {
            
        case .xlarge_light: return .xlarge_light
        case .large_light: return .large_light
        case .large_bold: return .large_bold
        case .medium_light: return .medium_light
        case .medium_bold: return .medium_bold
        case .small_light: return .small_light
        case .small_bold: return .small_bold
        case .xsmall_light: return .xsmall_light
        case .xsmall_bold: return .xsmall_bold
            
            // deprecated
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
            
        case .xlarge_light: return .xlarge_light
        case .large_light: return .large_light
        case .large_bold: return .large_bold
        case .medium_light: return .medium_light
        case .medium_bold: return .medium_bold
        case .small_light: return .small_light
        case .small_bold: return .small_bold
        case .xsmall_light: return .xsmall_light
        case .xsmall_bold: return .xsmall_bold
            
            // deprecated
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
            
        case .xlarge_light: return 2
        case .large_light: return 4
        case .large_bold: return 4
        case .medium_light: return 6
        case .medium_bold: return 6
        case .small_light: return 6
        case .small_bold: return 6
        case .xsmall_light: return 8
        case .xsmall_bold: return 8
            
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
