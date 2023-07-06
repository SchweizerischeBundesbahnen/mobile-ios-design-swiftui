//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI
import Foundation


/**
 A View that is used by ``SBBTabView`` to represent the content of a tab, as well as the icon and label used in the tab bar.
 */
public struct TabBarEntryView: View, Identifiable {
    
    public var id: AnyHashable {
        return tag
    }
    
    var contentView: AnyView
    var imageView: Image
    var labelView: Text
    
    var label: String
    var accessibilityLabel: String
    var tag: AnyHashable
    var warningBackground: Bool
    var badge: Bool
    var badgeNumber: Int?
    
    /**
     Returns a TabBarEntryView displaying the content of the tab.
     
     - Parameters:
        - contentView: The content of the tab
        - imageView: The image displayed in the tab bar
        - label: The label display in the tab bar
        - tag: The tag used to reference the bar
        - warningBackground: Whether the backgroud color of the tab (circle) is in the primary color (red or blue)
        - badge: Whether to display a small badge at the top right of the tab
        - badgeNumber: The number to display inside the badge
     */
    public init(contentView: AnyView? = nil, imageView: Image? = nil, label: String? = nil, accessibilityLabel: String? = nil, tag: AnyHashable, warningBackground: Bool = false, badge: Bool = false, badgeNumber: Int? = nil) {
        self.imageView = imageView ?? Image(sbbIcon: .cross_small)
        self.label = label ?? "_"
        self.accessibilityLabel = accessibilityLabel ?? self.label
        
        self.labelView = Text(self.label)
        self.contentView = contentView ?? AnyView(VStack {
            Text(label ?? "_")
            imageView ?? Image(sbbIcon: .cross_small)
        })
        self.tag = tag
        self.warningBackground = warningBackground
        self.badge = badge
        self.badgeNumber = badgeNumber
    }
    
    public var body: some View {
        self.contentView
    }
    
    static func selectionIndex(for selection: AnyHashable, in contents: [TabBarEntryView]) -> Int {
       return contents.firstIndex { $0.tag == selection } ?? 0
    }
}
