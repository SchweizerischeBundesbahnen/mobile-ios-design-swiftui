//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import SwiftUI

/**
 Values used to create ``SBBPicker`` and ``SBBDatePicker``.
 */
struct SBBPickerValues {
    static let nbVisibleValues: Double = 7
    static let datePickerHeight: CGFloat = 238
    static var valuesHeight: CGFloat {
        datePickerHeight / nbVisibleValues
    }
    
    static func getHeight(_ nbValues: Int) -> CGFloat {
        if nbValues >= 7 {
            return SBBPickerValues.datePickerHeight
        } else if nbValues > 4 {
            return 5 * SBBPickerValues.valuesHeight
        } else if nbValues > 2 {
            return 3 * SBBPickerValues.valuesHeight
        } else {
            return SBBPickerValues.valuesHeight
        }
    }
}

/**
 A View that displays a minimum implementation of a picker: list of values + selected value, scrollable.
 */
struct SBBPickerHelper<Selection: Hashable, Content: View>: View {
    @State private var tags: [Selection]
    private let contentBuilder: (Selection) -> Content
    private let genNewTags: ((Selection) -> ([Selection], Int))?
    private let alignment: HorizontalAlignment
    private let leadingPadding: CGFloat
    private let trailingPadding: CGFloat
    
    @State var allValuesHeight: CGFloat = .zero
    @State var pickerWidth: CGFloat = .zero
    @State var position: Int
    @Binding var selection: Selection
    @GestureState private var translation: CGFloat = 0
    
    private let alphaFactor: Double = 0.2
    
    init(selection: Binding<Selection>, tags: [Selection], alignment: HorizontalAlignment = .center, leadingPadding: CGFloat = 0.0, trailingPadding: CGFloat = 0.0, genNewTags: ((Selection) -> ([Selection], Int))? = nil, @ViewBuilder content: @escaping (Selection) -> Content) {
        self._selection = selection
        self._tags = State(initialValue: tags)
        self.alignment = alignment
        self.leadingPadding = leadingPadding
        self.trailingPadding = trailingPadding
        self.genNewTags = genNewTags
        self.contentBuilder = content
        self._position = State(initialValue: tags.firstIndex(of: selection.wrappedValue) ?? 0 as Int)
    }
    
    var body: some View {
        ZStack {
            LazyVStack(alignment: alignment, spacing: 0) {
                ForEach(0..<tags.count, id: \.self) { position in
                    drawContentView(position)
                        .frame(height: SBBPickerValues.valuesHeight)
                }
            }
            .offset(y: -CGFloat(self.position + 1) * SBBPickerValues.valuesHeight)
            .offset(y: self.translation + (SBBPickerValues.datePickerHeight / 2) + (SBBPickerValues.valuesHeight / 2))
            .viewHeight($allValuesHeight)
            .offset(y:  min((allValuesHeight - SBBPickerValues.datePickerHeight) / 2, allValuesHeight / 2))
            .frame(maxHeight: SBBPickerValues.getHeight(self.tags.count), alignment: .center)
            .clipped()
            .onChange(of: self.selection) { selection in
                if let genNewTags = self.genNewTags {
                    let gen = genNewTags(self.selection)
                    self.tags = gen.0
                    self.position = gen.1
                } else {
                    self.position = self.tags.firstIndex(of: selection) ?? 0 as Int
                    self.selection = selection
                }
            }
            .padding(.leading, leadingPadding)
            .padding(.trailing, trailingPadding)
            
            // WORKAROUND: Add "clear" rectangle for the gesture; otherwise the gesture extends past the view
            // Cannot be completely clear as otherwise the gesture does not work
            Rectangle()
                .frame(maxHeight: SBBPickerValues.getHeight(self.tags.count), alignment: .center)
                .opacity(0.00001)
                .gesture(
                    DragGesture().updating(self.$translation) { value, state, _ in
                        state = value.translation.height
                    }
                        .onEnded { value in
                            // From the position, get the new selected value
                            let offset = value.translation.height / SBBPickerValues.valuesHeight
                            let newIndex = (CGFloat(self.position) - offset).rounded()
                            self.position = min(max(Int(newIndex), 0), self.tags.count - 1)
                            self.selection = self.tags[self.position]
                            
                            // If need to generate new tags based on that (return new tags + index of currently selected)
                            if let genNewTags = self.genNewTags {
                                let gen = genNewTags(self.selection)
                                self.tags = gen.0
                                self.position = gen.1
                            }
                        }
                )
        }
    }
    
    private func drawContentView(_ position: Int) -> some View {
        var alphaResult: Double = 1
        
        if alphaFactor != 1.0 {
            let maxRange = floor(SBBPickerValues.nbVisibleValues / 2.0)
            let offset = translation / SBBPickerValues.valuesHeight
            let newIndex = CGFloat(self.position) - offset
            let posGap = CGFloat(position) - newIndex
            var per = abs(posGap / maxRange)
            if 1.0 < per {
                per = 1.0
            }
            
            if alphaFactor != 1.0 {
                let alphaGap = 1.0 - alphaFactor
                let preAlphaRst = Double(per) * alphaGap
                alphaResult = 1.0 - preAlphaRst
            }
        }
        
        return contentBuilder(tags[position])
                .font(.custom("SBBWeb-Roman", fixedSize: 24))
                .foregroundColor(Color.sbbColor(self.position == position ? .textBlack : .placeholder))
                .opacity(alphaResult)
    }
}
