//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

/**
 Coordinates used to create the tab bar for ``SBBTabView``.
 */
struct TabBarCoordinates {
    private let tab: Int
    public let factor: CGFloat
    private let isPortrait: Bool
    private let parameters: TabBarParameters
    private let isPressed: Bool
    
    public init(tab: Int, factor: CGFloat, isPortrait: Bool, parameters: TabBarParameters, isPressed: Bool) {
        self.tab = tab
        self.factor = factor
        self.isPortrait = isPortrait
        self.parameters = parameters
        self.isPressed = isPressed
    }
    
    private var tabOffset: CGFloat {
        let offsetX = parameters.segmentWidth * CGFloat(tab)
        let padding = parameters.segmentWidth / 2 - parameters.circleRadius - parameters.circlePad
        if self.isPortrait {
            return offsetX + padding
        } else {
            let paddingLandscape = (parameters.segmentWidths[tab].width + 10) / 2
            if self.isPressed {
                return offsetX + padding - paddingLandscape + 5
            } else {
                return offsetX + padding - paddingLandscape
            }
        }
    }
    
    private var leftX: CGFloat { return tabOffset}
    private var middleX: CGFloat { return leftX + parameters.circlePad + parameters.circleRadius }
    private var rightX: CGFloat { return tabOffset + 2 * (parameters.circleRadius + parameters.circlePad)}
    private var bottomY: CGFloat { return (2 * parameters.circleRadius + parameters.circlePad + parameters.topPad) }
    private var middle2Y: CGFloat { return (bottomY - parameters.circlePad - parameters.circleRadius)}
    private var middle1Y: CGFloat { return (bottomY - middle2Y) }
    
    // Length of control vector if we want to approximate a quarter circle
    public var circleControl: CGFloat { return isPortrait ? sqrt(4 * tan(.pi / 8) / 3) * parameters.circleRadius : sqrt(4 * tan(.pi / 8) / 3) * parameters.circleRadius * 0.9 }
    public var circleControlScaled: CGFloat { return circleControl * (1 - factor) }
    
    private var angle: Angle { return Angle(degrees: factor * 180) }
    
    // Points
    public var middleHeight: CGFloat { return bottomY / 2 }
    
    public var startLeftCurve: CGPoint { return CGPoint(x: leftX - parameters.circleRadius, y: 0) }
    public var endLeftCurve: CGPoint { return CGPoint(x: leftX, y: middle1Y * factor) }
    
    public var middleCircle: CGPoint { return CGPoint(x: middleX, y: bottomY * factor) }
    
    public var startMiddleLeftCurve: CGPoint { return CGPoint(x: leftX, y: middle1Y * factor) }
    public var endMiddleRightCurve: CGPoint { return CGPoint(x: rightX, y: middle1Y * factor) }
    
    public var startRightCurve: CGPoint { return CGPoint(x: rightX, y: middle1Y * factor) }
    public var endRightCurve: CGPoint { return CGPoint(x: rightX + parameters.circleRadius, y: 0) }
    
    // Control points
    public var control1Left: CGPoint { return CGPoint(x: factor >= 0.5 ? startLeftCurve.x + circleControl * factor : startLeftCurve.x + (1 - factor) * circleControl, y: startLeftCurve.y) }
    public var control2Left: CGPoint { return CGPoint(x: endLeftCurve.x, y: factor >= 0.5 ? endLeftCurve.y - (factor - 0.5) * circleControl: endLeftCurve.y ) }
    
    public var control1MiddleLeft: CGPoint { return CGPoint(x: factor >= 0.5 ? startMiddleLeftCurve.x + circleControl * (1 - factor) : startMiddleLeftCurve.x + circleControl * 0.5, y: startMiddleLeftCurve.y + circleControl * factor) }
    public var control2MiddleLeft: CGPoint { return CGPoint(x: middleCircle.x - circleControl, y: middleCircle.y) }
    
    // not considered yet
    public var control1Middle: CGPoint { return CGPoint(x: endLeftCurve.x + circleControlScaled, y: endLeftCurve.y + circleControl * factor) }
    public var control2Middle: CGPoint { return CGPoint(x: startRightCurve.x - circleControlScaled, y: startRightCurve.y + circleControl * factor) }
    
    // later
    public var control1MiddleRight: CGPoint { return CGPoint(x: middleCircle.x + circleControl, y: middleCircle.y) }
    public var control2MiddleRight: CGPoint { return CGPoint(x: factor >= 0.5 ? endMiddleRightCurve.x - circleControl * (1 - factor) : endMiddleRightCurve.x - circleControl * 0.5, y: endMiddleRightCurve.y + circleControl * factor) }
    
    public var control1Right: CGPoint { return  CGPoint(x: startRightCurve.x, y:  factor >= 0.5 ? startRightCurve.y - (factor - 0.5) * circleControl : startRightCurve.y) }
    public var control2Right: CGPoint { return  CGPoint(x: factor >= 0.5 ? endRightCurve.x - circleControl * factor : endRightCurve.x - (1 - factor) * circleControl, y: endRightCurve.y) }
    
}