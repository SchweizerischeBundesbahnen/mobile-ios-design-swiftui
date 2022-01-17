//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI
import Foundation


/**
 A Shape that is used to create the tab bar.
 */
struct TabCircleCoordinates {
    private let tab: Int
    public let factor: CGFloat
    private var circleSize: CGFloat
    private var circleWidth: CGFloat
    
    private var offset: CGFloat { return circleWidth * CGFloat(tab) }
    private var circleOffset: CGFloat { return (circleWidth - circleSize * 1.2) / 2 }
    
    public var halfCircle: CGFloat { return circleSize / 2 }
    
    private var offsetLeft: CGFloat { return offset + circleOffset }
    private var offsetRight: CGFloat { return offset - circleOffset }
    public var controlFactor: CGFloat { return circleSize * 0.2 * (1 - factor) }
    
    public var middleCircle: CGPoint { return CGPoint(x: (offsetLeft + offsetRight + circleWidth) / 2, y: circleSize * 1.2 * factor) }
    public var middleHeight: CGFloat { return circleSize * 1.2 * 0.5 }
    
    public var startLeftCurve: CGPoint { return CGPoint(x: offsetLeft - halfCircle, y: 0) }
    public var endLeftCurve: CGPoint { return CGPoint(x: offsetLeft, y: halfCircle * factor) }
    public var endMiddleCurve: CGPoint { return CGPoint(x: offsetRight + circleWidth, y: halfCircle * factor) }
    public var endRightCurve: CGPoint { return CGPoint(x: offsetRight + halfCircle + circleWidth, y: 0) }
    
    public var controlLeft: CGPoint { return CGPoint(x: offsetLeft - controlFactor, y: 0) }
    public var control1Middle: CGPoint { return CGPoint(x: offsetLeft + controlFactor, y: circleSize * 1.4 * factor) }
    public var control2Middle: CGPoint { return CGPoint(x: offsetRight + circleWidth - controlFactor, y: circleSize * 1.4 * factor) }
    public var controlRight: CGPoint { return CGPoint(x: offsetRight + circleWidth + controlFactor, y: 0) }
    
    
    public init(tab: Int, factor: CGFloat, circleSize: CGFloat, circleWidth: CGFloat) {
        self.tab = tab
        self.factor = factor
        self.circleSize = circleSize
        self.circleWidth = circleWidth
    }
}

struct TabBarShape: Shape {
    private var currentTab: Int
    private var nbTabs: Int
    private var circleSize: CGFloat
    private var segmentWidth: CGFloat
    private var destTab: Int
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
    
    public init(destTab: Int, nbTabs: Int, circleSize: CGFloat, segmentWidth: CGFloat, currentTab: Int = -1, transitionFactor: CGFloat = 0.0, transitionFactorPressed: CGFloat = 0.0, isPressed: Bool = false) {
        self.destTab = destTab
        self.nbTabs = nbTabs
        self.circleSize = circleSize
        self.segmentWidth = segmentWidth
        self.currentTab = currentTab
        self.transitionFactor = transitionFactor
        self.transitionFactorPressed = transitionFactorPressed
        self.isPressed = isPressed
    }
    
    private func drawCircle(path: Path, coordinates: TabCircleCoordinates) -> Path {
        var newPath = path
        newPath.addLine(to: coordinates.startLeftCurve)
        newPath.addQuadCurve(to: coordinates.endLeftCurve, control: coordinates.controlLeft)
        newPath.addCurve(to: coordinates.endMiddleCurve, control1: coordinates.control1Middle, control2: coordinates.control2Middle)
        newPath.addQuadCurve(to: coordinates.endRightCurve, control: coordinates.controlRight)
        return newPath
    }
    
