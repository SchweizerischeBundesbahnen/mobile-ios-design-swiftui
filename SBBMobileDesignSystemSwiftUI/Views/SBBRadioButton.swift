//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension SBBRadioButton where Content == EmptyView {
    init(isOn: Binding<Bool>, image: Image? = nil, label: String, showTextFieldLine: Bool = true) {
        self._isOn = isOn
        self.checkboxAndRadioButtonContainer = CheckBoxAndRadioButtonContainer(type: .radioButton, isOn: isOn, image: image, label: label, showTextFieldLine: showTextFieldLine)
    }
}

public struct SBBRadioButton<Content>: View where Content: View {
    
    @Environment(\.isEnabled) private var isEnabled
    @Binding private var isOn: Bool
    
    private var checkboxAndRadioButtonContainer: CheckBoxAndRadioButtonContainer<Content>
    
    public init(isOn: Binding<Bool>, showTextFieldLine: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self._isOn = isOn
        self.checkboxAndRadioButtonContainer = CheckBoxAndRadioButtonContainer(type: .radioButton, isOn: isOn, showTextFieldLine: showTextFieldLine, content: content)
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
