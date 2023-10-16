//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

// Once SwiftUI allows us to modify the placeholder text color, this ViewModifier can be removed
struct TextFieldPlaceholderCustomColorStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .sbbFont(.medium_light)
                    .foregroundColor(.sbbColor(.placeholder))
                    .accessibility(hidden: true)
            }
            content
        }
    }
}
