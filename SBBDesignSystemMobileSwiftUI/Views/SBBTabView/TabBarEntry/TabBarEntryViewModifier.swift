//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

extension View {
    /**
     Allows to add an image and a label to a tab.
     
     - Returns: A View containing the passed View with added image and label.
     */
    public func sbbTabItem<V>(image: Image? = nil, label: String? = nil, accessibilityLabel: String? = nil, tag: V, customBackground: Color? = nil, customForeground: Color? = nil) -> TabBarEntryView where V: Hashable {
        return TabBarEntryView(contentView: AnyView(self), imageView: image, label: label, accessibilityLabel: accessibilityLabel, tag: tag, customBackground: customBackground, customForeground: customForeground)
    }
}
