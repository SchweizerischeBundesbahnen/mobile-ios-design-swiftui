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
    
    @Environment(\.colorScheme) var colorScheme
     
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
                    .fill(SBBColor.tabViewBackground)
                    .frame(width: self.segmentWidth(parentWidth: geometry.size.width))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(SBBColor.smoke, lineWidth: self.colorScheme == .dark ? 1 : 0)   // only draw border for dark mode
                    )
                    .shadow(color: Color.black.opacity(0.1), radius: 5)
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
                                    .minimumScaleFactor(0.1)
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
