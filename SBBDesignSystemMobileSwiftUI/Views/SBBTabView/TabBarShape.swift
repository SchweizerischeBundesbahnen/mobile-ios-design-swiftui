//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI
import Foundation


/**
 A Shape that is used to create the tab bar.
 */
struct TabCircleCoordinatesParameters {
    public var circleRadius: CGFloat
    public var segmentWidth: CGFloat
    public var circlePad: CGFloat
    public var heightDiff: CGFloat
    
    public init(circleRadius: CGFloat, segmentWidth: CGFloat, circlePad: CGFloat, heightDiff: CGFloat) {
        self.circleRadius = circleRadius
        self.segmentWidth = segmentWidth
        self.circlePad = circlePad
        self.heightDiff = heightDiff
    }
}
struct TabCircleCoordinates {
    private let tab: Int
    public let factor: CGFloat
    private let parameters: TabCircleCoordinatesParameters
    
    private var tabOffset: CGFloat { return parameters.segmentWidth * CGFloat(tab) }
    private var nextTabOffset: CGFloat { return parameters.segmentWidth * CGFloat(tab + 1)}
    private var circleOffset: CGFloat { return (parameters.segmentWidth - 2 * (parameters.circleRadius + parameters.circlePad)) / 2}
    
    private var leftX: CGFloat { return tabOffset + circleOffset}
    private var middleX: CGFloat { return leftX + parameters.circlePad + parameters.circleRadius }
    private var rightX: CGFloat { return nextTabOffset - circleOffset}
    private var middle1Y: CGFloat { return (parameters.circleRadius + parameters.circlePad) }
    private var middle2Y: CGFloat { return (parameters.circleRadius + parameters.circlePad + parameters.heightDiff)}
    private var bottomY: CGFloat { return (2 * middle1Y + parameters.heightDiff) }
    
    // length of control vector if we want to approximate a quarter circle
    private var circleControl: CGFloat { return sqrt(4 * tan(.pi / 8) / 3) * parameters.circleRadius }
    public var circleControlScaled: CGFloat { return circleControl * (1 - factor) }
    
    // Points
    public var middleHeight: CGFloat { return bottomY / 2 }
    
    public var startLeftCurve: CGPoint { return CGPoint(x: leftX - parameters.circleRadius, y: 0) }
    public var endLeftCurve: CGPoint { return CGPoint(x: leftX, y: middle1Y * factor) }
    
    public var startMiddleLeftCurve: CGPoint { return CGPoint(x: leftX, y: (middle2Y + parameters.heightDiff) * factor) }
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
    
    
    public init(tab: Int, factor: CGFloat, parameters: TabCircleCoordinatesParameters) {
        self.tab = tab
        self.factor = factor
        self.parameters = parameters
    }
}

