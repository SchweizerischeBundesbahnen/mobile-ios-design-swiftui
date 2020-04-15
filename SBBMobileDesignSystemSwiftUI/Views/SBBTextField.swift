//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBTextField: View {
    
    @Environment(\.isEnabled) private var isEnabled
    @Binding private var text: String
    let title: LocalizedStringKey?
    
    public init(text: Binding<String>, title: String? = nil) {
        self._text = text
        if let title = title {
            self.title = LocalizedStringKey(title)
        } else {
            self.title = nil
        }
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            if title != nil {
                TextField(title!, text: $text)
                    .padding(16)
                    .sbbFont(.body)
                    .offset(x: 0, y: (!text.isEmpty) ? 7 : 0)
                    .foregroundColor(isEnabled ? SBBColor.textBlack : SBBColor.textMetal)
                    .accessibility(label: Text(title!))
                    .accessibility(value: Text(text))
                Text(title!)
                    .sbbFont(.body, size: 10, lineSpacing: nil)
                    .offset(x: 16, y: -11)
                    .foregroundColor(SBBColor.textMetal)
                    .opacity(text.isEmpty ? 0.0 : 1.0)
                    .accessibility(hidden: true)
            } else {
                TextField("", text: $text)
                    .padding(16)
                    .sbbFont(.body)
                    .foregroundColor(isEnabled ? SBBColor.textBlack : SBBColor.textMetal)
            }
        }
        .frame(height: 48)
        .background(SBBColor.controlBackground)
        .cornerRadius(16)
    }
}

struct SBBTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBTextField(text: .constant(""), title: "Placeholder")
                .previewDisplayName("Light empty")
            SBBTextField(text: .constant("Text"), title: "Placeholder")
                .previewDisplayName("Light with text")
            SBBTextField(text: .constant(""), title: "Placeholder")
                .previewDisplayName("Dark empty")
                .environment(\.colorScheme, .dark)
            SBBTextField(text: .constant("Text"), title: "Placeholder")
                .previewDisplayName("Dark with text")
                .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
