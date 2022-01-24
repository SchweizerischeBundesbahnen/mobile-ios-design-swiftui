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
    
    public var segmentWidth: CGFloat
    public var segmentWidths: [CGSize]
    
    public var barHeight: CGFloat
    public var barWidth: CGFloat
    
    public var buttonHeight: CGFloat
    public var buttonWidth: CGFloat
    
    public init(circleRadius: CGFloat, circlePad: CGFloat, topPad: CGFloat, segmentWidth: CGFloat, segmentWidths: [CGSize], barHeight: CGFloat, barWidth: CGFloat, buttonHeight: CGFloat, buttonWidth: CGFloat) {
        self.circleRadius = circleRadius
        self.circlePad = circlePad
        self.topPad = topPad
        self.segmentWidth = segmentWidth
        self.segmentWidths = segmentWidths
        self.barHeight = barHeight
        self.barWidth = barWidth
        self.buttonHeight = buttonHeight
        self.buttonWidth = buttonWidth
    }
}
