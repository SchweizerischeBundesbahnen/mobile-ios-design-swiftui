//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/**
 A View that is used to group corresponding ``SBBListItem``s or form elements (e.g. ``SBBTextField`` or ``SBBCheckBox``). Elements are stacked vertically.
 
 ## Overview
 You create a SBBFormGroup by providing a title as well as the Views to be stacked vertically inside the group:
 ```swift
 var body: some View {
     SBBFormGroup(title: "Title:") {
         SBBTextField(text: .constant("My Value"), label: "Placeholder")
         SBBCheckBox(isOn: .constant(true), text: Text("CheckBox"), showBottomLine: false)
     }
 }
 ```
 ![SBBFormGroup](SBBFormGroup)
 */
public struct SBBFormGroup<Content>: View where Content: View {
    
    private let title: LocalizedStringKey?
    private let content: () -> Content
    
    /**
     Returns a SBBFormGroup used to group corresponding list or form elements.
     
     - Parameters:
        - title: The optional Text to display as title on top of the vertically stacked elements.
        - content: The custom Views to be stacked vertically.
     */
    public init(title: String? = nil, @ViewBuilder content: @escaping () -> Content) {
        if let title = title {
            self.title = LocalizedStringKey(title)
        } else {
            self.title = nil
        }
        self.content = content
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let title = title {
                HStack(alignment: .top, spacing: 0) {
                    Text(title)
                        
                        .padding([.leading, .trailing], 16)
                        .padding(.bottom, 8)
                        .accessibility(addTraits: .isHeader)
                    Spacer(minLength: 0)
                }
                .accessibilityElement(children: .combine)
            }
            VStack(alignment: .leading, spacing: 0) {
                content()
            }
            .background(Color.sbbColor(.viewBackground))
            .cornerRadius(16)
        }
    }
}

struct SBBFormGroup_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBFormGroup() {
                Text("Text").sbbFont(.medium_light).padding(16)
            }
            .previewDisplayName("One row, no title, light")
            SBBFormGroup(title: "Title") {
                Text("Text").sbbFont(.medium_light).padding(16)
                SBBTextField(text: .constant("Value"), label: "title")
                SBBCheckBox(isOn: .constant(true), text: Text("Placeholder"))
            }
            .previewDisplayName("Light")
            SBBFormGroup(title: "Title") {
                Text("Text").sbbFont(.medium_light).padding(16)
                SBBTextField(text: .constant("Value"), label: "title")
                SBBCheckBox(isOn: .constant(true), text: Text("Placeholder"))
            }
            .previewDisplayName("Dark")
            .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
