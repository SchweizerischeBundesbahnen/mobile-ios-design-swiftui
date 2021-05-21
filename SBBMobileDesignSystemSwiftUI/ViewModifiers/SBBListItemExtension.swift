//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension SBBListItem {    
    func rightSwipeButton(label: Text, action: @escaping () -> Void) -> SBBListItem {
        var view = self
        
        view.rightSwipeButtonAction = action
        view.rightSwipeButtonText = label
        
        return view
    }
    
    func leftSwipeButton(label: Text, action: @escaping () -> Void) -> SBBListItem {
        var view = self
        
        view.leftSwipeButtonAction = action
        view.leftSwipeButtonText = label
        
        return view
    }
}
