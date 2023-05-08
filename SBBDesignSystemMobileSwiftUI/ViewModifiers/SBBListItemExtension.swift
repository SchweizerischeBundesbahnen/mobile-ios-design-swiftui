//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension SBBListItem {
    
    /**
     Adds a right-swipe Button to a SBBListItem. The right-swipe button will always have a red background and should be used for destructive actions only.
     
     ## Overview
     You can add a right swipe button to an existing ``SBBListItem`` by using the .rightSwipeButton() ViewModifier:
     ```swift
     var body: some View {
        SBBListItem(label: Text("Label"))
         .rightSwipeButton(label: Text("+"), action: {
             // your action
         })
     }
     ```
     
     - Parameters:
        - label: The View to be displayed in the button.
        - action: The code block to execute when the user touches the button.
     
     - Returns: A SBBListItem with the added right-swipe button.
     */
    func rightSwipeButton<SwipeLabel: View>(label: SwipeLabel, action: @escaping () -> Void) -> SBBListItem {
        var view = self
        
        view.rightSwipeButtonAction = action
        view.rightSwipeButtonLabel = AnyView(label)
        
        return view
    }
    
    /**
     Adds a left-swipe Button to a SBBListItem. The left-swipe button will always have a gray background and can be used for any actions.
     
     ## Overview
     You can add a left swipe button to an existing ``SBBListItem`` by using the .leftSwipeButton() ViewModifier:
     ```swift
     var body: some View {
        SBBListItem(label: Text("Label"))
         .leftSwipeButton(label: Text("-"), action: {
             // your action
         })
     }
     ```
     
     - Parameters:
        - label: The View to be displayed in the button.
        - action: The code block to execute when the user touches the button.
     
     - Returns: A SBBListItem with the added left-swipe button.
     */
    func leftSwipeButton<SwipeLabel: View>(label: SwipeLabel, action: @escaping () -> Void) -> SBBListItem {
        var view = self
        
        view.leftSwipeButtonAction = action
        view.leftSwipeButtonLabel = AnyView(label)
        
        return view
    }
}
