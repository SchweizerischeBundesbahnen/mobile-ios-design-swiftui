//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import SwiftUI

/**
 A  View that is used to display a picker.
 
 ## Overview
 You create a SBBPicker by providing a binding to the selected value, and the tags which contains all possible values. You then specify the content to be displayed for each tag.
 You can choose whether the SBBPicker is boxed (e.g. background + rounded corner) or not. You can specify a label, in which case the SBBPicker will not be boxed.
 
 ```swift
 @State private var tags = ["Value 1", "Value 2", "Value 3", "Value 4"]
 @State private var selectedTag = "Value 1"
 
 var body: some View {
    VStack {
         SBBPicker(selection: $selectedTag, tags: tags, isBoxed: true) { value in
            Text(value)
        }
         SBBPicker(selection: $selectedTag, tags: tags, label: "Label") { value in
            Text(value)
        }
    }
 }
 ```
 
 ![SBBPicker](SBBPicker)
 */
public struct SBBPicker<Selection: Hashable, Content: View>: View {
    @Binding var selection: Selection
    private var tags: [Selection]
    private let contentBuilder: (Selection) -> Content
    private let isBoxed: Bool
    private let label: String?
    
    /**
     Returns a SBBPicker.
     
     - Parameters:
        - selection: The currently selected value.
        - tags: The list of all possible values.
        - isBoxed: Whether the picker is boxed (background + rounded corner).
        - content: For each value, the view to be displayed in the picker.
     */
    public init(_ selection: Binding<Selection>, tags: [Selection], isBoxed: Bool = true, @ViewBuilder content: @escaping (Selection) -> Content) {
        self.tags = tags
        self._selection = selection
        self.contentBuilder = content
        self.label = nil
        self.isBoxed = isBoxed
    }
    
    /**
     Returns a SBBPicker without background.
     
     - Parameters:
        - selection: The currently selected value.
        - tags: The list of all possible values.
        - label: The label displayed on top.
        - content: For each value, the view to be displayed in the picker.
     */
    public init(_ selection: Binding<Selection>, tags: [Selection], label: String, @ViewBuilder content: @escaping (Selection) -> Content) {
        self.tags = tags
        self._selection = selection
        self.contentBuilder = content
        self.label = label
        self.isBoxed = false
    }
    
    public var body: some View {
        SBBPickerWrapper(pickerView: SBBPickerHelper(selection: $selection, tags: tags, content: contentBuilder).addSelectedView(nbValues: self.tags.count), nbValues: self.tags.count, label: label, isBoxed: isBoxed)
    }
}

struct SBBPicker_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBPicker(.constant("Value 0"), tags: ["Value 0", "Value 1", "Value 2", "Value 3"]) { value in
                Text(value)
            }
                .previewDisplayName("Values")
        }
        .previewLayout(.sizeThatFits)
    }
}
