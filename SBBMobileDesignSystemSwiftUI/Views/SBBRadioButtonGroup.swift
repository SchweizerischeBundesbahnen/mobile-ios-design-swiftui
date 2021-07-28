//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

/// A  View that is used to offer a single selection out of multiple options.
public struct SBBRadioButtonGroup<RadioButtonContent, Selection>: View where RadioButtonContent: View, Selection: Hashable {
    
    private let title: String?
    @Binding private var selection: Selection
    private let tags: [Selection]
    private let radioButtons: [RadioButtonContent]
    private var selectionIndex: Int {
        return tags.firstIndex(of: selection) ?? 0
    }
    
    /**
     Returns a SBBRadioButtonGroup with an optional title and multiple selectable SBBRadioButton.
     
     - Parameters:
        - title: The title to be shown on top of the Container containing all SBBRadioButton.
        - selection: The currently selected SBBRadioButton.
        - tags: An Array containing all SBBRadioButton options. Must have the same number of elements as content.
        - content: An Array of SBBRadioButton of the same type. Must have the same number of elements as tags.
     */
    public init(title: String? = nil, selection: Binding<Selection>, tags: [Selection], @ArrayBuilder<RadioButtonContent> content: () -> [RadioButtonContent]) {
        self.title = title
        self._selection = selection
        self.tags = tags
        self.radioButtons = content()
    }
    
    public var body: some View {
        SBBFormGroup(title: title) {
            ForEach(0..<self.radioButtons.count) { index in
                radioButtons[index]
                    .isSelected(index == selectionIndex)
                    .highPriorityGesture(
                        TapGesture().onEnded {
                            withAnimation {
                                selection = tags[index]
                            }
                        }
                    )
                    .accessibilityAction {
                        selection = tags[index]
                    }
            }
        }
    }
}

struct SBBRadioButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBRadioButtonGroup(selection: .constant(0), tags: [0, 1]) {
                SBBRadioButton(label: "Option 1")
                SBBRadioButton(label: "Option 2", showBottomLine: false)
            }
                .previewDisplayName("Light")
            SBBRadioButtonGroup(selection: .constant(0), tags: [0, 1]) {
                SBBRadioButton(label: "Option 1")
                SBBRadioButton(label: "Option 2", showBottomLine: false)
            }
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark")
        }
            .previewLayout(.sizeThatFits)
    }
}
