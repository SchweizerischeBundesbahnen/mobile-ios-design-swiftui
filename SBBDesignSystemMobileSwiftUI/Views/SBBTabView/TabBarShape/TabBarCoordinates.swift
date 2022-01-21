//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

/**
 Coordinates used to create the tab bar
 */
public struct TabBarCoordinates {
    private let tab: Int
    public let factor: CGFloat
    private let isPortrait: Bool
    private let parameters: TabBarParameters
    
    public init(tab: Int, factor: CGFloat, isPortrait: Bool, parameters: TabBarParameters) {
        self.tab = tab
        self.factor = factor
        self.isPortrait = isPortrait
        self.parameters = parameters
    }
    
    private var tabOffset: CGFloat {
        let offsetX = parameters.segmentWidth * CGFloat(tab)
        let padding = parameters.segmentWidth / 2 - parameters.circleRadius - parameters.circlePad
        if isPortrait {
            return offsetX + padding
        } else {
            return offsetX + padding - parameters.segmentWidths[tab].width / 2
        }
    }
    
    private var leftX: CGFloat { return tabOffset}
    private var middleX: CGFloat { return leftX + parameters.circlePad + parameters.circleRadius }
    private var rightX: CGFloat { return tabOffset + 2 * (parameters.circleRadius + parameters.circlePad)}
    private var bottomY: CGFloat { return (2 * parameters.circleRadius + parameters.circlePad + parameters.topPad) }
    private var middle2Y: CGFloat { return (bottomY - parameters.circlePad - parameters.circleRadius)}
    private var middle1Y: CGFloat { return (bottomY - middle2Y) }
    
    // Length of control vector if we want to approximate a quarter circle
    private var circleControl: CGFloat { return isPortrait ? sqrt(4 * tan(.pi / 8) / 3) * parameters.circleRadius : sqrt(4 * tan(.pi / 8) / 3) * parameters.circleRadius * 0.9 }
    public var circleControlScaled: CGFloat { return circleControl * (1 - factor) }
    
    // Points
    public var middleHeight: CGFloat { return bottomY / 2 }
    
    public var startLeftCurve: CGPoint { return CGPoint(x: leftX - parameters.circleRadius, y: 0) }
    public var endLeftCurve: CGPoint { return CGPoint(x: leftX, y: middle1Y * factor) }
    
    public var startMiddleLeftCurve: CGPoint { return CGPoint(x: leftX, y: middle2Y * factor) }
    public var middleCircle: CGPoint { return CGPoint(x: middleX, y: bottomY * factor) }
    public var endMiddleRightCurve: CGPoint { return CGPoint(x: rightX, y: middle2Y * factor) }
    public var startRightCurve: CGPoint { return CGPoint(x: rightX, y: (middle2Y + parameters.topPad) * factor) }
    public var endRightCurve: CGPoint { return CGPoint(x: rightX + parameters.circleRadius, y: 0) }
    
    // Control points
    public var control1Left: CGPoint { return CGPoint(x: leftX - parameters.circleRadius + circleControl, y: 0) }
    public var control2Left: CGPoint { return CGPoint(x: leftX, y: (middle1Y - circleControl) * factor) }
    
    public var control1MiddleLeft: CGPoint { return CGPoint(x: leftX, y: (middle2Y + circleControl) * factor) }
    public var control2MiddleLeft: CGPoint { return CGPoint(x: middleX - circleControl, y: bottomY * factor) }
    
    public var control1Middle: CGPoint { return CGPoint(x: leftX + circleControlScaled, y: (middle2Y + circleControl) * factor) }
    public var control2Middle: CGPoint { return CGPoint(x: rightX - circleControlScaled, y: (middle2Y + circleControl) * factor) }
    
    public var control1MiddleRight: CGPoint { return CGPoint(x: middleX + circleControl, y: bottomY * factor) }
    public var control2MiddleRight: CGPoint { return CGPoint(x: rightX, y: (middle2Y + circleControl) * factor) }
    
    public var control1Right: CGPoint { return  CGPoint(x: rightX, y: (middle2Y - circleControl) * factor) }
    public var control2Right: CGPoint { return  CGPoint(x: rightX + parameters.circleRadius - circleControl, y: 0) }
    
}
