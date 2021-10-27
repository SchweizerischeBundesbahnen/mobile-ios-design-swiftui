//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension View {
    
    /**
     Applies SBB styling to a View. You typically apply the sbbStyle() View modifier to the upmost View in the hierarchy. It applies a specific background color, adds a SBBNavigationBarSBBIcon as trailing Navigation Bar Item and sets a default Font.
     
     - Parameters:
        - showSBBIcon: If set, a SBB Icon is shown on the trailing edge of the NavigationBar. Only set this value to false if you want to use a custom icon.
     */
    func sbbStyle(showSBBIcon: Bool = true) -> some View {
        return self
            .background(Color.sbbColor(.background).edgesIgnoringSafeArea([.bottom, .horizontal]))
            .foregroundColor(.sbbColor(.textBlack))
            //.edgesIgnoringSafeAreaSBBStyle(edgesIgnoringSafeArea: edgesIgnoringSafeArea)
            .navigationBarItems(trailing: showSBBIcon ? SBBNavigationBarSBBIcon() : nil)
            .sbbFont(.body)
    }
}
