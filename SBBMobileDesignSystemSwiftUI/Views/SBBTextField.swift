//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBTextField: View {
    
    @Environment(\.isEnabled) private var isEnabled
    @Binding private var text: String
    @State private var isEditing = false
    let label: String?
    let error: String?
    let icon: Image?
    let showBottomLine: Bool
    
    public init(text: Binding<String>, label: String? = nil, error: String? = nil, icon: Image? = nil, showBottomLine: Bool = true) {
        self._text = text
        if let label = label {
            self.label = NSLocalizedString(label, comment: "")
        } else {
            self.label = nil
        }
        if let error = error {
            self.error = NSLocalizedString(error, comment: "")
        } else {
            self.error = nil
        }
        self.icon = icon
        self.showBottomLine = showBottomLine
    }
    
    private var bottomLineColor: Color {
        if error != nil {
            return .sbbColor(.red)
        }
        switch (isEnabled, isEditing, showBottomLine) {
        case (true, true, _):
            return .sbbColor(.textBlack)
        case (_, _, true):
            return .sbbColorInternal(.textfieldLineInactive)
        default:
            return Color.clear
        }
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 8) {
            if let icon = icon {
                icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24.0, height: 24.0)
                    .padding(.top, 12 )
                    .accessibility(hidden: true)
            }
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    if let label = label {
                        VStack(alignment: .leading, spacing: 4) {
                            if !text.isEmpty {
                                Text(label)
                                    .font(.sbbLight(size: 10))
                                    .foregroundColor(.sbbColor(.placeholder))
                                    .opacity(text.isEmpty ? 0.0 : 1.0)
                                    .accessibility(hidden: true)
                            }
                            TextField(label, text: $text, onEditingChanged: { editing in
                                DispatchQueue.main.async {
                                    withAnimation {
                                        self.isEditing = editing
                                    }
                                }
                            })
                                .modifier(TextFieldPlaceholderCustomColorStyle(showPlaceHolder: text.isEmpty, placeholder: label))
                                .sbbFont(.body)
                                .accessibility(label: Text(accessibilityText))
                        }
                    } else {
                        TextField("", text: $text, onEditingChanged: { editing in
                            DispatchQueue.main.async {
                                withAnimation {
                                    self.isEditing = editing
                                }
                            }
                        })
                            .sbbFont(.body)
                    }
                }
                    .frame(minHeight: 48)
                    .overlay(
                        Group {
                            if isEditing && !text.isEmpty {
                                Button(action: emptyText) {
                                    Image(sbbName: "cross", size: .small)
                                        .accessibility(label: Text("Delete input".localized))
                                }
                                    .buttonStyle(SBBIconButtonStyle(size: .small))
                                    .padding(.trailing, 16)
                            }
                        }
                    , alignment: .trailing)
                if let error = error {
                    Text(error)
                        .font(.sbbLight(size: 10))
                        .foregroundColor(.sbbColor(.red))
                        .padding(.bottom, 8)
                }
            }
            .animation(.linear)
            .background(bottomLineColor.frame(height: 1), alignment: .bottom)
        }
            .padding(.leading, 16)
            .foregroundColor(isEnabled ? .sbbColor(.textBlack) : .sbbColor(.metal))
    }
    
    private func emptyText() {
        text = ""
    }
    
    private var accessibilityText: String {
        var text = ""
        if let label = label {
            text.append("\(label). ")
        }
        if let error = error {
            text.append("\(error). ")
        }
        return text
    }
}

struct SBBTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                SBBTextField(text: .constant("Text"))
                    .previewDisplayName("Light without placeholder")
                SBBTextField(text: .constant(""), label: "Placeholder")
                    .previewDisplayName("Light empty")
                SBBTextField(text: .constant("Text"), label: "Placeholder")
                    .previewDisplayName("Light with text")
                SBBTextField(text: .constant("Text"), label: "Placeholder", icon: Image(sbbName: "route-circle-start", size: .small))
                    .previewDisplayName("Light with Icon")
                SBBTextField(text: .constant(""), label: "Placeholder")
                    .previewDisplayName("Dark empty")
                    .environment(\.colorScheme, .dark)
                SBBTextField(text: .constant("Text"), label: "Placeholder")
                    .previewDisplayName("Dark with text")
                    .environment(\.colorScheme, .dark)
                SBBTextField(text: .constant("Text"), label: "Placeholder", icon: Image(sbbName: "route-circle-start", size: .small))
                    .previewDisplayName("Dark with Icon")
                    .environment(\.colorScheme, .dark)
            }
            Group {
                SBBTextField(text: .constant("Text"), error: "Error")
                    .previewDisplayName("Light without placeholder, error")
                SBBTextField(text: .constant(""), label: "Placeholder", error: "Error")
                    .previewDisplayName("Light empty, error")
                SBBTextField(text: .constant("Text"), label: "Placeholder", error: "Error")
                    .previewDisplayName("Light with text, error")
                SBBTextField(text: .constant("Text"), label: "Placeholder", error: "Error", icon: Image(sbbName: "route-circle-start", size: .small))
                    .previewDisplayName("Light with Icon, error")
                SBBTextField(text: .constant(""), label: "Placeholder", error: "Error")
                    .previewDisplayName("Dark empty, error")
                    .environment(\.colorScheme, .dark)
                SBBTextField(text: .constant("Text"), label: "Placeholder", error: "Error")
                    .previewDisplayName("Dark with text, error")
                    .environment(\.colorScheme, .dark)
                SBBTextField(text: .constant("Text"), label: "Placeholder", error: "Error", icon: Image(sbbName: "route-circle-start", size: .small))
                    .previewDisplayName("Dark with Icon, error")
                    .environment(\.colorScheme, .dark)
            }
        }
            .previewLayout(.sizeThatFits)
    }
}
