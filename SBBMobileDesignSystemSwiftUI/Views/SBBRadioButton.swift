//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

/**
 Returns a SBBRadioButton with a label and an optional Image.
 
 - Parameters:
    - isOn: Sets the selected/unselected state of theSBBCheckBox.
    - image: An optional Image to be shown on the left SBBRadioButton of the label.
    - label: The label to be shown on the right side of the radioButton Image.
    - showBottomLine: Shows or hides a separator line at the bottom of the View (typically only false for last elements in a List).
 */
public extension SBBRadioButton where Content == EmptyView {
    init(isOn: Binding<Bool>, image: Image? = nil, label: String, showBottomLine: Bool = true) {
        self._isOn = isOn
        self.checkboxAndRadioButtonContainer = CheckBoxAndRadioButtonContainer(type: .radioButton, isOn: isOn, image: image, label: label, showBottomLine: showBottomLine)
    }
}

/// A  View that is used to offer a single selection out of multiple options.
public struct SBBRadioButton<Content>: View where Content: View {
    
    @Environment(\.isEnabled) private var isEnabled
    @Binding private var isOn: Bool
    
    private var checkboxAndRadioButtonContainer: CheckBoxAndRadioButtonContainer<Content>
    
    /**
     Returns a SBBRadioButton with custom content.
     
     - Parameters:
        - isOn: Sets the selected/unselected state of SBBRadioButton.
        - showBottomLine: Shows or hides a separator line at the bottom of the View (typically only false for last elements in a List).
        - content: A custom View to be shown on the right side of the radioButton Image.
     */
    public init(isOn: Binding<Bool>, showBottomLine: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self._isOn = isOn
        self.checkboxAndRadioButtonContainer = CheckBoxAndRadioButtonContainer(type: .radioButton, isOn: isOn, showBottomLine: showBottomLine, content: content)
    }
    
    public var body: some View {
        checkboxAndRadioButtonContainer
    }
}

struct SBBRadioButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBRadioButton(isOn: .constant(true), label: "Label")
                .previewDisplayName("Light, text only")
            SBBRadioButton(isOn: .constant(true), label: "Label")
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark, text only")
            SBBRadioButton(isOn: .constant(false), image: Image(sbbName: "alarm-clock", size: .small), label: "Label")
                .previewDisplayName("Light, with image")
            SBBRadioButton(isOn: .constant(true), image: Image(sbbName: "alarm-clock", size: .small), label: "Label")
                .disabled(true)
                .previewDisplayName("Light, disabled")
            SBBRadioButton(isOn: .constant(true)) {
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