struct TabBarShape: Shape {
    private var currentTab: Int
    private var destTab: Int
    private var nbTabs: Int
    private var circleSize: CGFloat
    private var segmentWidth: CGFloat
    private var circlePad: CGFloat
    private var heightDiff: CGFloat
    private var transitionFactor: CGFloat
    private var transitionFactorPressed: CGFloat
    private var isPressed: Bool
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(self.transitionFactor, self.transitionFactorPressed) }
            set {
                self.transitionFactor = newValue.first
                self.transitionFactorPressed = newValue.second
            }
        }
    
    public init(destTab: Int, currentTab: Int = -1, nbTabs: Int, circleSize: CGFloat, segmentWidth: CGFloat, circlePad: CGFloat, heightDiff: CGFloat, transitionFactor: CGFloat = 0.0, transitionFactorPressed: CGFloat = 0.0, isPressed: Bool = false) {
        self.destTab = destTab
        self.currentTab = currentTab
        self.nbTabs = nbTabs
        self.circleSize = circleSize
        self.segmentWidth = segmentWidth
        self.circlePad = circlePad
        self.heightDiff = heightDiff
        self.transitionFactor = transitionFactor
        self.transitionFactorPressed = transitionFactorPressed
        self.isPressed = isPressed
    }
    
    // the selected tab shape
    private func drawCircle(path: Path, coordinates: TabCircleCoordinates) -> Path {
        var newPath = path
        newPath.addLine(to: coordinates.startLeftCurve)
        newPath.addCurve(to: coordinates.endLeftCurve, control1: coordinates.control1Left, control2: coordinates.control2Left)
        newPath.addLine(to: coordinates.startMiddleLeftCurve)
        newPath.addCurve(to: coordinates.middleCircle, control1: coordinates.control1MiddleLeft, control2: coordinates.control2MiddleLeft)
        newPath.addCurve(to: coordinates.endMiddleRightCurve, control1: coordinates.control1MiddleRight, control2: coordinates.control2MiddleRight)
        newPath.addLine(to: coordinates.startRightCurve)
        newPath.addCurve(to: coordinates.endRightCurve, control1: coordinates.control1Right, control2: coordinates.control2Right)
        return newPath
    }
    
    // TODO: the transition shape: to improve
    private func drawTransition(path: Path, coordinates: TabCircleCoordinates) -> Path {
        var newPath = path
        newPath.addLine(to: coordinates.startLeftCurve)
        newPath.addQuadCurve(to: coordinates.endLeftCurve, control: coordinates.control1Left)
        newPath.addCurve(to: coordinates.endMiddleRightCurve, control1: coordinates.control1Middle, control2: coordinates.control2Middle)
        newPath.addQuadCurve(to: coordinates.endRightCurve, control: coordinates.control2Right)
        return newPath
    }
    
    // TODO: the transition shape: to improve
    func drawNeighbours(path: Path, coordinatesLeft: TabCircleCoordinates, coordinatesRight: TabCircleCoordinates) -> Path {
        var newPath = path
        
        let controlRight1: CGPoint = CGPoint(x: coordinatesLeft.endLeftCurve.x + coordinatesLeft.circleControlScaled, y: coordinatesLeft.middleCircle.y)
        let middlePoint: CGPoint = coordinatesRight.factor <= 0.5 ? CGPoint(x: coordinatesLeft.endMiddleRightCurve.x, y: coordinatesLeft.middleHeight) : CGPoint(x: coordinatesRight.endLeftCurve.x, y: coordinatesRight.middleHeight)
        
        let controlLeft1: CGPoint = coordinatesRight.factor <= 0.5 ? CGPoint(x: middlePoint.x - coordinatesLeft.circleControlScaled, y: coordinatesLeft.middleCircle.y) : CGPoint(x: middlePoint.x - coordinatesLeft.circleControlScaled + (coordinatesRight.factor * 10), y: coordinatesLeft.middleCircle.y)
        let controlRight2: CGPoint = coordinatesRight.factor <= 0.5 ? CGPoint(x: middlePoint.x + coordinatesRight.circleControlScaled - (coordinatesLeft.factor * 10), y: coordinatesRight.middleCircle.y):  CGPoint(x: middlePoint.x + coordinatesRight.circleControlScaled, y: coordinatesRight.middleCircle.y)
        
        let controlLeft2: CGPoint = CGPoint(x: coordinatesRight.endMiddleRightCurve.x - coordinatesRight.circleControlScaled, y: coordinatesRight.middleCircle.y)
        
        
        newPath.addLine(to: coordinatesLeft.startLeftCurve)
        newPath.addQuadCurve(to: coordinatesLeft.endLeftCurve, control: coordinatesLeft.control1Left)
        newPath.addQuadCurve(to: coordinatesLeft.middleCircle, control: controlRight1)
        
        newPath.addQuadCurve(to: middlePoint, control: controlLeft1)
        newPath.addQuadCurve(to: coordinatesRight.middleCircle, control: controlRight2)
        
        newPath.addQuadCurve(to: coordinatesRight.endMiddleRightCurve, control: controlLeft2)
        newPath.addQuadCurve(to: coordinatesRight.endRightCurve, control: coordinatesRight.control2Right)
        
        return newPath
    }
    
    // TODO: the pressed tab shape: to improve
    private func drawPressed(path: Path, coordinates: TabCircleCoordinates, coordinatesPressed: TabCircleCoordinates, pressedLeft: Bool) -> Path {
        var newPath = path
                
        if pressedLeft {
            //  At the bottom
            let middlePoint: CGPoint = CGPoint(x: coordinates.endMiddleRightCurve.x, y: coordinates.middleHeight)
            let controlRight1: CGPoint = CGPoint(x: coordinates.endLeftCurve.x + coordinates.circleControlScaled, y: coordinates.middleCircle.y)
            let controlLeft1: CGPoint = CGPoint(x: middlePoint.x - coordinates.circleControlScaled, y: coordinates.middleCircle.y)
            let controlBump1: CGPoint = CGPoint(x: coordinates.endMiddleRightCurve.x, y: coordinatesPressed.middleCircle.y)
            let controlBump2: CGPoint = CGPoint(x: coordinates.endMiddleRightCurve.x + coordinatesPressed.circleControlScaled, y: 0)
            let controlDown1: CGPoint = CGPoint(x: coordinatesPressed.endMiddleRightCurve.x - coordinatesPressed.circleControlScaled, y: coordinatesPressed.middleCircle.y + 2)
            
            newPath.addLine(to: coordinates.startLeftCurve)
            newPath.addQuadCurve(to: coordinates.endLeftCurve, control: coordinates.control1Left)
            newPath.addQuadCurve(to: coordinates.middleCircle, control: controlRight1)
            newPath.addQuadCurve(to: middlePoint, control: controlLeft1)
            newPath.addCurve(to: coordinatesPressed.middleCircle, control1: controlBump1, control2: controlBump2)
            newPath.addQuadCurve(to: coordinatesPressed.endMiddleRightCurve, control: controlDown1)
            newPath.addQuadCurve(to: coordinatesPressed.endRightCurve, control: coordinatesPressed.control2Right)
            
        } else {
            let controlBump1: CGPoint = CGPoint(x: coordinates.endLeftCurve.x - coordinates.circleControlScaled, y: 0)
            let controlBump2: CGPoint = CGPoint(x: coordinates.endLeftCurve.x, y: coordinatesPressed.middleCircle.y)
            let controlDown1: CGPoint = CGPoint(x: coordinatesPressed.endLeftCurve.x + coordinatesPressed.circleControlScaled, y: coordinatesPressed.middleCircle.y + 2)
            
            let middlePoint: CGPoint = CGPoint(x: coordinates.endLeftCurve.x, y: coordinates.middleHeight)
            let controlRight1: CGPoint = CGPoint(x: middlePoint.x - coordinates.circleControlScaled, y: coordinates.middleCircle.y)
            let controlLeft1: CGPoint = CGPoint(x: coordinates.endMiddleRightCurve.x + coordinates.circleControlScaled, y: coordinates.middleCircle.y)
            
            newPath.addLine(to: coordinatesPressed.startLeftCurve)
            newPath.addQuadCurve(to: coordinatesPressed.endLeftCurve, control: coordinatesPressed.control1Left)
            newPath.addQuadCurve(to: coordinatesPressed.middleCircle, control: controlDown1)
            newPath.addCurve(to: middlePoint, control1: controlBump1, control2: controlBump2)
            
            newPath.addQuadCurve(to: coordinates.middleCircle, control: controlRight1)
            newPath.addQuadCurve(to: coordinates.endMiddleRightCurve, control: controlLeft1)
            newPath.addQuadCurve(to: coordinates.endRightCurve, control: coordinates.control2Right)
        }
        return newPath
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let bottomLeftCorner = CGPoint(x: rect.minX, y: rect.maxY)
        let topLeftCorner = CGPoint(x: rect.minX, y: rect.minY)
        let topRightCorner = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRightCorner = CGPoint(x: rect.maxX, y: rect.maxY)
        let tabParameters = TabCircleCoordinatesParameters(circleRadius: self.circleSize / 2, segmentWidth: self.segmentWidth, circlePad: self.circlePad, heightDiff: self.heightDiff)
        
        path.move(to: bottomLeftCorner)
        path.addLine(to: topLeftCorner)
        
        // No current tab, current is the same as dest or transition is complete: only draw the destination tab
         if currentTab == -1 || destTab == currentTab || (transitionFactor == 1 && !isPressed) {
            let destCoordinates = TabCircleCoordinates(tab: self.destTab, factor: 1.0, parameters: tabParameters)
            path = drawCircle(path: path, coordinates: destCoordinates)
        
        // Transition has not started and current tab exists: only draw current tab
        } else if currentTab != -1 && transitionFactor == 0 {
            let currentCoordinates = TabCircleCoordinates(tab: currentTab, factor: (1.0 - transitionFactor), parameters: tabParameters)
            path = drawCircle(path: path, coordinates: currentCoordinates)
            
        } else {
            let destCoordinates = isPressed ? TabCircleCoordinates(tab: destTab, factor: 1.0, parameters: tabParameters) : TabCircleCoordinates(tab: destTab, factor: transitionFactor, parameters: tabParameters)
            let currentCoordinates = isPressed ? TabCircleCoordinates(tab: currentTab, factor: 0.25 * transitionFactorPressed, parameters: tabParameters) : TabCircleCoordinates(tab: currentTab, factor: (1.0 - transitionFactor), parameters: tabParameters)
            
            if destTab > currentTab {
                if currentCoordinates.endRightCurve.x > destCoordinates.startLeftCurve.x {
                    if isPressed {
                        path = drawPressed(path: path, coordinates: destCoordinates, coordinatesPressed: currentCoordinates, pressedLeft: false)
                    } else {
                    
                        path = drawNeighbours(path: path, coordinatesLeft: currentCoordinates, coordinatesRight: destCoordinates)
                    }
                } else {
                    path = drawTransition(path: path, coordinates: currentCoordinates)
                    path = drawTransition(path: path, coordinates: destCoordinates)
                }
            } else {
                if currentCoordinates.startLeftCurve.x < destCoordinates.endRightCurve.x {
                    if isPressed {
                        path = drawPressed(path: path, coordinates: destCoordinates, coordinatesPressed: currentCoordinates, pressedLeft: true)
                    } else {
                        path = drawNeighbours(path: path, coordinatesLeft: destCoordinates, coordinatesRight: currentCoordinates)
                    }
                } else {
                    path = drawTransition(path: path, coordinates: destCoordinates)
                    path = drawTransition(path: path, coordinates: currentCoordinates)
                }
            }
        }
        
        path.addLine(to: topRightCorner)
        path.addLine(to: bottomRightCorner)
        return path
    }
}