    func drawNeighbours(path: Path, coordinatesLeft: TabCircleCoordinates, coordinatesRight: TabCircleCoordinates) -> Path {
        var newPath = path
        
        let controlRight1: CGPoint = CGPoint(x: coordinatesLeft.endLeftCurve.x + coordinatesLeft.controlFactor, y: coordinatesLeft.middleCircle.y)
        let middlePoint: CGPoint = coordinatesRight.factor <= 0.5 ? CGPoint(x: coordinatesLeft.endMiddleCurve.x, y: coordinatesLeft.middleHeight) : CGPoint(x: coordinatesRight.endLeftCurve.x, y: coordinatesRight.middleHeight)
        let controlLeft1: CGPoint = coordinatesRight.factor <= 0.5 ? CGPoint(x: middlePoint.x - coordinatesLeft.controlFactor, y: coordinatesLeft.middleCircle.y) : CGPoint(x: middlePoint.x - coordinatesLeft.controlFactor + (coordinatesRight.factor * 10), y: coordinatesLeft.middleCircle.y)
        let controlRight2: CGPoint = coordinatesRight.factor <= 0.5 ? CGPoint(x: middlePoint.x + coordinatesRight.controlFactor - (coordinatesLeft.factor * 10), y: coordinatesRight.middleCircle.y):  CGPoint(x: middlePoint.x + coordinatesRight.controlFactor, y: coordinatesRight.middleCircle.y)
        
        let controlLeft2: CGPoint = CGPoint(x: coordinatesRight.endMiddleCurve.x - coordinatesRight.controlFactor, y: coordinatesRight.middleCircle.y)
        
        
        newPath.addLine(to: coordinatesLeft.startLeftCurve)
        newPath.addQuadCurve(to: coordinatesLeft.endLeftCurve, control: coordinatesLeft.controlLeft)
        newPath.addQuadCurve(to: coordinatesLeft.middleCircle, control: controlRight1)
        
        // these two
        newPath.addQuadCurve(to: middlePoint, control: controlLeft1)
        newPath.addQuadCurve(to: coordinatesRight.middleCircle, control: controlRight2)
        
        
        newPath.addQuadCurve(to: coordinatesRight.endMiddleCurve, control: controlLeft2)
        newPath.addQuadCurve(to: coordinatesRight.endRightCurve, control: coordinatesRight.controlRight)
        
        return newPath
    }
    
