//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

extension View {
    /**
     Allows to add an image and a label to a tab.
     
     - Returns: A View containing the passed View with added image and label.
     */
    public func sbbTabItem(image: Image, label: Text) -> TabBarEntryView {
        if let content = getTabBarEntryContent(val: self) {
            if let tag = content.tag {
                return TabBarEntryView(contentView: AnyView(content.contentView), imageView: image, labelView: label, tag: tag)
            }
            return TabBarEntryView(contentView: AnyView(content.contentView), imageView: image, labelView: label)
        }
        return TabBarEntryView(contentView: AnyView(self), imageView: image, labelView: label)
    }
    
    /**
     Allows to add a tag to a tab.
     
     - Returns: A View containing the passed View with added tag.
     */
    public func sbbTag<V>(_ tag: V) -> TabBarEntryView where V : Hashable {
        if let content = getTabBarEntryContent(val: self) {
            return TabBarEntryView(contentView: content.contentView, imageView: content.imageView, labelView: content.labelView, tag: tag)
        }
        
        return TabBarEntryView(contentView: AnyView(self), tag: tag)
    }
}

func getTabBarEntryContent<V>(val: V) -> TabBarEntryView? {
    if let temp = val as? TabBarEntryView {
        return temp
    } else if let temp = val as? ModifiedContent<TabBarEntryView, _IdentifiedModifier<__DesignTimeSelectionIdentifier>> {
        return temp.content
    }
    return nil
}
