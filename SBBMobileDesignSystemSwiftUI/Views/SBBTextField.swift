//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBTextField: View {
    
    @Environment(\.isEnabled) private var isEnabled
    @Binding private var text: String
    let label: LocalizedStringKey?
    
    public init(text: Binding<String>, label: String? = nil) {
        self._text = text
        if let label = label {
            self.label = LocalizedStringKey(label)
        } else {
            self.label = nil
        }
    }
    
    public var body: some View {
        Group {
            if label != nil {
                VStack(alignment: .leading, spacing: 4) {
                    if !text.isEmpty {
                        Text(label!)
                            .sbbFont(.body, size: 10, lineSpacing: nil)
                            .foregroundColor(SBBColor.placeholder)
                            .opacity(text.isEmpty ? 0.0 : 1.0)
                            .accessibility(hidden: true)
                    }
                    TextField(label!, text: $text)
                        .sbbFont(.body)
                        .foregroundColor(isEnabled ? SBBColor.textBlack : SBBColor.textMetal)
                        .accessibility(label: text.isEmpty ? Text("") : Text(label!))
                }
                .padding([.leading, .trailing], 16)
            } else {
                TextField("", text: $text)
                    .padding(16)
                    .sbbFont(.body)
                    .foregroundColor(isEnabled ? SBBColor.textBlack : SBBColor.textMetal)
            }
        }
        .frame(minHeight: 48)
        .background(SBBColor.viewBackground)
        .cornerRadius(16)
        .animation(.linear)
    }
}

struct SBBTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBTextField(text: .constant(""), label: "Placeholder")
                .previewDisplayName("Light empty")
            SBBTextField(text: .constant("Text"), label: "Placeholder")
                .previewDisplayName("Light with text")
            SBBTextField(text: .constant(""), label: "Placeholder")
                .previewDisplayName("Dark empty")
                .environment(\.colorScheme, .dark)
            SBBTextField(text: .constant("Text"), label: "Placeholder")
                .previewDisplayName("Dark with text")
                .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
