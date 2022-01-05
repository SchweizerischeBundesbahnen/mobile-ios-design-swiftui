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
        - label: The Text to be displayed in the button.
        - action: The code block to execute when the user touches the button.
     
     - Returns: A SBBListItem with the added right-swipe button.
     */
    func rightSwipeButton(label: Text, action: @escaping () -> Void) -> SBBListItem {
        var view = self
        
        view.rightSwipeButtonAction = action
        view.rightSwipeButtonText = label
        
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
        - label: The Text to be displayed in the button.
        - action: The code block to execute when the user touches the button.
     
     - Returns: A SBBListItem with the added left-swipe button.
     */
    func leftSwipeButton(label: Text, action: @escaping () -> Void) -> SBBListItem {
        var view = self
        
        view.leftSwipeButtonAction = action
        view.leftSwipeButtonText = label
        
        return view
    }
}
