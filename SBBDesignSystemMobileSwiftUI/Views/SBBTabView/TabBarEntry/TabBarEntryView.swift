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
    var tag: AnyHashable
    var customBackground: Color?
    var customForeground: Color?
    
    /**
     Returns a TabBarEntryView displaying the content of the tab.
     
     - Parameters:
        - contentView: The content of the tab
        - imageView: The image displayed in the tab bar
        - label: The label display in the tab bar
        - tag: The tag used to reference the bar
        - customBackground: The backgroud color of the tab (circle)
        - customForeground: The foreground color of the tab (circle)
     */
    public init(contentView: AnyView? = nil, imageView: Image? = nil, label: String? = nil, tag: AnyHashable, customBackground: Color? = nil, customForeground: Color? = nil) {
        self.imageView = imageView ?? Image(sbbName: "cross", size: .small)
        self.label = label ?? "_"
        self.labelView = Text(self.label)
        self.contentView = contentView ?? AnyView(VStack {
            Text(label ?? "_")
            imageView ?? Image(sbbName: "cross", size: .small)
        })
        self.tag = tag
        self.customBackground = customBackground
        self.customForeground = customForeground
    }
    
    public var body: some View {
        self.contentView
    }
    
    static func selectionIndex(for selection: AnyHashable, in contents: [TabBarEntryView]) -> Int {
       return contents.firstIndex { $0.tag == selection } ?? 0
    }
}
