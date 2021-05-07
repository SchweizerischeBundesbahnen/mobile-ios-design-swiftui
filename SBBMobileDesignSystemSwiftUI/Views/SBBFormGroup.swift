//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBFormGroup<Content>: View where Content: View {
    
    private let title: LocalizedStringKey?
    private let content: () -> Content
    
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
                        .sbbFont(.body)
                        .padding([.bottom, .leading, .trailing], 16)
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
                Text("Text").sbbFont(.body).padding(16)
            }
            .previewDisplayName("One row, no title, light")
            SBBFormGroup(title: "Title") {
                Text("Text").sbbFont(.body).padding(16)
                SBBTextField(text: .constant("Value"), label: "title")
                SBBCheckBox(isOn: .constant(true), label: "Placeholder")
            }
            .previewDisplayName("Light")
            SBBFormGroup(title: "Title") {
                Text("Text").sbbFont(.body).padding(16)
                SBBTextField(text: .constant("Value"), label: "title")
                SBBCheckBox(isOn: .constant(true), label: "Placeholder")
            }
            .previewDisplayName("Dark")
            .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
