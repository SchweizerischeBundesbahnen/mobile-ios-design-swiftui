//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import SwiftUI


/**
 A helper view for ``SBBDatePicker``.
 */
struct SBBDatePickerHelper: View {
    @Binding var selection: Date
    private let component: Calendar.Component
    private let step: Int
    
    private let alignment: HorizontalAlignment
    private let leadingPadding: CGFloat
    private let trailingPadding: CGFloat
    private var valuesRange: Int = 15
    
    init(selection: Binding<Date>,
         component: Calendar.Component,
         step: Int,
         alignment: HorizontalAlignment,
         leadingPadding: CGFloat = 0.0,
         trailingPadding: CGFloat = 0.0) {
        self._selection = selection
        self.component = component
        self.step = step
        self.alignment = alignment
        self.leadingPadding = leadingPadding
        self.trailingPadding = trailingPadding
    }
    
    var body: some View {
        SBBPickerHelper(selection: $selection, tags: selection.getRange(valuesRange, step, for: component), alignment: alignment, leadingPadding: leadingPadding, trailingPadding: trailingPadding, genNewTags: { date in (date.getRange(valuesRange, step, for: component), valuesRange) } ) { date in
            Text(date.format(for: component))
        }
        .onAppear {
            if step != 1 && component == .minute {
                self.selection = self.selection.roundMinuteTo(step)
            }
        }
    }
}
