//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/**
 A  View that is used for entering text (single line).
 
 ## Overview
 You create a SBBTextField  by providing a binding to inputText, a static placeholder label, an optional error and an optional icon:
 ```swift
 @State var input = "I like trains"

 var body: some View {
    SBBTextField(text: $input, label: "Placeholder", error: "Error", icon: Image(sbbIcon: .route_circle_start_small))
 }
 ```
 ![SBBTextField](SBBTextField)
 */
public struct SBBTextField: View {
    
    @Environment(\.isEnabled) private var isEnabled
    @Binding private var text: String
    @Binding var isEditing: Bool
    @State private var isFocused = false
    let label: String?
    let error: String?
    let additionalAccessibilityText: String?
    let icon: Image?
    let showBottomLine: Bool
    let showClearButtonWhenEditing: Bool
    let boxed: Bool
    let showIconBorder: Bool
    
    /**
     Returns a SBBTextField with a label and an optional Image.
     
     - Parameters:
        - text: Sets the user-modifiable text state.
        - label: An optional label displayed instead of the text (if the text is empty) or above the text (if not empty).
        - error: An optional label used to display errors with user input. Displayed below the text in red color and adding a red separator line below the entire SBBTextField.
        - additionalAccessibilityText: An optional string appended at the end of the accessibility label.
        - icon: An optional Image to be shown on the leading edge of the SBBTextField.
        - showBottomLine: Shows or hides a separator line at the bottom of the View (typically only false for last elements in a List).
        - showClearButtonWhenEditing: Shows or hides the clear button when editing a text.
        - showIconBorder: Shows the border of the icon when editing a text..
        - boxed: Shows the Textfield inside a white box when enabled, and with a clear background when disabled (default). Clear background does not work inside SBBFormGroup.
        - isEditing: a binding to get the state of the TextField (whether of not it is editing)
     */
    public init(text: Binding<String>, label: String? = nil, error: String? = nil, additionalAccessibilityText: String? = nil, icon: Image? = nil, showBottomLine: Bool = true, showClearButtonWhenEditing: Bool = true, showIconBorder: Bool = true, boxed: Bool = false, isEditing: Binding<Bool>? = nil) {
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
        if let additionalAccessibilityText = additionalAccessibilityText {
            self.additionalAccessibilityText = NSLocalizedString(additionalAccessibilityText, comment: "")
        } else {
            self.additionalAccessibilityText = nil
        }
        self.icon = icon
        self.showBottomLine = showBottomLine
        self.showClearButtonWhenEditing = showClearButtonWhenEditing
        self.showIconBorder = showIconBorder
        self.boxed = boxed
        self._isEditing = isEditing != nil ? isEditing! : .constant(false)
    }
    
    private var bottomLineColor: Color {
        if error != nil {
            return .sbbColor(.red)
        }
        switch (isEnabled, isFocused, showBottomLine) {
        case (true, true, true):
            return .sbbColor(.textBlack)
        case (true, true, false):
            return Color.clear
        case (_, _, true):
            return .sbbColorInternal(.textfieldLineInactive)
        default:
            return Color.clear
        }
    }
    
    private var hasError: Bool {
        guard let error = error, !error.isEmpty else {
            return false
        }
        return true
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
                HStack {
                    if let label = label {
                        VStack(alignment: .leading, spacing: 4) {
                            if !text.isEmpty {
                                Text(label)
                                    .font(.sbbLight(size: 10))
                                    .foregroundColor(.sbbColor(.placeholder))
                                    .opacity(text.isEmpty ? 0.0 : 1.0)
                                    .accessibility(hidden: true)
                            }
                            TextField("", text: $text, onEditingChanged: { editing in
                                DispatchQueue.main.async {
                                    withAnimation {
                                        self.isEditing = editing
                                        self.isFocused = editing
                                    }
                                }
                            })
                                .modifier(TextFieldPlaceholderCustomColorStyle(showPlaceHolder: text.isEmpty, placeholder: label))
                                .sbbFont(.medium_light)
                                .accessibility(label: Text(accessibilityText))
                        }
                    } else {
                        TextField("", text: $text, onEditingChanged: { editing in
                            DispatchQueue.main.async {
                                withAnimation {
                                    self.isEditing = editing
                                    self.isFocused = editing
                                }
                            }
                        })
                            .sbbFont(.medium_light)
                    }
                    
                    if showClearButtonWhenEditing && isFocused && !text.isEmpty {
                        Button(action: emptyText) {
                            Image(sbbIcon: .cross_small)
                                .accessibility(label: Text("Delete input".localized))
                        }
                            .buttonStyle(SBBIconButtonStyle(size: .small, showBorder: showIconBorder))
                            .padding(.trailing, 16)
                    }
                }
                    .frame(minHeight: 48)
                if let error = error {
                    Text(error)
                        .font(.sbbLight(size: 10))
                        .foregroundColor(.sbbColor(.red))
                        .padding(.bottom, 8)
                }
            }
            .background(bottomLineColor.frame(height: 1), alignment: .bottom)
        }
            .padding(.leading, 16)
            .foregroundColor(isEnabled ? .sbbColor(.textBlack) : .sbbColor(.metal))
            .background(boxed ? Color.sbbColor(.viewBackground) : .clear)
            .cornerRadius(boxed ? 16 : 0)
            .overlay (
                VStack {
                    if boxed {
                        RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).foregroundColor(hasError ? .sbbColor(.red) : .clear)
                    } else {
                        EmptyView()
                    }
                } , alignment: .center)
            .animation(.linear)
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
        
        if let additionalAccessibilityText = additionalAccessibilityText {
            text.append("\(additionalAccessibilityText). ")
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
                SBBTextField(text: .constant("Text"), label: "Placeholder", icon: Image(sbbIcon: .route_circle_start_small))
                    .previewDisplayName("Light with Icon")
                SBBTextField(text: .constant(""), label: "Placeholder")
                    .previewDisplayName("Dark empty")
                    .environment(\.colorScheme, .dark)
                SBBTextField(text: .constant("Text"), label: "Placeholder")
                    .previewDisplayName("Dark with text")
                    .environment(\.colorScheme, .dark)
                SBBTextField(text: .constant("Text"), label: "Placeholder", icon: Image(sbbIcon: .route_circle_start_small))
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
                SBBTextField(text: .constant("Text"), label: "Placeholder", error: "Error", icon: Image(sbbIcon: .route_circle_start_small))
                    .previewDisplayName("Light with Icon, error")
                SBBTextField(text: .constant(""), label: "Placeholder", error: "Error")
                    .previewDisplayName("Dark empty, error")
                    .environment(\.colorScheme, .dark)
                SBBTextField(text: .constant("Text"), label: "Placeholder", error: "Error")
                    .previewDisplayName("Dark with text, error")
                    .environment(\.colorScheme, .dark)
                SBBTextField(text: .constant("Text"), label: "Placeholder", error: "Error", icon: Image(sbbIcon: .route_circle_start_small))
                    .previewDisplayName("Dark with Icon, error")
                    .environment(\.colorScheme, .dark)
            }
        }
            .previewLayout(.sizeThatFits)
    }
}
