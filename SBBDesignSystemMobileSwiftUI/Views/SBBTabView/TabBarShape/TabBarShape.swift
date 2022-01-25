//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

/**
 A Shape that is used to create the tab bar for ``SBBTabView``.
 */
struct TabBarShape: Shape {
    private var currentTab: Int
    private var destTab: Int
    
    private var tabBarParameters: TabBarParameters
    
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
        // destination tab is the tab displayed, as we set transitionFactor = 1.
        // during a transition, the transitionFator becomes 0, the new tab becomes the destination tab and the destination tab becomes the current one, the transition is obtained by increasing transitionFactor.
        // when pressed, the pressed tab becomes the current tab and a transition is obtained with transitionFactorPressed.
        self.destTab = destTab
        self.currentTab = currentTab

        self.tabBarParameters = tabBarCoordinatesParameters
        
        self.transitionFactor = transitionFactor
        self.transitionFactorPressed = transitionFactorPressed
        self.isPressed = isPressed
        self.isPortrait = isPortrait
    }
    
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
    
    private func drawPressed(path: Path, coordinates: TabBarCoordinates, coordinatesPressed: TabBarCoordinates, pressedLeft: Bool) -> Path {
        var newPath = path
                
        if pressedLeft {
            let middlePoint: CGPoint = CGPoint(x: coordinates.endMiddleRightCurve.x, y: coordinates.middleHeight)
            let controlBump1: CGPoint = CGPoint(x: coordinates.endMiddleRightCurve.x, y: coordinates.middleHeight - coordinatesPressed.circleControl)
            let controlBump2: CGPoint = CGPoint(x: coordinates.endMiddleRightCurve.x + coordinatesPressed.circleControl - 10, y: coordinatesPressed.startMiddleLeftCurve.y)
            
            newPath.addLine(to: coordinates.startLeftCurve)
            newPath.addCurve(to: coordinates.endLeftCurve, control1: coordinates.control1Left, control2: coordinates.control2Left)
            newPath.addLine(to: coordinates.startMiddleLeftCurve)
            newPath.addCurve(to: coordinates.middleCircle, control1: coordinates.control1MiddleLeft, control2: coordinates.control2MiddleLeft)
            newPath.addCurve(to: middlePoint, control1: coordinates.control1MiddleRight, control2: coordinates.control2MiddleRight)
            
            newPath.addCurve(to: coordinatesPressed.middleCircle, control1: controlBump1, control2: controlBump2)
            
            newPath.addCurve(to: coordinatesPressed.endMiddleRightCurve, control1: coordinatesPressed.control1MiddleRight, control2: coordinatesPressed.control2MiddleRight)
            newPath.addLine(to: coordinatesPressed.startRightCurve)
            newPath.addCurve(to: coordinatesPressed.endRightCurve, control1: coordinatesPressed.control1Right, control2: coordinatesPressed.control2Right)
            
        } else {
            let controlBump1: CGPoint = CGPoint(x: coordinatesPressed.endMiddleRightCurve.x + coordinatesPressed.circleControl - 10, y: coordinatesPressed.endMiddleRightCurve.y)
            let controlBump2: CGPoint = CGPoint(x: coordinates.endLeftCurve.x, y: coordinatesPressed.middleHeight - coordinatesPressed.circleControl)
            let middlePoint: CGPoint = CGPoint(x: coordinates.endLeftCurve.x, y: coordinates.middleHeight)
            
            newPath.addLine(to: coordinatesPressed.startLeftCurve)
            newPath.addCurve(to: coordinatesPressed.endLeftCurve, control1: coordinatesPressed.control1Left, control2: coordinatesPressed.control2Left)
            newPath.addLine(to: coordinatesPressed.startMiddleLeftCurve)
            newPath.addCurve(to: coordinatesPressed.middleCircle, control1: coordinatesPressed.control1MiddleLeft, control2: coordinatesPressed.control2MiddleLeft)
        
            newPath.addCurve(to: middlePoint, control1: controlBump1, control2: controlBump2)

            newPath.addCurve(to: coordinates.middleCircle, control1: coordinates.control1MiddleLeft, control2: coordinates.control2MiddleLeft)
            newPath.addCurve(to: coordinates.endMiddleRightCurve, control1: coordinates.control1MiddleRight, control2: coordinates.control2MiddleRight)
            newPath.addLine(to: coordinates.startRightCurve)
            newPath.addCurve(to: coordinates.endRightCurve, control1: coordinates.control1Right, control2: coordinates.control2Right)
        }
        return newPath
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let bottomLeftCorner = CGPoint(x: rect.minX - self.tabBarParameters.barWidth * 0.5, y: rect.maxY)
        let topLeftCorner = CGPoint(x: rect.minX - self.tabBarParameters.barWidth * 0.5, y: rect.minY)
        let topRightCorner = CGPoint(x: rect.maxX + self.tabBarParameters.barWidth * 0.5, y: rect.minY)
        let bottomRightCorner = CGPoint(x: rect.maxX + self.tabBarParameters.barWidth * 0.5, y: rect.maxY)
        
        path.move(to: bottomLeftCorner)
        path.addLine(to: topLeftCorner)
        
        // No current tab, current is the same as dest or transition is complete: only draw the destination tab
         if currentTab == -1 || destTab == currentTab || (transitionFactor == 1 && !isPressed) {
             let destCoordinates = TabBarCoordinates(tab: self.destTab, factor: 1.0, isPortrait: self.isPortrait, parameters: self.tabBarParameters, isPressed: false)
            path = drawCircle(path: path, coordinates: destCoordinates)
        
        // Transition has not started and current tab exists: only draw current tab
        } else if currentTab != -1 && transitionFactor == 0 {
            let currentCoordinates = TabBarCoordinates(tab: currentTab, factor: (1.0 - transitionFactor), isPortrait: self.isPortrait, parameters: self.tabBarParameters, isPressed: false)
            path = drawCircle(path: path, coordinates: currentCoordinates)
            
        } else {
            let destCoordinates = isPressed ? TabBarCoordinates(tab: destTab, factor: 1.0, isPortrait: self.isPortrait, parameters: self.tabBarParameters, isPressed: true) : TabBarCoordinates(tab: destTab, factor: transitionFactor, isPortrait: self.isPortrait, parameters: self.tabBarParameters, isPressed: false)
            let currentCoordinates = isPressed ? TabBarCoordinates(tab: currentTab, factor: 0.25 * transitionFactorPressed, isPortrait: self.isPortrait, parameters: self.tabBarParameters, isPressed: true) : TabBarCoordinates(tab: currentTab, factor: (1.0 - transitionFactor), isPortrait: self.isPortrait, parameters: self.tabBarParameters, isPressed: false)
            
            // Current tab is on the left of destination tab
            if destTab > currentTab {
                // If the tab are close to each other (no place to draw full 'circle' for each)
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
            // Current tab is on the right of destination tab
            } else {
                // If the tab are close to each other (no place to draw full 'circle' for each)
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
        
        path.addLine(to: topRightCorner)
        path.addLine(to: bottomRightCorner)
        return path
    }
}

struct TabBarShape_Previews: PreviewProvider {
    
    private static let dummyParameters = TabBarParameters(circleRadius: 30, circlePad: 5, topPad: 5, segmentWidth: 100, segmentWidths: [.zero], barHeight: 100, barWidth: 500, buttonHeight: 40, buttonWidth: 40, isPortrait: true)
    
    private static let pressed = false
    private static let currTab = 2
    private static let destTab = 1
    
    static var previews: some View {
        Group {
            TabBarShape(destTab: destTab, currentTab: currTab, tabBarCoordinatesParameters: dummyParameters, transitionFactor: 0.0, transitionFactorPressed: 0.0, isPressed: pressed, isPortrait: true)
                .frame(width: dummyParameters.barWidth, height: dummyParameters.barHeight)
                .previewDisplayName("Transition 0.0")
            TabBarShape(destTab: destTab, currentTab: currTab, tabBarCoordinatesParameters: dummyParameters, transitionFactor: 0.1, transitionFactorPressed: 0.1, isPressed: pressed, isPortrait: true)
                .frame(width: dummyParameters.barWidth, height: dummyParameters.barHeight)
                .previewDisplayName("Transition 0.1")
            TabBarShape(destTab: destTab, currentTab: currTab, tabBarCoordinatesParameters: dummyParameters, transitionFactor: 0.3, transitionFactorPressed: 0.3, isPressed: pressed, isPortrait: true)
                .frame(width: dummyParameters.barWidth, height: dummyParameters.barHeight)
                .previewDisplayName("Transition 0.3")
            TabBarShape(destTab: destTab, currentTab: currTab, tabBarCoordinatesParameters: dummyParameters, transitionFactor: 0.5, transitionFactorPressed: 0.5, isPressed: pressed, isPortrait: true)
                .frame(width: dummyParameters.barWidth, height: dummyParameters.barHeight)
                .previewDisplayName("Transition 0.5")
            TabBarShape(destTab: destTab, currentTab: currTab, tabBarCoordinatesParameters: dummyParameters, transitionFactor: 0.7, transitionFactorPressed: 0.7, isPressed: pressed, isPortrait: true)
                .frame(width: dummyParameters.barWidth, height: dummyParameters.barHeight)
                .previewDisplayName("Transition 0.7")
            TabBarShape(destTab: destTab, currentTab: currTab, tabBarCoordinatesParameters: dummyParameters, transitionFactor: 1.0, transitionFactorPressed: 1.0, isPressed: pressed, isPortrait: true)
                .frame(width: dummyParameters.barWidth, height: dummyParameters.barHeight)
                .previewDisplayName("Transition 1.0")
        }
        .previewLayout(.sizeThatFits)
    }
}

