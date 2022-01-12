//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI
import Foundation

public struct TabBarEntryView: View {
    // The information needed for each tab: content, image, label and tag
    var contentView: AnyView = AnyView(Image(sbbName: "cross", size: .small))
    var imageView: Image = Image(sbbName: "cross", size: .small)
    var labelView: Text = Text("_")
    var tag: Any?
    
    public init(contentView: AnyView, imageView: Image, labelView: Text, tag: Any) {
        self.contentView = contentView
        self.imageView = imageView
        self.labelView = labelView
        self.tag = tag
    }
    
    public init(contentView: AnyView, imageView: Image, labelView: Text) {
        self.contentView = contentView
        self.imageView = imageView
        self.labelView = labelView
    }
    
    public init(contentView: AnyView, tag: Any) {
        self.contentView = contentView
        self.tag = tag
    }
    
    public init(contentView: AnyView) {
        self.contentView = contentView
    }
    
    public init(){
        
    }
    
    public var body: some View {
        self.contentView
    }
}
