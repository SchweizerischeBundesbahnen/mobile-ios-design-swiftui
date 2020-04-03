//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBTextField: View {
    
    @Environment(\.isEnabled) var isEnabled
    @Binding var text: String
    let title: String
    
    public init(text: Binding<String>, title: String = "") {
        self._text = text
        self.title = title
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            TextField(title, text: $text)
                .padding(16)
                .sbbFont(.body)
                .offset(x: 0, y: (!text.isEmpty && !title.isEmpty) ? 7 : 0)
                .foregroundColor(isEnabled ? SBBColor.textBlack : SBBColor.textMetal)
            Text(title)
                .sbbFont(.body, size: 10, lineSpacing: nil)
                .offset(x: 16, y: -11)
                .foregroundColor(SBBColor.textMetal)
                .opacity(text.isEmpty ? 0.0 : 1.0)
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
