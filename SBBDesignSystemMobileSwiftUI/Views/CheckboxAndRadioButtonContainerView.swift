//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

struct CheckBoxAndRadioButtonContainer: View {
    
    private let type: CheckBoxAndRadioButtonContainerType
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.colorScheme) var colorScheme
    @Binding private var isOn: Bool
    private var image: Image?
    private var text: Text
    private var subText: Text?
    private let showBottomLine: Bool
    
    private var foregroundColor: Color {
        switch (isEnabled, colorScheme) {
        case (true, _):
            return .sbbColor(.textBlack)
        case (false, .light):
            return .sbbColor(.metal)
        case (false, .dark):
            return .sbbColor(.smoke)
        default:
            return .sbbColor(.textBlack)
        }
    }
    
    private var checkmarkColor: Color {
        switch (isOn, isEnabled) {
        case (false, _):
            return .clear
        case (true, true):
            return .sbbColor(.primary)
        case (true, false):
            return  (colorScheme == .light) ? Color.sbbColor(.metal) : Color.sbbColor(.smoke)
        }
    }
    
    private var checkboxBorderColor: Color {
        switch (isEnabled, colorScheme) {
        case (true, .light):
            return .sbbColor(.metal)
        case (true, .dark):
            return .sbbColor(.smoke)
        case (false, .light):
            return .sbbColor(.cloud)
        case (false, .dark):
            return .sbbColor(.iron)
        default:
            return .sbbColor(.metal)
        }
    }
    
    init(type: CheckBoxAndRadioButtonContainerType, isOn: Binding<Bool>, image: Image? = nil, text: Text, subText: Text? = nil, showBottomLine: Bool = true) {
        self.type = type
        self._isOn = isOn
        self.image = image
        self.text = text
        self.subText = subText
        self.showBottomLine = showBottomLine
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack(alignment: .top, spacing: 8) {
                if type == .checkbox {
                    RoundedRectangle(cornerRadius: 6)
                        .strokeBorder(checkboxBorderColor, lineWidth: 1)
                        .background(RoundedRectangle(cornerRadius: 6).fill((colorScheme == .light) ? Color.sbbColor(.white) : .clear))
                        .frame(width: 20, height: 20)
                        .overlay(
                            Image("checkbox_selected", bundle: Helper.bundle)
                                .foregroundColor(checkmarkColor)
                        )
                } else if type == .radioButton {
                    Circle()
                        .strokeBorder(checkboxBorderColor, lineWidth: 1)
                        .background(Circle().fill((colorScheme == .light) ? Color.sbbColor(.white) : .clear))
                        .frame(width: 20, height: 20)
                        .overlay(
                            Circle()
                                .fill(checkmarkColor)
                                .frame(width: 8, height: 8)
                        )
                }
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .top, spacing: 8) {
                        if let image = image {
                            image
                                .resizeToContentSizeCategory(originalHeight: 24)
                                .accessibility(hidden: true)
                        }
                        text
                            .sbbFont(.medium_light)
                            .padding(.top, 2)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                    }
                    if let subText = subText {
                        subText
                            .sbbFont(.small_light)
                            .padding(.top, 2)
                            .foregroundColor(.sbbColor(colorScheme == .dark ? .cement : .granite))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
            if showBottomLine {
                Rectangle()
                    .fill(Color.sbbColorInternal(.textfieldLineInactive))
                    .frame(height: 1)
                    .padding(.leading, 16)
            }
        }
            .foregroundColor(foregroundColor)
            .background(Color.clear)
            .contentShape(Rectangle())  // make the entire SBBRadioButon tappable (Spacers are ignored by default)
            .onTapGesture {
                withAnimation {
                    self.isOn.toggle()
                }
            }
            .accessibilityElement(children: .combine)
            .accessibility(addTraits: .isButton)
            .accessibility(value: isOn ? Text("\("ON".localized)") : Text("\("OFF".localized)"))
    }
}

struct CheckBoxAndRadioButtonContainer_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                CheckBoxAndRadioButtonContainer(type: .checkbox, isOn: .constant(true), text: Text("text"))
                    .previewDisplayName("Light, text only")
                CheckBoxAndRadioButtonContainer(type: .checkbox, isOn: .constant(true), text: Text("text"))
                    .environment(\.colorScheme, .dark)
                    .previewDisplayName("Dark, text only")
                CheckBoxAndRadioButtonContainer(type: .checkbox, isOn: .constant(false), image: Image(sbbIcon: .alarm_clock_small), text: Text("text"))
                    .previewDisplayName("Light, with image")
                CheckBoxAndRadioButtonContainer(type: .checkbox, isOn: .constant(true), image: Image(sbbIcon: .alarm_clock_small), text: Text("text"))
                    .disabled(true)
                    .previewDisplayName("Light, disabled")
                CheckBoxAndRadioButtonContainer(type: .checkbox, isOn: .constant(true), text: Text("Ich möchte der SBB Informationen zum verwendeten Gerät übermitteln."), subText: Text("Modell: iPhone 11 Pro\niOS Version: 14.0"))
                    .previewDisplayName("Light, custom content")
            }
            Group {
                CheckBoxAndRadioButtonContainer(type: .radioButton, isOn: .constant(true), text: Text("text"))
                    .previewDisplayName("Light, text only")
                CheckBoxAndRadioButtonContainer(type: .radioButton, isOn: .constant(true), text: Text("text"))
                    .environment(\.colorScheme, .dark)
                    .previewDisplayName("Dark, text only")
                CheckBoxAndRadioButtonContainer(type: .radioButton, isOn: .constant(false), image: Image(sbbIcon: .alarm_clock_small), text: Text("text"))
                    .previewDisplayName("Light, with image")
                CheckBoxAndRadioButtonContainer(type: .radioButton, isOn: .constant(true), image: Image(sbbIcon: .alarm_clock_small), text: Text("text"))
                    .disabled(true)
                    .previewDisplayName("Light, disabled")
                CheckBoxAndRadioButtonContainer(type: .radioButton, isOn: .constant(true), text: Text("Ich möchte der SBB Informationen zum verwendeten Gerät übermitteln."), subText: Text("Modell: iPhone 11 Pro\niOS Version: 14.0"))

                    .previewDisplayName("Light, custom content")
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
