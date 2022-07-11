//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

/**
 A View that is used by ``SBBTabView`` to display the circles icon behind the tab bar.
 */
struct TabCircleRowView: View {
    
    private var selectionIndex: Int
    private var contents: [TabBarEntryView]
    private var tabBarParameters: TabBarParameters
    
    /**
     Returns a TabCircleRowView displaying a row of circle.
     
     - Parameters:
        - selectionIndex: The index of the selected tab.
        - content: An array of TabBarEntryView, specifying the content of each tab.
        - tabBarParameters: The TabBarParameters used to create the tab bar.
     */
    public init(selectionIndex: Int, content: [TabBarEntryView], tabBarParameters: TabBarParameters) {
        self.selectionIndex = selectionIndex
        self.contents = content
        self.tabBarParameters = tabBarParameters
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(self.contents.enumerated()), id: \.offset) { index, entry in
                Circle()
                    .overlay(entry.imageView.foregroundColor(entry.customForeground != nil ? entry.customForeground! : Color.sbbColor(.background)))
                    .frame(width: self.tabBarParameters.circleRadius * 2, height: self.tabBarParameters.circleRadius * 2)
                    .padding(.top, self.tabBarParameters.topPad)
                    .padding(.trailing, self.tabBarParameters.isPortrait ? 0 : index == self.selectionIndex ? self.tabBarParameters.segmentWidths[index].width + 15 : self.tabBarParameters.segmentWidths[index].width + 5)
                    .foregroundColor(entry.customBackground != nil ? entry.customBackground! : Color.sbbColor(.textBlack))
            }
            .frame(width: self.tabBarParameters.segmentWidth, height: self.tabBarParameters.barHeight, alignment: .top)
            .accessibilityHidden(true)
        }
    }
}

struct TabCircleRowView_Previews: PreviewProvider {
    private static var circleRow = TabCircleRowView(selectionIndex: 0, content: [
        FakeTabBarEntry.fakeTab1,
        FakeTabBarEntry.fakeTab2
    ], tabBarParameters: FakeTabBarParameters.fakeSpaced)
    
    private static var circleRowLandscape = TabCircleRowView(selectionIndex: 0, content: [
        FakeTabBarEntry.fakeTab1,
        FakeTabBarEntry.fakeTab2
    ], tabBarParameters: FakeTabBarParameters.fakeSpacedLandscape)
    
    static var previews: some View {
        Group {
            circleRow
                .background(Color.sbbColor(.background))
                .previewDisplayName("Light portrait")
            
            circleRow
                .background(Color.sbbColor(.background))
                .previewDisplayName("Dark portrait")
                .environment(\.colorScheme, .dark)
            
            circleRowLandscape
                .background(Color.sbbColor(.background))
                .previewDisplayName("Light landscape")
            
            circleRowLandscape
                .background(Color.sbbColor(.background))
                .previewDisplayName("Dark landscape")
                .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
