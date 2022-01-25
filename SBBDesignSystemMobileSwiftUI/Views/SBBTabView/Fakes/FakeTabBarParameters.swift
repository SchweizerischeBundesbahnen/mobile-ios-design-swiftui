//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

struct FakeTabBarParameters {
    static let fakeSpaced = TabBarParameters(circleRadius: 22, circlePad: 6, topPad: 8, segmentWidth: 250, segmentWidths: [CGSize(width: 30, height: 20), CGSize(width: 10, height: 10)], barHeight: 80, barWidth: 500, buttonHeight: 58, buttonWidth: 56, isPortrait: true)
    
    static let fakeSpacedLandscape = TabBarParameters(circleRadius: 18, circlePad: 2, topPad: 0, segmentWidth: 250, segmentWidths: [CGSize(width: 20, height: 20), CGSize(width: 5, height: 10)], barHeight: 38, barWidth: 500, buttonHeight: 38, buttonWidth: 36, isPortrait: false)
    
    static let fakeClose = TabBarParameters(circleRadius: 30, circlePad: 5, topPad: 10, segmentWidth: 100, segmentWidths: [CGSize.zero], barHeight: 100, barWidth: 500, buttonHeight: 50, buttonWidth: 50, isPortrait: true)
}
