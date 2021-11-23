//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/// A  View that is used to offer a yes/no selection for one or multiple unrelated options.
public struct SBBCheckBox: View {
    
    @Environment(\.isEnabled) private var isEnabled
    @Binding private var isOn: Bool
    
    private var checkboxAndRadioButtonContainer: CheckBoxAndRadioButtonContainer
        
    /**
     Returns a SBBCheckBox with a Text, an optional subText and an optional Image.
     
     - Parameters:
        - isOn: Sets the selected/unselected state of theSBBCheckBox.
        - image: An optional Image to be shown on the left side of the text.
        - text: The Text to be shown on the right side of the checkbox Image.
        - subText: The subText to be shown below the standard text.
        - showBottomLine: Shows or hides a separator line at the bottom of the View (typically only false for last elements in a List).
     */
    public init(isOn: Binding<Bool>, image: Image? = nil, text: Text, subText: Text? = nil, showBottomLine: Bool = true) {
        self._isOn = isOn
        self.checkboxAndRadioButtonContainer = CheckBoxAndRadioButtonContainer(type: .checkbox, isOn: isOn, image: image, text: text, subText: subText, showBottomLine: showBottomLine)
    }
    
    public var body: some View {
        checkboxAndRadioButtonContainer
    }
}

struct SBBCheckBox_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBCheckBox(isOn: .constant(true), text: Text("Text"))
                .previewDisplayName("Light, text only")
            SBBCheckBox(isOn: .constant(true), text: Text("Text"))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark, text only")
            SBBCheckBox(isOn: .constant(false), image: Image(sbbName: "alarm-clock", size: .small), text: Text("Text"))
                .previewDisplayName("Light, with image")
            SBBCheckBox(isOn: .constant(true), image: Image(sbbName: "alarm-clock", size: .small), text: Text("Text"))
                .disabled(true)
                .previewDisplayName("Light, disabled")
            SBBCheckBox(isOn: .constant(true), text: Text("Text"), subText: Text("Modell: iPhone 11 Pro\niOS Version: 14.0"))
                .previewDisplayName("Light, subText")
        }
        .previewLayout(.sizeThatFits)
    }
}
