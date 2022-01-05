//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/**
 A  View that is used for entering text (multiple lines).
 
 ## Overview
 You create a SBBTextArea  by providing a binding to inputText, and a static placeholder label:
 ```swift
 @State var input = "I like trains"

 var body: some View {
    SBBTextArea(text: $input, label: "Placeholder")
 }
 ```
 ![SBBTextArea](SBBTextArea)
 */
public struct SBBTextArea: View {
    
    @Binding private var text: String
    @State private var isEditing = false
    private var label: String?
    private var localizedLabel: LocalizedStringKey?
    private let showBottomLine: Bool
    
    /**
     Returns a SBBTextArea with a label and an optional Image.
     
     - Parameters:
        - text: Sets the user-modifiable text state.
        - label: An optional label displayed instead of the text (if the text is empty) or above the text (if not empty).
        - showBottomLine: Shows or hides a separator line at the bottom of the View (typically only false for last elements in a List).
     */
    public init(text: Binding<String>, label: String? = nil, showBottomLine: Bool = true) {
        self._text = text
        self.label = label
        if let label = label {
            self.localizedLabel = LocalizedStringKey(label)
        } else {
            self.localizedLabel = nil
        }
        self.showBottomLine = showBottomLine
    }
    
    private var bottomLineColor: Color {
        switch (isEditing, showBottomLine) {
        case (true, _):
            return .sbbColor(.textBlack)
        case (_, true):
            return .sbbColorInternal(.textfieldLineInactive)
        default:
            return Color.clear
        }
    }
    
    public var body: some View {
        SBBTextAreaImpl(text: $text, isEditing: $isEditing, label: label)
            .background(bottomLineColor.frame(height: 1).padding(.horizontal, 17.5), alignment: .bottom)
            .accessibilityElement(children: .ignore)
            .accessibility(label: localizedLabel != nil ? Text(localizedLabel!) : Text(text))
            .accessibility(label: localizedLabel != nil ? Text(localizedLabel!) : Text(text))

            .accessibility(value: localizedLabel != nil ? Text(text) : Text(""))
    }
    
    private struct SBBTextAreaImpl: UIViewRepresentable {
        
        @Binding private var text: String
        @Binding private var isEditing: Bool
        private var label: String?
        private let descriptionLabel = UILabel()
        private let placeholderLabel = UILabel()
        
        init(text: Binding<String>, isEditing: Binding<Bool>, label: String?) {
            self._text = text
            self._isEditing = isEditing
            self.label = label
        }
        
        func makeUIView(context: Context) -> UITextView {
            let view = UITextView()
            view.delegate = context.coordinator
            
            let scaledFontSize = UIFontMetrics.default.scaledValue(for: 16)
            view.font = UIFont(name: "SBBWeb-Light", size: scaledFontSize)
            view.textContainerInset = UIEdgeInsets(top: 17, left: 11, bottom: 16, right: 11)
            view.backgroundColor = UIColor.clear
            let placeholderScaledFontSize = UIFontMetrics.default.scaledValue(for: 10)
            view.textContainerInset = UIEdgeInsets(top: placeholderScaledFontSize + 7, left: 11, bottom: 16, right: 11)
            
            if let placeholder = label {
                descriptionLabel.text = NSLocalizedString(placeholder, comment: "")
            }
            let descriptionScaledFontSize = UIFontMetrics.default.scaledValue(for: 10)
            descriptionLabel.font = UIFont(name: "SBBWeb-Light", size: descriptionScaledFontSize)
            descriptionLabel.textColor = UIColor(named: "placeholder", in: Helper.bundle, compatibleWith: nil)
            view.addSubview(descriptionLabel)
            
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            let descriptionTopConstraint = descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5)
            let descriptionLeadingConstraint = descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17)
            let descriptionTrailingConstraint = descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            view.addConstraints([descriptionTopConstraint, descriptionLeadingConstraint, descriptionTrailingConstraint])
            
            if let placeholder = label {
                placeholderLabel.text = NSLocalizedString(placeholder, comment: "")
            }
            placeholderLabel.font = UIFont(name: "SBBWeb-Light", size: scaledFontSize)
            placeholderLabel.textColor = UIColor(named: "placeholder", in: Helper.bundle, compatibleWith: nil)
            view.addSubview(placeholderLabel)
            
            placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
            let topConstraint = placeholderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 17.5)
            let leadingConstraint = placeholderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
            let trailingConstraint = placeholderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            view.addConstraints([topConstraint, leadingConstraint, trailingConstraint])
            
            let hasContent = !text.isEmpty
            descriptionLabel.isHidden = !hasContent
            placeholderLabel.isHidden = hasContent
            
            return view
        }
        
        func updateUIView(_ uiView: UITextView, context: Context) {
            uiView.text = text
            context.coordinator.updatePlaceholder(for: uiView)
            
            if context.environment.isEnabled {
                uiView.textColor = UIColor(named: "textBlack", in: Helper.bundle, compatibleWith: nil)
            } else {
                uiView.textColor = UIColor(named: "Metal", in: Helper.bundle, compatibleWith: nil)
            }
        }
        
        func makeCoordinator() -> TextAreaCoordinator {
            return TextAreaCoordinator(self)
        }
        
        class TextAreaCoordinator: NSObject, UITextViewDelegate {
            
            private let parent: SBBTextAreaImpl
            
            init(_ parent: SBBTextAreaImpl) {
                self.parent = parent
            }
            
            func textViewDidChange(_ textView: UITextView) {
                parent.text = textView.text
                updatePlaceholder(for: textView)
            }
            
            func updatePlaceholder(for textView: UITextView) {
                let hasContent = !textView.text.isEmpty
                parent.descriptionLabel.isHidden = !hasContent
                parent.placeholderLabel.isHidden = hasContent
            }
            
            func textViewDidBeginEditing(_ textView: UITextView) {
                DispatchQueue.main.async {
                    self.parent.isEditing = true
                }
            }
            
            func textViewDidEndEditing(_ textView: UITextView) {
                DispatchQueue.main.async {
                    self.parent.isEditing = false
                }
            }
        }
    }
}

struct SBBTextArea_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBTextArea(text: .constant(""), label: "Placeholder")
                .previewDisplayName("Light")
            SBBTextArea(text: .constant(""), label: "Placeholder")
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}