    private func drawPressed(path: Path, coordinates: TabCircleCoordinates, coordinatesPressed: TabCircleCoordinates, pressedLeft: Bool) -> Path {
        var newPath = path
                
        if pressedLeft {
            //  At the bottom
            let middlePoint: CGPoint = CGPoint(x: coordinates.endMiddleCurve.x, y: coordinates.middleHeight)
            let controlRight1: CGPoint = CGPoint(x: coordinates.endLeftCurve.x + coordinates.controlFactor, y: coordinates.middleCircle.y)
            let controlLeft1: CGPoint = CGPoint(x: middlePoint.x - coordinates.controlFactor, y: coordinates.middleCircle.y)
            let controlBump1: CGPoint = CGPoint(x: coordinates.endMiddleCurve.x, y: coordinatesPressed.middleCircle.y)
            let controlBump2: CGPoint = CGPoint(x: coordinates.endMiddleCurve.x + coordinatesPressed.controlFactor, y: 0)
            let controlDown1: CGPoint = CGPoint(x: coordinatesPressed.endMiddleCurve.x - coordinatesPressed.controlFactor, y: coordinatesPressed.middleCircle.y + 2)
            
            newPath.addLine(to: coordinates.startLeftCurve)
            newPath.addQuadCurve(to: coordinates.endLeftCurve, control: coordinates.controlLeft)
            newPath.addQuadCurve(to: coordinates.middleCircle, control: controlRight1)
            newPath.addQuadCurve(to: middlePoint, control: controlLeft1)
            newPath.addCurve(to: coordinatesPressed.middleCircle, control1: controlBump1, control2: controlBump2)
            newPath.addQuadCurve(to: coordinatesPressed.endMiddleCurve, control: controlDown1)
            newPath.addQuadCurve(to: coordinatesPressed.endRightCurve, control: coordinatesPressed.controlRight)
            
        } else {
            // At the top
            let controlBump1: CGPoint = CGPoint(x: coordinates.endLeftCurve.x - coordinates.controlFactor, y: 0)
            let controlBump2: CGPoint = CGPoint(x: coordinates.endLeftCurve.x, y: coordinatesPressed.middleCircle.y)
            let controlDown1: CGPoint = CGPoint(x: coordinatesPressed.endLeftCurve.x + coordinatesPressed.controlFactor, y: coordinatesPressed.middleCircle.y + 2)
            
            let middlePoint: CGPoint = CGPoint(x: coordinates.endLeftCurve.x, y: coordinates.middleHeight)
            let controlRight1: CGPoint = CGPoint(x: middlePoint.x - coordinates.controlFactor, y: coordinates.middleCircle.y)
            let controlLeft1: CGPoint = CGPoint(x: coordinates.endMiddleCurve.x + coordinates.controlFactor, y: coordinates.middleCircle.y)
            
            newPath.addLine(to: coordinatesPressed.startLeftCurve)
            newPath.addQuadCurve(to: coordinatesPressed.endLeftCurve, control: coordinatesPressed.controlLeft)
            newPath.addQuadCurve(to: coordinatesPressed.middleCircle, control: controlDown1)
            newPath.addCurve(to: middlePoint, control1: controlBump1, control2: controlBump2)
            
            newPath.addQuadCurve(to: coordinates.middleCircle, control: controlRight1)
            newPath.addQuadCurve(to: coordinates.endMiddleCurve, control: controlLeft1)
            newPath.addQuadCurve(to: coordinates.endRightCurve, control: coordinates.controlRight)
        }

        return newPath
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let bottomLeftCorner = CGPoint(x: rect.minX, y: rect.maxY)
        let topLeftCorner = CGPoint(x: rect.minX, y: rect.minY)
        let topRightCorner = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRightCorner = CGPoint(x: rect.maxX, y: rect.maxY)
        
        // Start bottom left corner
        path.move(to: bottomLeftCorner)
        // Draw lines to start of the left curve
        path.addLine(to: topLeftCorner)
        
        // No current tab, current is the same as dest or transition is complete: only draw the destination tab
        if currentTab == -1 || destTab == currentTab || (transitionFactor == 1 && !isPressed) {
            let destCoordinates = TabCircleCoordinates(tab: destTab, factor: 1.0, circleSize: circleSize, circleWidth: segmentWidth)
            
            path = drawCircle(path: path, coordinates: destCoordinates)
            // Transition has not started and current tab exists: only draw current tab
        } else if currentTab != -1 && transitionFactor == 0 {
            let currentCoordinates = TabCircleCoordinates(tab: currentTab, factor: (1.0 - transitionFactor), circleSize: circleSize, circleWidth: segmentWidth)
            path = drawCircle(path: path, coordinates: currentCoordinates)
            // Else draw the two tabs
        } else {
            let destCoordinates = isPressed ? TabCircleCoordinates(tab: destTab, factor: 1.0, circleSize: circleSize, circleWidth: segmentWidth) : TabCircleCoordinates(tab: destTab, factor: transitionFactor, circleSize: circleSize, circleWidth: segmentWidth)
            let currentCoordinates = isPressed ? TabCircleCoordinates(tab: currentTab, factor: 0.25 * transitionFactorPressed, circleSize: circleSize, circleWidth: segmentWidth) : TabCircleCoordinates(tab: currentTab, factor: (1.0 - transitionFactor), circleSize: circleSize, circleWidth: segmentWidth)
            
            
            if destTab > currentTab {
                if currentCoordinates.endRightCurve.x > destCoordinates.startLeftCurve.x {
                    if isPressed {
                        path = drawPressed(path: path, coordinates: destCoordinates, coordinatesPressed: currentCoordinates, pressedLeft: false)
                    } else {
                    
                        path = drawNeighbours(path: path, coordinatesLeft: currentCoordinates, coordinatesRight: destCoordinates)
                    }
                } else {
                    path = drawCircle(path: path, coordinates: currentCoordinates)
                    path = drawCircle(path: path, coordinates: destCoordinates)
                }
            } else {
                if currentCoordinates.startLeftCurve.x < destCoordinates.endRightCurve.x {
                    if isPressed {
                        path = drawPressed(path: path, coordinates: destCoordinates, coordinatesPressed: currentCoordinates, pressedLeft: true)
                    } else {
                        path = drawNeighbours(path: path, coordinatesLeft: destCoordinates, coordinatesRight: currentCoordinates)
                    }
                } else {
                    path = drawCircle(path: path, coordinates: destCoordinates)
                    path = drawCircle(path: path, coordinates: currentCoordinates)
                }
            }
        }
        
        // Add lines to complete path
        path.addLine(to: topRightCorner)
        path.addLine(to: bottomRightCorner)
        return path
    }
}
