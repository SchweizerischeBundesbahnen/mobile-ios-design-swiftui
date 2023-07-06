//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

extension View {
    /**
     Allows to add an image and a label to a tab.
     
     - Returns: A View containing the passed View with added image and label.
     */
    public func sbbTabItem<V, D>(image: Image? = nil, label: String? = nil, accessibilityLabel: String? = nil, tag: V, warningBackground: Bool = false, badge: Bool = false, badgeView: D) -> TabBarEntryView where V: Hashable, D: View {
        return TabBarEntryView(contentView: AnyView(self), imageView: image, label: label, accessibilityLabel: accessibilityLabel, tag: tag, warningBackground: warningBackground, badge: badge, badgeView: AnyView(badgeView))
    }
    
    public func sbbTabItem<V>(image: Image? = nil, label: String? = nil, accessibilityLabel: String? = nil, tag: V, warningBackground: Bool = false, badge: Bool = false) -> TabBarEntryView where V: Hashable {
        return TabBarEntryView(contentView: AnyView(self), imageView: image, label: label, accessibilityLabel: accessibilityLabel, tag: tag, warningBackground: warningBackground, badge: badge)
    }
}
