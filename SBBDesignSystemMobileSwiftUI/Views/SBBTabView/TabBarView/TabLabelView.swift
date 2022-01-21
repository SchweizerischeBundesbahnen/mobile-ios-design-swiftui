//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

/**
 A View that is used to display the label of the currently selected tab.
 */
public struct TabLabelView: View {
    
    @Binding private var textSize: CGSize
    
    private var contents: [TabBarEntryView]
    private var selectionIndex: Int
    private var tabBarParameters: TabBarParameters
    
    /**
     Returns a TabLabelView displaying the label of the currently selected tab.
     
     - Parameters:
        - textSize: The size of the label to display.
        - content: An array of TabBarEntryView, specifying the content of each tab.
        -  selectionIndex: The index of the selected tab
        - tabBarParameters: The TabBarParameters used to create the tab bar.
     */
    public init(textSize: Binding<CGSize>, content: [TabBarEntryView], selectionIndex: Int, tabBarParameters: TabBarParameters) {
        self._textSize = textSize
        self.contents = content
        self.selectionIndex = selectionIndex
        self.tabBarParameters = tabBarParameters
    }
    
    public var body: some View {
        self.contents[self.selectionIndex].labelView
            .background(ViewGeometry())
            .onPreferenceChange(ViewSizeKey.self) {
                self.textSize = $0
            }
            .sbbFont(.body)
            .lineLimit(1)
            .minimumScaleFactor(0.1)
            .foregroundColor(Color.sbbColor(.textBlack))
            .padding(.top, self.tabBarParameters.buttonHeight)
            .offset(x: self.getOffsetLabel(selectionIndex: self.selectionIndex, textWidth: self.textSize.width, segmentWidth: self.tabBarParameters.segmentWidth))
            .frame(width: self.tabBarParameters.barWidth, height: self.tabBarParameters.barHeight, alignment: .topLeading)
            .accessibility(hidden: true)
    }
    
    private func getOffsetLabel(selectionIndex: Int, textWidth: CGFloat, segmentWidth: CGFloat) -> CGFloat {
        let halfSegment = segmentWidth / 2
        let halfText = textWidth / 2
        let offset = segmentWidth * CGFloat(selectionIndex) + halfSegment - halfText
        
        if selectionIndex == 0 {
            if halfText >= 0.8 * halfSegment {
                return 10
            }
            return halfSegment - halfText
        } else if selectionIndex == self.contents.count - 1 {
            if halfText >= 0.8 * halfSegment {
                return offset - halfText + halfSegment - 10
            }
            return offset
        } else {
            return offset
        }
    }
}

struct TabLabelView_Previews: PreviewProvider {
    private static var label = TabLabelView(textSize: .constant(CGSize.init(width: 20, height: 20)), content: [FakeTabBarEntry.fakeTab1, FakeTabBarEntry.fakeTab2], selectionIndex: 0, tabBarParameters: FakeTabBarParameters.fakeSpaced)
    
    static var previews: some View {
        Group {
            label
                .background(Color.sbbColor(.background))
                .previewDisplayName("Light")
            
            label
                .background(Color.sbbColor(.background))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark")
        }
        .previewLayout(.sizeThatFits)
    }
}
