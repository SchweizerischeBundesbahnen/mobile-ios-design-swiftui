//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

/**
 A View that is used to offer a single selection out of multiple options.
 
 ## Overview
 You create a SBBRadioButton by providing a Text. You can optionally also provide an image and a subText:
 ```swift
 @State private var isSelected = false

 var body: some View {
    SBBRadioButton(image: Image(sbbName: "alarm-clock", size: .small), text: Text("Text"), subText: subText: Text("SubText"))
        .isSelected(isSelected)
 }
 ```
 You will usually want to group corresponding SBBRadioButtons inside a ``SBBRadioButtonGroup``. Otherwise you can use the .isSelected(Bool) ViewModifier to specify it's state.
 
 ![SBBRadioButton](SBBRadioButton)
 */
public struct SBBRadioButton: View {
    
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.isSelected) private var isOn
    
    private var image: Image?
    private var text: Text
    private var subText: Text?
    private var showBottomLine: Bool
    
    /**
     Returns a SBBRadioButton with a Text, an optional subText and an optional Image. SBBRadioButton is typically used inside a SBBRadioButtonGroup, which handles all events on it's own. If you want to use it outside of a SBBRadioButtonGroup you need to set it's selected state and handle touch events. To set its selected state use the isSelected(_ isSelected: Bool) ViewModifier. To handle touch events, use the .highPriorityGesture() ViewModifier.
     
     - Parameters:
        - image: An optional Image to be shown on the left SBBRadioButton of the text.
        - text: The text to be shown on the right side of the radioButton Image.
        - subText: The subText to be shown below the standard text.
        - showBottomLine: Shows or hides a separator line at the bottom of the View (typically only false for last elements in a List).
     */
    public init(image: Image? = nil, text: Text, subText: Text? = nil, showBottomLine: Bool = true) {
        self.image = image
        self.text = text
        self.subText = subText
        self.showBottomLine = showBottomLine
    }
    
    public var body: some View {
        CheckBoxAndRadioButtonContainer(type: .radioButton, isOn: .constant(isOn), image: image, text: text, subText: subText, showBottomLine: showBottomLine)
    }
}

struct SBBRadioButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBRadioButton(text: Text("Text"))
                .previewDisplayName("Light, text only")
            SBBRadioButton(text: Text("Text"))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark, text only")
            SBBRadioButton(image: Image(sbbName: "alarm-clock", size: .small), text: Text("Text"))
                .previewDisplayName("Light, with image")
            SBBRadioButton(image: Image(sbbName: "alarm-clock", size: .small), text: Text("Text"))
                .disabled(true)
                .previewDisplayName("Light, disabled")
            SBBRadioButton(text: Text("Text"), subText: Text("Modell: iPhone 11 Pro\niOS Version: 14.0"))
                .previewDisplayName("Light, subText")
        }
        .previewLayout(.sizeThatFits)
    }
}
