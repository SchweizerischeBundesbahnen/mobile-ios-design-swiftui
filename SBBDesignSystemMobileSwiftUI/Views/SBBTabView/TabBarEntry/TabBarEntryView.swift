//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI
import Foundation


/**
 A View that is used by ``SBBTabView`` to represent the content of a tab, as well as the icon and label used in the tab bar.
 */
public struct TabBarEntryView: View {
    var contentView: AnyView = AnyView(Image(sbbName: "cross", size: .small))
    var imageView: Image = Image(sbbName: "cross", size: .small)
    var labelView: Text = Text("_")
    var tag: Any?
    
    /**
     Returns a TabBarEntryView displaying the content of the tab.
     
     - Parameters:
        - contentView: The content of the tab
        - imageView: The image displayed in the tab bar
        - labelView: The label display in the tab bar
        - tag: The tag used to reference the bar
     */
    public init(contentView: AnyView, imageView: Image, labelView: Text, tag: Any) {
        self.contentView = contentView
        self.imageView = imageView
        self.labelView = labelView
        self.tag = tag
    }
    
    /**
     Returns a TabBarEntryView displaying the content of the tab.
     
     - Parameters:
        - contentView: The content of the tab
        - imageView: The image displayed in the tab bar
        - labelView: The label display in the tab bar
     */
    public init(contentView: AnyView, imageView: Image, labelView: Text) {
        self.contentView = contentView
        self.imageView = imageView
        self.labelView = labelView
    }
    
    /**
     Returns a TabBarEntryView displaying the content of the tab.
     
     - Parameters:
        - imageView: The image displayed in the tab bar
        - labelView: The label display in the tab bar
        - tag: The tag used to reference the bar
     */
    public init(imageView: Image, labelView: Text, tag: Any) {
        self.imageView = imageView
        self.labelView = labelView
        self.tag = tag
        self.contentView = AnyView(VStack {
            labelView
            imageView
        })
    }
    
    /**
     Returns a TabBarEntryView displaying the content of the tab.
     
     - Parameters:
        - contentView: The content of the tab
        - tag: The tag used to reference the bar
     */
    public init(contentView: AnyView, tag: Any) {
        self.contentView = contentView
        self.tag = tag
    }
    
    /**
     Returns a TabBarEntryView displaying the content of the tab.
     
     - Parameters:
        - contentView: The content of the tab
     */
    public init(contentView: AnyView) {
        self.contentView = contentView
    }
    
    public init(){
        
    }
    
    public var body: some View {
        self.contentView
    }
}
