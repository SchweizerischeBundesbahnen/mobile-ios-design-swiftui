//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

/**
 Parameters used to create the tab bar for ``SBBTabView``.
 */
struct TabBarParameters {
    public var circleRadius: CGFloat
    public var circlePad: CGFloat
    public var topPad: CGFloat
    
    public var badgeSize: CGFloat
    public var badgeOffset: CGFloat
    
    public var segmentWidth: CGFloat
    public var segmentWidths: [CGSize]
    
    public var barHeight: CGFloat
    public var barWidth: CGFloat
    
    public var buttonHeight: CGFloat
    public var buttonWidth: CGFloat
    
    public var isPortrait: Bool
    
    public init(circleRadius: CGFloat, circlePad: CGFloat, topPad: CGFloat, badgeSize: CGFloat, badgeOffset: CGFloat, segmentWidth: CGFloat, segmentWidths: [CGSize], barHeight: CGFloat, barWidth: CGFloat, buttonHeight: CGFloat, buttonWidth: CGFloat, isPortrait: Bool) {
        self.circleRadius = circleRadius
        self.circlePad = circlePad
        self.topPad = topPad
        self.badgeSize = badgeSize
        self.badgeOffset = badgeOffset
        self.segmentWidth = segmentWidth
        self.segmentWidths = segmentWidths
        self.barHeight = barHeight
        self.barWidth = barWidth
        self.buttonHeight = buttonHeight
        self.buttonWidth = buttonWidth
        self.isPortrait = isPortrait
    }
}
