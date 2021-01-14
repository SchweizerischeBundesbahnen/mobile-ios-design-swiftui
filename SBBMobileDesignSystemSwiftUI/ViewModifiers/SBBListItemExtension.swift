//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension SBBListItem {    
    func rightSwipeButton(label: Text, action: @escaping () -> Void) -> SBBListItem {
        var view = self
        
        view.rightSwipeButton = Button(action: {
            action()
        }) {
            label
        }
        
        return view
    }
    
    func leftSwipeButton(label: Text, action: @escaping () -> Void) -> SBBListItem {
        var view = self
        
        view.leftSwipeButton = Button(action: {
            action()
        }) {
            label
        }
        
        return view
    }
}
