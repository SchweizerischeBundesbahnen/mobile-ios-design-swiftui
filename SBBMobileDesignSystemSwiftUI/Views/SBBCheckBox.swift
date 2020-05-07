//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBCheckBox: View {
    
    @Environment(\.isEnabled) private var isEnabled
    @Binding private var isOn: Bool
    private var label: LocalizedStringKey?
    
    private var icon: Image {
        switch (isOn, isEnabled) {
        case (true, true):
            return Image("Checked", bundle: Helper.bundle)
        case (true, false):
            return Image("Checked_disabled", bundle: Helper.bundle)
        case (false, true):
            return Image("Unchecked", bundle: Helper.bundle)
        case (false, false):
            return Image("Unchecked_disabled", bundle: Helper.bundle)
        }
    }
    
    public init(isOn: Binding<Bool>, label: String? = nil) {
        self._isOn = isOn
        if let label = label {
            self.label = LocalizedStringKey(label)
        } else {
            self.label = nil
        }
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            icon
            if label != nil {
                Text(label!)
                    .sbbFont(.body)
                    .foregroundColor(isEnabled ? SBBColor.textBlack : SBBColor.textMetal)
                    .padding(.trailing, 16)
                Spacer()
            }
        }
        .frame(minHeight: label != nil ? 48 : 0)
        .background((label != nil ? SBBColor.textfieldLineInactive : Color.clear).frame(height: 1), alignment: .bottom)
        .padding(.leading, label != nil ? 16 : 0)
        .onTapGesture {
            self.isOn.toggle()
        }
        .accessibilityElement(children: .ignore)
        .accessibility(label: label != nil ? Text(label!) : Text(""))
        .accessibility(addTraits: .isButton)
        .accessibility(value: isOn ? Text("\("ON".localized)") : Text("\("OFF".localized)"))
        .accessibilityAction {
            self.isOn.toggle()
        }
    }
}

struct SBBCheckBox_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBCheckBox(isOn: .constant(true))
                .previewDisplayName("Light on")
            SBBCheckBox(isOn: .constant(false))
                .previewDisplayName("Light off")
            SBBCheckBox(isOn: .constant(true), label: "Label")
                .previewDisplayName("Light with label")
            SBBCheckBox(isOn: .constant(true))
                .previewDisplayName("Dark on")
                .environment(\.colorScheme, .dark)
            SBBCheckBox(isOn: .constant(false))
                .previewDisplayName("Dark off")
                .environment(\.colorScheme, .dark)
            SBBCheckBox(isOn: .constant(true), label: "Label")
                .previewDisplayName("Dark with Label")
                .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
