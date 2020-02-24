//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBSegmentedPicker<Segment, Selection>: View where Segment: View, Selection: Hashable {
     
    @Binding private var selection: Selection
    private let tags: [Selection]
    private let segments: [Segment]
    private var selectionIndex: Int {
        return tags.firstIndex(of: selection) ?? 0
    }
     
    public init(selection: Binding<Selection>, tags: [Selection], @ArrayBuilder<Segment> content: () -> [Segment]) {
        self._selection = selection
        self.tags = tags
        self.segments = content()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Highlighter for current segment
                Rectangle()
                    .fill(SBBColor.controlBackground)
                    .frame(width: self.segmentWidth(parentWidth: geometry.size.width))
                    .cornerRadius(20)
                    .offset(x: self.segmentWidth(parentWidth: geometry.size.width) * CGFloat(self.selectionIndex))
                    .animation(.default)

                // Segments
                HStack(spacing: 0) {
                    ForEach(0..<self.segments.count) { index in
                        Button(action: {
                                self.selection = self.tags[index]
                        }) {
                            HStack(spacing: 0) {
                                Spacer()
                                    .accessibility(label: Text((index == self.selectionIndex) ? "selected".localized : ""))
                                self.segments[index]
                                Spacer()
                            }
                        }
                            .sbbFont(.body)
                            .foregroundColor(SBBColor.textBlack)
                            .padding(.horizontal, 16)
                            .frame(width: self.segmentWidth(parentWidth: geometry.size.width), height: 40)
                            .accessibility(hint: Text("\(index + 1) \("of".localized) \(self.segments.count)"))
                            .accessibilityElement(children: .combine)
                    }
                }
            }
                .highPriorityGesture(DragGesture()
                    .onChanged {
                        self.selection = self.segment(for: $0.location.x, in: geometry.size.width)
                    }
                )
        }
            .padding(2)
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
            .background(SBBColor.segmentedPickerBackground)
            .cornerRadius(22)
            .shadow(radius: 4, y: 2)
    }
    
    private func segment(for xPosition: CGFloat, in parentWidth: CGFloat) -> Selection {
        var index = min(Int(xPosition / segmentWidth(parentWidth: parentWidth)), segments.count - 1)
        index = max(0, min(index, segments.count - 1))
        return tags[index]
    }
    
    private func segmentWidth(parentWidth: CGFloat) -> CGFloat {
        return parentWidth / CGFloat(self.segments.count)
    }
}

struct SBBSegmentedPicker_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBSegmentedPicker(selection: .constant(0), tags: [0, 1]) {
                Text("Tab1")
                Text("Tab2")
            }
                .previewDisplayName("Light")
            SBBSegmentedPicker(selection: .constant(1), tags: [0, 1]) {
                Text("Tab1")
                Text("Tab2")
            }
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}

// Somehow the SwiftUI @ViewBuilder doesn't seem to work properly (it always calls the default initializer and not the appropiate one with the correct number of TupleViews). That's why we're using this workaround for now. Drawback: You can only assign views of the same type (e.g. TextView).
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