//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI
import Foundation


/**
 A Shape that is used to create the tab bar.
 */
struct TabBarShape: Shape {
    private var selectedTab: Int
    private var nbTabs: Int
    private var circleSize: CGFloat
    private var segmentWidth: CGFloat
    
    public init(selectedTab: Int, nbTabs: Int, circleSize: CGFloat, segmentWidth: CGFloat) {
        self.selectedTab = selectedTab
        self.nbTabs = nbTabs
        self.circleSize = circleSize
        self.segmentWidth = segmentWidth
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let bottomLeftCorner = CGPoint(x: rect.minX, y: rect.maxY)
        let topLeftCorner = CGPoint(x: rect.minX, y: rect.minY)
        let topRightCorner = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRightCorner = CGPoint(x: rect.maxX, y: rect.maxY)
        
        let offset: CGFloat = segmentWidth * CGFloat(selectedTab)
        let circleOffset = (segmentWidth - circleSize * 1.2) / 2
                
        // First curve on the left
        let startLeftCurve = CGPoint(x: offset + circleOffset - circleSize / 2, y: rect.minY)
        let endLeftCurve = CGPoint(x: offset + circleOffset, y: circleSize / 2)
        let controlLeft = CGPoint(x: offset + circleOffset, y: rect.minY)
        // Middle curve
        let endMiddleCurve = CGPoint(x: offset - circleOffset + segmentWidth, y: circleSize / 2 )
        let control1Middle = CGPoint(x: offset + circleOffset, y: circleSize * 1.4)
        let control2Middle = CGPoint(x: offset - circleOffset + segmentWidth, y: circleSize * 1.4)
        // Right curve
        let endRightCurve = CGPoint(x: offset - circleOffset + segmentWidth + circleSize, y: rect.minY)
        let controlRight = CGPoint(x: offset - circleOffset + segmentWidth, y: rect.minY)
        
        // Start bottom left corner
        path.move(to: bottomLeftCorner)
        // Draw lines to start of the left curve
        path.addLines([bottomLeftCorner, topLeftCorner, startLeftCurve])
        // Draw left curve
        path.addQuadCurve(to: endLeftCurve, control: controlLeft)
        // Draw middle curve
        path.addCurve(to: endMiddleCurve, control1: control1Middle, control2: control2Middle)
        // Draw right curve
        path.addQuadCurve(to: endRightCurve, control: controlRight)
        // Add lines to complete path
        path.addLines([endRightCurve, topRightCorner, bottomRightCorner, bottomLeftCorner])
        
        return path
    }
}
