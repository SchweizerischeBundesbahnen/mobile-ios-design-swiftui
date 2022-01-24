//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

/**
 A View that is used by ``SBBTabView`` to display the circles icon behind the tab bar.
 */
public struct TabCircleRowView: View {
    
    private var contents: [TabBarEntryView]
    private var tabBarParameters: TabBarParameters
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    /**
     Returns a TabCircleRowView displaying a row of circle.
     
     - Parameters:
        - content: An array of TabBarEntryView, specifying the content of each tab.
        - tabBarParameters: The TabBarParameters used to create the tab bar.
     */
    public init(content: [TabBarEntryView], tabBarParameters: TabBarParameters) {
        self.contents = content
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

struct TabCircleRowView_Previews: PreviewProvider {
    private static var circleRow = TabCircleRowView(content: [
        FakeTabBarEntry.fakeTab1,
        FakeTabBarEntry.fakeTab2
    ], tabBarParameters: FakeTabBarParameters.fakeSpaced)
    
    static var previews: some View {
        Group {
            circleRow
                .background(Color.sbbColor(.background))
                .environment(\.horizontalSizeClass, .compact)
                .environment(\.verticalSizeClass, .regular)
                .previewDisplayName("Light")
            
            circleRow
                .background(Color.sbbColor(.background))
                .environment(\.horizontalSizeClass, .compact)
                .environment(\.verticalSizeClass, .regular)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
