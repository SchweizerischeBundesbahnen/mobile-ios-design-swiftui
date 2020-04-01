//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBTextArea: UIViewRepresentable {
    
    @Binding private var text: String
    private var placeholder: String?
    
    private let descriptionLabel = UILabel()
    private let placeholderLabel = UILabel()
    
    public init(text: Binding<String>, placeholder: String? = nil) {
        self._text = text
        self.placeholder = placeholder
    }
    
    public func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        
        let scaledFontSize = UIFontMetrics.default.scaledValue(for: 16)
        view.font = UIFont(name: "SBBWeb-Light", size: scaledFontSize)
        view.textContainerInset = UIEdgeInsets(top: 17, left: 11, bottom: 16, right: 11)
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor(named: "controlBackground", in: Helper.bundle, compatibleWith: nil)
        
        descriptionLabel.text = placeholder
        let descriptionScaledFontSize = UIFontMetrics.default.scaledValue(for: 10)
        descriptionLabel.font = UIFont(name: "SBBWeb-Light", size: descriptionScaledFontSize)
        descriptionLabel.textColor = UIColor(named: "textMetal", in: Helper.bundle, compatibleWith: nil)
        view.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let descriptionTopConstraint = descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5)
        let descriptionLeadingConstraint = descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17)
        let descriptionTrailingConstraint = descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        view.addConstraints([descriptionTopConstraint, descriptionLeadingConstraint, descriptionTrailingConstraint])
        
        placeholderLabel.text = placeholder
        placeholderLabel.font = UIFont(name: "SBBWeb-Light", size: scaledFontSize)
        placeholderLabel.textColor = UIColor(named: "textMetal", in: Helper.bundle, compatibleWith: nil)
        view.addSubview(placeholderLabel)
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = placeholderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 17.5)
        let leadingConstraint = placeholderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        let trailingConstraint = placeholderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        view.addConstraints([topConstraint, leadingConstraint, trailingConstraint])
        
        return view
    }

    public func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        
        let placeholderScaledFontSize = UIFontMetrics.default.scaledValue(for: 10)
        uiView.textContainerInset = UIEdgeInsets(top: placeholderScaledFontSize + 7, left: 11, bottom: 16, right: 11)
    }
}
