
import SwiftUI

public struct TabContentView: View {
    @Binding private var textSize: CGSize
    
    private var contents: [TabBarEntryView]
    private var selectionIndex: Int
    private var buttonHeight: CGFloat
    private var barHeight: CGFloat
    private var topPad: CGFloat
    private var segmentWidth : CGFloat
    
    public init(textSize: Binding<CGSize>, contents: [TabBarEntryView], selectionIndex: Int, buttonHeight: CGFloat, barHeight: CGFloat, topPad: CGFloat, segmentWidth : CGFloat) {
        self._textSize = textSize
        self.contents = contents
        self.selectionIndex = selectionIndex
        self.buttonHeight = buttonHeight
        self.barHeight = barHeight
        self.topPad = topPad
        self.segmentWidth = segmentWidth
    }
    
    public var body: some View {
        GeometryReader { geometry in
            // Current tab title at the bottom of the selected tab
            self.contents[self.selectionIndex].labelView
                .accessibility(hidden: true)
                .background(ViewGeometry())
                .onPreferenceChange(ViewSizeKey.self) {
                    self.textSize = $0
                }
                .sbbFont(.body)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
                .foregroundColor(Color.sbbColor(.textBlack))
                .padding(.top, self.buttonHeight + self.topPad)
                .offset(x: self.getOffsetLabel(selectionIndex: self.selectionIndex, textWidth: self.textSize.width, segmentWidth: self.segmentWidth))
                .frame(width: geometry.size.width, alignment: .leading)
                .frame(height: self.barHeight, alignment: .topLeading)
        }
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
