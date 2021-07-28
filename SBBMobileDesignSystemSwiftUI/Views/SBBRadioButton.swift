//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension SBBRadioButton where Content == EmptyView {
    
    /**
     Returns a SBBRadioButton with a label and an optional Image. SBBRadioButton is typically used inside a SBBRadioButtonGroup, which handles all events on it's own. If you want to use it outside of a SBBRadioButtonGroup you need to set it's selected state and handle touch events. To set its selected state use the isSelected(_ isSelected: Bool) ViewModifier. To handle touch events, use the .highPriorityGesture() ViewModifier.
     
     - Parameters:
        - image: An optional Image to be shown on the left SBBRadioButton of the label.
        - label: The label to be shown on the right side of the radioButton Image.
        - showBottomLine: Shows or hides a separator line at the bottom of the View (typically only false for last elements in a List).
     */
    init(image: Image? = nil, label: String, showBottomLine: Bool = true) {
        self.image = image
        self.label = label
        self.showBottomLine = showBottomLine
        self.content = nil
    }
}

/// A  View that is used to offer a single selection out of multiple options.
public struct SBBRadioButton<Content>: View where Content: View {
    
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.isSelected) private var isOn
    
    private var image: Image?
    private var label: String?
    private var showBottomLine: Bool
    private var content: (() -> Content)?
    
    /**
     Returns a SBBRadioButton with custom content. SBBRadioButton is typically used inside a SBBRadioButtonGroup, which handles all events on it's own. If you want to use it outside of a SBBRadioButtonGroup you need to set it's selected state and handle touch events. To set its selected state use the isSelected(_ isSelected: Bool) ViewModifier. To handle touch events, use the .highPriorityGesture() ViewModifier.
     
     - Parameters:
        - showBottomLine: Shows or hides a separator line at the bottom of the View (typically only false for last elements in a List).
        - content: A custom View to be shown on the right side of the radioButton Image.
     */
    public init(showBottomLine: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.image = nil
        self.label = nil
        self.showBottomLine = showBottomLine
        self.content = content
    }
    
    public var body: some View {
        if let content = content {
            CheckBoxAndRadioButtonContainer(type: .radioButton, isOn: .constant(isOn), showBottomLine: showBottomLine, content: content)
        } else if let label = label {
            CheckBoxAndRadioButtonContainer(type: .radioButton, isOn: .constant(isOn), image: image, label: label, showBottomLine: showBottomLine)
        }
    }
}

struct SBBRadioButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBRadioButton(label: "Label")
                .previewDisplayName("Light, text only")
            SBBRadioButton(label: "Label")
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark, text only")
            SBBRadioButton(image: Image(sbbName: "alarm-clock", size: .small), label: "Label")
                .previewDisplayName("Light, with image")
            SBBRadioButton(image: Image(sbbName: "alarm-clock", size: .small), label: "Label")
                .disabled(true)
                .previewDisplayName("Light, disabled")
            SBBRadioButton() {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Ich möchte der SBB Informationen zum verwendeten Gerät übermitteln.")
                        .sbbFont(.body)
                    Text("Modell: iPhone 11 Pro\niOS Version: 14.0")
                        .sbbFont((.legend))
                }
            }
                .previewDisplayName("Light, custom content")
        }
        .previewLayout(.sizeThatFits)
    }
}
