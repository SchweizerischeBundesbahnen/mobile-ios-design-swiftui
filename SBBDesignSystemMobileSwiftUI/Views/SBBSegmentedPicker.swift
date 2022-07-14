//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/**
 A  View that is used to offer a selection between multiple options (typically used for switching between tabs).
 
 ## Overview
 You create a SBBSegmentedPicker by providing a selectedSegment binding, corresponding possible tags, as well as the differen Views to be displayed in every segment:
 ```swift
 @State private var selectedSegment = 0

 var body: some View {
     SBBSegmentedPicker(selection: $selectedSegment, tags: [0, 1]) {
         HStack {
             Image(sbbName: "timetable", size: .small)
             Text("Departures")
         }
         HStack {
             Image(sbbName: "platform-display", size: .small)
             Text("Platform")
         }
     }
 }
 ```
 Note that the number of Elements in the ViewBuilder must match the number of tags.
 
 ![SBBSegmentedPicker](SBBSegmentedPicker)
 */
public struct SBBSegmentedPicker<Segment, Selection>: View where Segment: View, Selection: Hashable {
    
    /// SBBSegmentedPicker Style.
    public enum Style {
        /// Normal SBBSegmentedPicker Style (white/gray colors)
        case normal
        /// SBBSegmentedPicker Style wiht the custom set primary color
        case primaryColor
        
        var currentSegmentBackgroundColor: Color {
            switch self {
            case .normal:
                return Color.sbbColor(.tabViewBackground)
            case .primaryColor:
                return Color.sbbColor(.primary)
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .normal:
                return Color.sbbColor(.textBlack)
            case .primaryColor:
                return Color.sbbColor(.white)
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .normal:
                return Color.sbbColorInternal(.segmentedPickerBackground)
            case .primaryColor:
                return Color.sbbColor(.primary)
            }
        }
        
        var backgroundSaturation: Double {
            switch self {
            case .normal:
                return 1
            case .primaryColor:
                return 0.8
            }
        }
    }
     
    @Binding private var selection: Selection
    private let tags: [Selection]
    private let segments: [Segment]
    private let style: Style
    private var selectionIndex: Int {
        return tags.firstIndex(of: selection) ?? 0
    }
    
    @State private var didAppear: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
     
    /**
     Returns a SBBSegmentedPicker offering an possibility to switch between multiple options.
     
     - Parameters:
        - selection: The currently selected segment state.
        - tags: An Array containing all selected segment options. Must have the same number of elements as content.
        - style: The color style of the SBBSegmentedPicker.
        - content: An Array of custom Views of the same type (typically [Text] or [Image]). Must have the same number of elements as tags.
     */
    public init(selection: Binding<Selection>, tags: [Selection], style: Style = .normal, @ArrayBuilder<Segment> content: () -> [Segment]) {
        self._selection = selection
        self.tags = tags
        self.segments = content()
        self.style = style
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Highlighter for current segment
                Rectangle()
                    .fill(style.currentSegmentBackgroundColor)
                    .frame(width: self.segmentWidth(parentWidth: geometry.size.width))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.sbbColor(.smoke), lineWidth: self.colorScheme == .dark && style == .normal ? 1 : 0)   // only draw border for dark mode with normal style
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 5)
                    .offset(x: self.segmentWidth(parentWidth: geometry.size.width) * CGFloat(self.selectionIndex))
                    .animation(didAppear ? .default : nil)

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
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.1)
                                Spacer()
                            }
                        }
                            .sbbFont(.body)
                            .foregroundColor(style.foregroundColor)
                            .padding(.horizontal, 16)
                            .frame(width: self.segmentWidth(parentWidth: geometry.size.width), height: 40)
                            .accessibility(hint: Text("\(index + 1) \("of".localized) \(self.segments.count)"))
                            .accessibilityElement(children: .combine)
                    }
                }
            }
                .onAppear {
                    self.didAppear = true
                }
                .highPriorityGesture(DragGesture()
                    .onChanged {
                        self.selection = self.segment(for: $0.location.x, in: geometry.size.width)
                    }
                )
        }
            .padding(2)
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
            .background(style.backgroundColor.saturation(style.backgroundSaturation))
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
            SBBSegmentedPicker(selection: .constant(1), tags: [0, 1], style: .primaryColor) {
                Text("Tab1")
                Text("Tab2")
            }
                .previewDisplayName("Primary, Light")
            SBBSegmentedPicker(selection: .constant(1), tags: [0, 1], style: .primaryColor) {
                Text("Tab1")
                Text("Tab2")
            }
                .previewDisplayName("Primary, Dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}
