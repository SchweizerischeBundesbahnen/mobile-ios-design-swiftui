//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBTextArea: UIViewRepresentable {
    
    @Binding private var text: String
    private var label: String?
    
    let descriptionLabel = UILabel()
    let placeholderLabel = UILabel()
    
    public init(text: Binding<String>, label: String? = nil) {
        self._text = text
        self.label = label
    }
    
    public func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.delegate = context.coordinator
                        
        let scaledFontSize = UIFontMetrics.default.scaledValue(for: 16)
        view.font = UIFont(name: "SBBWeb-Light", size: scaledFontSize)
        view.textContainerInset = UIEdgeInsets(top: 17, left: 11, bottom: 16, right: 11)
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor(named: "viewBackground", in: Helper.bundle, compatibleWith: nil)
        let placeholderScaledFontSize = UIFontMetrics.default.scaledValue(for: 10)
        view.textContainerInset = UIEdgeInsets(top: placeholderScaledFontSize + 7, left: 11, bottom: 16, right: 11)
        
        if let placeholder = label {
            descriptionLabel.text = NSLocalizedString(placeholder, comment: "")
            view.accessibilityLabel = placeholder
            view.accessibilityValue = text
        }
        let descriptionScaledFontSize = UIFontMetrics.default.scaledValue(for: 10)
        descriptionLabel.font = UIFont(name: "SBBWeb-Light", size: descriptionScaledFontSize)
        descriptionLabel.textColor = UIColor(named: "textMetal", in: Helper.bundle, compatibleWith: nil)
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
        placeholderLabel.textColor = UIColor(named: "textMetal", in: Helper.bundle, compatibleWith: nil)
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

    public func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        context.coordinator.updatePlaceholder(for: uiView)
        
        if context.environment.isEnabled {
            uiView.textColor = UIColor(named: "textBlack", in: Helper.bundle, compatibleWith: nil)
        } else {
            uiView.textColor = UIColor(named: "textMetal", in: Helper.bundle, compatibleWith: nil)
        }
    }
    
    public func makeCoordinator() -> TextAreaCoordinator {
        return TextAreaCoordinator(self)
    }
    
    public class TextAreaCoordinator: NSObject, UITextViewDelegate {
        
        private let parent: SBBTextArea
        
        public init(_ parent: SBBTextArea) {
            self.parent = parent
        }
    
        public func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            updatePlaceholder(for: textView)
        }
        
        public func updatePlaceholder(for textView: UITextView) {
            let hasContent = !textView.text.isEmpty
            parent.descriptionLabel.isHidden = !hasContent
            parent.placeholderLabel.isHidden = hasContent
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
    }
}
