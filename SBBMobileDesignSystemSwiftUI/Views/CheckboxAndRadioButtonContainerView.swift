//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

extension CheckBoxAndRadioButtonContainer where Content == EmptyView {
    init(type: CheckBoxAndRadioButtonContainerType, isOn: Binding<Bool>, image: Image? = nil, label: String, showBottomLine: Bool = true) {
        self.type = type
        self._isOn = isOn
        self.image = image
        self.label = LocalizedStringKey(label)
        self.showBottomLine = showBottomLine
        self.content = nil
    }
}

struct CheckBoxAndRadioButtonContainer<Content>: View where Content: View {
    
    private let type: CheckBoxAndRadioButtonContainerType
    @Environment(\.isEnabled) private var isEnabled
    @Binding private var isOn: Bool
    private var image: Image?
    private var label: LocalizedStringKey?
    private let content: Content?
    private let showBottomLine: Bool
    
    init(type: CheckBoxAndRadioButtonContainerType, isOn: Binding<Bool>, showBottomLine: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.type = type
        self._isOn = isOn
        self.image = nil
        self.label = nil
        self.showBottomLine = showBottomLine
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack(alignment: .top, spacing: 8) {
                if isOn {
                    Image("\(type.iconPrefix)_Checked\(isEnabled ? "" : "_disabled")", bundle: Helper.bundle)
                        .accessibility(hidden: true)
                } else {
                    Image("\(type.iconPrefix)_Unchecked\(isEnabled ? "" : "_disabled")", bundle: Helper.bundle)
                        .accessibility(hidden: true)
                }
                if let image = image {
                    image
                        .resizeToContentSizeCategory(originalHeight: 24)
                        .accessibility(hidden: true)
                }
                if let label = label {
                    Text(label)
                        .sbbFont(.body)
                        .padding(.top, 2)
                        .fixedSize(horizontal: false, vertical: true)
                }
                if let content = content {
                    content
                }
                Spacer()
            }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
            if showBottomLine {
                Rectangle()
                    .fill(Color.sbbColorInternal(.textfieldLineInactive))
                    .frame(height: 1)
                    .padding(.leading, 16)
            }
        }
            .foregroundColor(isEnabled ? Color.sbbColor(.textBlack) : Color.sbbColor(.metal))
            .background(Color.clear)
            .onTapGesture {
                withAnimation {
                    self.isOn.toggle()
                }
            }
            .accessibilityElement(children: .combine)
            .accessibility(addTraits: .isButton)
            .accessibility(value: isOn ? Text("\("ON".localized)") : Text("\("OFF".localized)"))
            .accessibilityAction {
                self.isOn.toggle()
            }
    }
}

struct CheckBoxAndRadioButtonContainer_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                CheckBoxAndRadioButtonContainer(type: .checkbox, isOn: .constant(true), label: "Label")
                    .previewDisplayName("Light, text only")
                CheckBoxAndRadioButtonContainer(type: .checkbox, isOn: .constant(true), label: "Label")
                    .environment(\.colorScheme, .dark)
                    .previewDisplayName("Dark, text only")
                CheckBoxAndRadioButtonContainer(type: .checkbox, isOn: .constant(false), image: Image(sbbName: "alarm-clock", size: .small), label: "Label")
                    .previewDisplayName("Light, with image")
                CheckBoxAndRadioButtonContainer(type: .checkbox, isOn: .constant(true), image: Image(sbbName: "alarm-clock", size: .small), label: "Label")
                    .disabled(true)
                    .previewDisplayName("Light, disabled")
                CheckBoxAndRadioButtonContainer(type: .checkbox, isOn: .constant(true)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ich möchte der SBB Informationen zum verwendeten Gerät übermitteln.")
                            .sbbFont(.body)
                        Text("Modell: iPhone 11 Pro\niOS Version: 14.0")
                            .sbbFont((.legend))
                    }
                }
                    .previewDisplayName("Light, custom content")
            }
            Group {
                CheckBoxAndRadioButtonContainer(type: .radioButton, isOn: .constant(true), label: "Label")
                    .previewDisplayName("Light, text only")
                CheckBoxAndRadioButtonContainer(type: .radioButton, isOn: .constant(true), label: "Label")
                    .environment(\.colorScheme, .dark)
                    .previewDisplayName("Dark, text only")
                CheckBoxAndRadioButtonContainer(type: .radioButton, isOn: .constant(false), image: Image(sbbName: "alarm-clock", size: .small), label: "Label")
                    .previewDisplayName("Light, with image")
                CheckBoxAndRadioButtonContainer(type: .radioButton, isOn: .constant(true), image: Image(sbbName: "alarm-clock", size: .small), label: "Label")
                    .disabled(true)
                    .previewDisplayName("Light, disabled")
                CheckBoxAndRadioButtonContainer(type: .radioButton, isOn: .constant(true)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ich möchte der SBB Informationen zum verwendeten Gerät übermitteln.")
                            .sbbFont(.body)
                        Text("Modell: iPhone 11 Pro\niOS Version: 14.0")
                            .sbbFont((.legend))
                    }
                }
                    .previewDisplayName("Light, custom content")
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
