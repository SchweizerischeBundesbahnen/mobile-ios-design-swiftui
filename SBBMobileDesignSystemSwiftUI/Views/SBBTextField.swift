//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBTextField: View {
    
    @Environment(\.isEnabled) private var isEnabled
    @Binding private var text: String
    @State private var isEditing = false
    let label: LocalizedStringKey?
    
    public init(text: Binding<String>, label: String? = nil) {
        self._text = text
        if let label = label {
            self.label = LocalizedStringKey(label)
        } else {
            self.label = nil
        }
    }
    
    private var bottomLineColor: Color {
        switch (isEnabled, isEditing) {
        case (true, true):
            return SBBColor.textfieldLineActive
        default:
            return SBBColor.textfieldLineInactive
        }
    }
    
    public var body: some View {
        HStack {
            if label != nil {
                VStack(alignment: .leading, spacing: 4) {
                    if !text.isEmpty {
                        Text(label!)
                            .sbbFont(.body, size: 10, lineSpacing: nil)
                            .foregroundColor(SBBColor.placeholder)
                            .opacity(text.isEmpty ? 0.0 : 1.0)
                            .accessibility(hidden: true)
                    }
                    TextField(label!, text: $text, onEditingChanged: { editing in
                        DispatchQueue.main.async {
                            self.isEditing = editing
                        }
                    })
                        .sbbFont(.body)
                        .foregroundColor(isEnabled ? SBBColor.textBlack : SBBColor.textMetal)
                        .accessibility(label: text.isEmpty ? Text("") : Text(label!))
                }
            } else {
                TextField("", text: $text, onEditingChanged: { editing in
                    DispatchQueue.main.async {
                        self.isEditing = editing
                    }
                })
                    .sbbFont(.body)
                    .foregroundColor(isEnabled ? SBBColor.textBlack : SBBColor.textMetal)
            }
            Spacer(minLength: 0)
        }
        .frame(minHeight: 48)
        .background(bottomLineColor.frame(height: 1), alignment: .bottom)
        .padding(.leading, 16)
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
