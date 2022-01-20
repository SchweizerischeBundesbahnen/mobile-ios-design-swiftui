//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

extension TupleView {
    
    var getTabViews: [TabBarEntryView] {
        makeArrayTabViews(from: value)
    }
    
    private struct GenericView {
        let body: Any
        
        var tabEntryView: TabBarEntryView? {
            if let content = getTabBarEntryContent(val: body) {
                if let tag = content.tag {
                    return TabBarEntryView(contentView: content.contentView, imageView: content.imageView, labelView: content.labelView, tag: tag)
                }
                return TabBarEntryView(contentView: content.contentView, imageView: content.imageView, labelView: content.labelView)
            }
            if let bodyView = AnyView(_fromValue: body) {
                return TabBarEntryView(contentView: bodyView)
            }
            return TabBarEntryView()
        }
    }
    
    private func makeArrayTabViews<Tuple>(from tuple: Tuple) -> [TabBarEntryView] {
        func convert(child: Mirror.Child) -> TabBarEntryView? {
            // Get a child view and convert it to TabBarEntryView
            withUnsafeBytes(of: child.value) { ptr -> TabBarEntryView? in
                let binded = ptr.bindMemory(to: GenericView.self)
                
                return binded.first?.tabEntryView
            }
        }
        
        let tupleMirror = Mirror(reflecting: tuple)
        return tupleMirror.children.compactMap(convert)
    }
}
