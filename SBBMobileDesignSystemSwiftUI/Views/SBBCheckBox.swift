//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public extension SBBCheckBox where Content == EmptyView {
    init(isOn: Binding<Bool>, image: Image? = nil, label: Text, showTextFieldLine: Bool = true) {
        self._isOn = isOn
        self.image = image
        self.label = label
        self.showTextFieldLine = showTextFieldLine
        self.content = nil
    }
}

public struct SBBCheckBox<Content>: View where Content: View {
    
    @Environment(\.isEnabled) private var isEnabled
    @Binding private var isOn: Bool
    private var image: Image?
    private var label: Text?
    private let content: Content?
    private let showTextFieldLine: Bool
    
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
    
    public init(isOn: Binding<Bool>, showTextFieldLine: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self._isOn = isOn
        self.image = nil
        self.label = nil
        self.showTextFieldLine = showTextFieldLine
        self.content = content()
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            HStack(alignment: .top, spacing: 8) {
                icon
                    .accessibility(hidden: true)
                if image != nil {
                    image!
                        .resizeToContentSizeCategory(originalHeight: 24)
                        .accessibility(hidden: true)
                }
                if label != nil {
                    label!
                        .sbbFont(.body)
                        .padding(.top, 2)
                        .fixedSize(horizontal: false, vertical: true)
                }
                if content != nil {
                    content!
                }
                Spacer()
            }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
            if showTextFieldLine {
                Rectangle()
                    .fill(SBBColor.textfieldLineInactive)
                    .frame(height: 1)
                    .padding(.leading, 16)
            }
        }
            .background(Color.clear)
            .onTapGesture {
                self.isOn.toggle()
            }
            .accessibilityElement(children: .combine)
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
            SBBCheckBox(isOn: .constant(true), label: Text("Label"))
                .previewDisplayName("Light, text only")
            SBBCheckBox(isOn: .constant(true), label: Text("Label"))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark, text only")
            SBBCheckBox(isOn: .constant(false), image: Image(sbbName: "alarm-clock", size: .small), label: Text("Label"))
                .previewDisplayName("Light, with image")
            SBBCheckBox(isOn: .constant(true), image: Image(sbbName: "alarm-clock", size: .small), label: Text("Label"))
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
