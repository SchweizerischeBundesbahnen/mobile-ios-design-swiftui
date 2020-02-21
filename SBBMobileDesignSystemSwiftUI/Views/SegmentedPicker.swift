//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SegmentedPicker<Segment>: View where Segment: View {
     
    @Binding var selection: Int
    let childs : [Segment]
     
    public init(selection: Binding<Int>, @ArrayBuilder<Segment> content: () -> [Segment]) {
        self._selection = selection
        self.childs = content()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Highlighter for current segment
                Rectangle()
                    .fill(SBBColor.controlBackground)
                    .frame(width: self.segmentWidth(parentWidth: geometry.size.width))
                    .cornerRadius(20)
                    .offset(x: self.segmentWidth(parentWidth: geometry.size.width) * CGFloat(self.selection))
                    .animation(.default)

                // Segments
                HStack(spacing: 0) {
                    ForEach(0..<self.childs.count) { index in
                        self.childs[index]
                            .sbbFont(.body)
                            .foregroundColor(SBBColor.textBlack)
                            .padding(.horizontal, 16)
                            .frame(width: self.segmentWidth(parentWidth: geometry.size.width))
                    }
                }
            }
        }
            .padding(2)
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
            .background(SBBColor.segmentedPickerBackground)
            .cornerRadius(22)
    }
    
    private func segmentWidth(parentWidth: CGFloat) -> CGFloat {
        return parentWidth / CGFloat(self.childs.count)
    }
    
    private func currentSegmentOffset(parentWidth: CGFloat) -> CGFloat {
        return self.segmentWidth(parentWidth: parentWidth) * CGFloat(self.selection)
    }
}

struct SegmentedPicker_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SegmentedPicker(selection: .constant(0)) {
                Text("Tab1")
                Text("Tab2")
            }
                .previewDisplayName("Light")
            SegmentedPicker(selection: .constant(1)) {
                Text("Tab1")
                Text("Tab2")
            }
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}

// https://github.com/SwiftUIX/SwiftUIX/blob/master/Sources/Intermodular/Helpers/Swift/ArrayBuilder.swift
@_functionBuilder
public class ArrayBuilder<Element> {
    public static func buildBlock() -> [Element] {
        return []
    }
    
    public static func buildBlock(_ element: Element) -> [Element] {
        return [element]
    }
    
    public static func buildBlock(_ elements: Element...) -> [Element] {
        return elements
    }
}
