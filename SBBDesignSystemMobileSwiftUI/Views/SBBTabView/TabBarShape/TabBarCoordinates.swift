//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI
import Foundation


/**
 Parameters used to create the coordinates
 */
struct TabBarCoordinatesParameters {
    public var nbTabs: Int
    public var circleRadius: CGFloat
    public var segmentWidth: CGFloat
    public var segmentWidths: [CGSize]
    public var circlePad: CGFloat
    public var heightDiff: CGFloat
    public var width: CGFloat
    
    public init(nbTabs: Int, circleRadius: CGFloat, segmentWidth: CGFloat, segmentWidths: [CGSize], circlePad: CGFloat, heightDiff: CGFloat, width: CGFloat) {
        self.nbTabs = nbTabs
        self.circleRadius = circleRadius
        self.segmentWidth = segmentWidth
        self.segmentWidths = segmentWidths
        self.circlePad = circlePad
        self.heightDiff = heightDiff
        self.width = width
    }
}

/**
 Coordinates used to create the tab bar
 */
struct TabBarCoordinates {
    private let tab: Int
    public let factor: CGFloat
    private let parameters: TabBarCoordinatesParameters
    
    private var tabOffset: CGFloat {
        let offsetX = parameters.segmentWidth * CGFloat(tab)
        let padding = parameters.segmentWidth / 2 - parameters.circleRadius - parameters.circlePad
        if parameters.segmentWidths[0] != .zero {
            return offsetX + padding - parameters.segmentWidths[tab].width / 2
        } else {
            return offsetX + padding
        }
    }
    
    private var leftX: CGFloat { return tabOffset}
    private var middleX: CGFloat { return leftX + parameters.circlePad + parameters.circleRadius }
    private var rightX: CGFloat { return tabOffset + 2 * (parameters.circleRadius + parameters.circlePad)}
    private var bottomY: CGFloat { return (2 * parameters.circleRadius + parameters.circlePad + parameters.heightDiff) }
    private var middle2Y: CGFloat { return (bottomY - parameters.circlePad - parameters.circleRadius)}
    private var middle1Y: CGFloat { return (bottomY - middle2Y) }
    
    // length of control vector if we want to approximate a quarter circle
    private var circleControl: CGFloat { return parameters.heightDiff == 0 ? sqrt(4 * tan(.pi / 8) / 3) * parameters.circleRadius * 0.9 : sqrt(4 * tan(.pi / 8) / 3) * parameters.circleRadius }
    public var circleControlScaled: CGFloat { return circleControl * (1 - factor) }
    
    // Points
    public var middleHeight: CGFloat { return bottomY / 2 }
    
    public var startLeftCurve: CGPoint { return CGPoint(x: leftX - parameters.circleRadius, y: 0) }
    public var endLeftCurve: CGPoint { return CGPoint(x: leftX, y: middle1Y * factor) }
    
    public var startMiddleLeftCurve: CGPoint { return CGPoint(x: leftX, y: middle2Y * factor) }
    public var middleCircle: CGPoint { return CGPoint(x: middleX, y: bottomY * factor) }
    public var endMiddleRightCurve: CGPoint { return CGPoint(x: rightX, y: middle2Y * factor) }
    public var startRightCurve: CGPoint { return CGPoint(x: rightX, y: (middle2Y + parameters.heightDiff) * factor) }
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
    
    
    public init(tab: Int, factor: CGFloat, parameters: TabBarCoordinatesParameters) {
        self.tab = tab
        self.factor = factor
        self.parameters = parameters
    }
}
