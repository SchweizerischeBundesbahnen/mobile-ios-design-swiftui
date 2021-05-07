//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public extension SBBCheckBox where Content == EmptyView {
    init(isOn: Binding<Bool>, image: Image? = nil, label: String, showBottomLine: Bool = true) {
        self._isOn = isOn
        self.checkboxAndRadioButtonContainer = CheckBoxAndRadioButtonContainer(type: .checkbox, isOn: isOn, image: image, label: label, showBottomLine: showBottomLine)
    }
}

public struct SBBCheckBox<Content>: View where Content: View {
    
    @Environment(\.isEnabled) private var isEnabled
    @Binding private var isOn: Bool
    
    private var checkboxAndRadioButtonContainer: CheckBoxAndRadioButtonContainer<Content>
    
    public init(isOn: Binding<Bool>, showBottomLine: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self._isOn = isOn
        self.checkboxAndRadioButtonContainer = CheckBoxAndRadioButtonContainer(type: .checkbox, isOn: isOn, showBottomLine: showBottomLine, content: content)
    }
    
    public var body: some View {
        checkboxAndRadioButtonContainer
    }
}

struct SBBCheckBox_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBCheckBox(isOn: .constant(true), label: "Label")
                .previewDisplayName("Light, text only")
            SBBCheckBox(isOn: .constant(true), label: "Label")
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark, text only")
            SBBCheckBox(isOn: .constant(false), image: Image(sbbName: "alarm-clock", size: .small), label: "Label")
                .previewDisplayName("Light, with image")
            SBBCheckBox(isOn: .constant(true), image: Image(sbbName: "alarm-clock", size: .small), label: "Label")
                .disabled(true)
                .previewDisplayName("Light, disabled")
            SBBCheckBox(isOn: .constant(true)) {
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
