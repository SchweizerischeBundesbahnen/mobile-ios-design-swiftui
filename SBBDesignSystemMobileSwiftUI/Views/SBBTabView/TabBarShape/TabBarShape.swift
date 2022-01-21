//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

/**
 A Shape that is used to create the tab bar.
 */
struct TabBarShape: Shape {
    private var currentTab: Int
    private var destTab: Int
    
    private var tabBarCoordinatesParameters: TabBarParameters
    
    private var transitionFactor: CGFloat
    private var transitionFactorPressed: CGFloat
    private var isPressed: Bool
    private var isPortrait: Bool
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(self.transitionFactor, self.transitionFactorPressed) }
            set {
                self.transitionFactor = newValue.first
                self.transitionFactorPressed = newValue.second
            }
        }
    
    public init(destTab: Int, currentTab: Int, tabBarCoordinatesParameters: TabBarParameters, transitionFactor: CGFloat, transitionFactorPressed: CGFloat, isPressed: Bool, isPortrait: Bool) {
        self.destTab = destTab
        self.currentTab = currentTab
        
        self.tabBarCoordinatesParameters = tabBarCoordinatesParameters
        
        self.transitionFactor = transitionFactor
        self.transitionFactorPressed = transitionFactorPressed
        self.isPressed = isPressed
        self.isPortrait = isPortrait
    }
    
    // the selected tab shape
    private func drawCircle(path: Path, coordinates: TabBarCoordinates) -> Path {
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
    private func drawTransition(path: Path, coordinates: TabBarCoordinates) -> Path {
        var newPath = path
        newPath.addLine(to: coordinates.startLeftCurve)
        newPath.addQuadCurve(to: coordinates.endLeftCurve, control: coordinates.control1Left)
        newPath.addCurve(to: coordinates.endMiddleRightCurve, control1: coordinates.control1Middle, control2: coordinates.control2Middle)
        newPath.addQuadCurve(to: coordinates.endRightCurve, control: coordinates.control2Right)
        return newPath
    }
    
    // TODO: the transition shape: to improve
    func drawNeighbours(path: Path, coordinatesLeft: TabBarCoordinates, coordinatesRight: TabBarCoordinates) -> Path {
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
    private func drawPressed(path: Path, coordinates: TabBarCoordinates, coordinatesPressed: TabBarCoordinates, pressedLeft: Bool) -> Path {
        var newPath = path
                
        if pressedLeft {
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
        let bottomLeftCorner = CGPoint(x: rect.minX - self.tabBarCoordinatesParameters.barWidth * 0.5, y: rect.maxY)
        let topLeftCorner = CGPoint(x: rect.minX - self.tabBarCoordinatesParameters.barWidth * 0.5, y: rect.minY)
        let topRightCorner = CGPoint(x: rect.maxX + self.tabBarCoordinatesParameters.barWidth * 0.5, y: rect.minY)
        let bottomRightCorner = CGPoint(x: rect.maxX + self.tabBarCoordinatesParameters.barWidth * 0.5, y: rect.maxY)
        
        path.move(to: bottomLeftCorner)
        path.addLine(to: topLeftCorner)
        
        // No current tab, current is the same as dest or transition is complete: only draw the destination tab
         if currentTab == -1 || destTab == currentTab || (transitionFactor == 1 && !isPressed) {
             let destCoordinates = TabBarCoordinates(tab: self.destTab, factor: 1.0, isPortrait: self.isPortrait, parameters: self.tabBarCoordinatesParameters)
            path = drawCircle(path: path, coordinates: destCoordinates)
        
        // Transition has not started and current tab exists: only draw current tab
        } else if currentTab != -1 && transitionFactor == 0 {
            let currentCoordinates = TabBarCoordinates(tab: currentTab, factor: (1.0 - transitionFactor), isPortrait: self.isPortrait, parameters: self.tabBarCoordinatesParameters)
            path = drawCircle(path: path, coordinates: currentCoordinates)
            
        } else {
            let destCoordinates = isPressed ? TabBarCoordinates(tab: destTab, factor: 1.0, isPortrait: self.isPortrait, parameters: self.tabBarCoordinatesParameters) : TabBarCoordinates(tab: destTab, factor: transitionFactor, isPortrait: self.isPortrait, parameters: self.tabBarCoordinatesParameters)
            let currentCoordinates = isPressed ? TabBarCoordinates(tab: currentTab, factor: 0.25 * transitionFactorPressed, isPortrait: self.isPortrait, parameters: self.tabBarCoordinatesParameters) : TabBarCoordinates(tab: currentTab, factor: (1.0 - transitionFactor), isPortrait: self.isPortrait, parameters: self.tabBarCoordinatesParameters)
            
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
