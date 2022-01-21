//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

/**
 A View that is used to display the circles icon behind the tab bar
 */
public struct TabCircleRowView: View {
    
    private var contents: [TabBarEntryView]
    private var tabBarParameters: TabBarParameters
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    public init(contents: [TabBarEntryView], tabBarParameters: TabBarParameters) {
        self.contents = contents
        self.tabBarParameters = tabBarParameters
    }
    
    public var body: some View {
        let isPortrait = self.horizontalSizeClass == .compact && self.verticalSizeClass == .regular
        HStack(spacing: 0) {
            ForEach(0..<self.contents.count) { index in
                Circle()
                    .overlay(self.contents[index].imageView.colorInvert())
                    .frame(width: self.tabBarParameters.circleRadius * 2, height: self.tabBarParameters.circleRadius * 2, alignment: .leading)
                    .padding(.top, self.tabBarParameters.topPad)
                    .padding(.trailing, isPortrait ? 0 : self.tabBarParameters.segmentWidths[index].width)
                    .frame(width: self.tabBarParameters.segmentWidth, height: self.tabBarParameters.barHeight, alignment: .top)
            }
            .frame(width: self.tabBarParameters.segmentWidth, height: self.tabBarParameters.barHeight, alignment: .top)
            .accessibilityHidden(true)
        }
    }
}
