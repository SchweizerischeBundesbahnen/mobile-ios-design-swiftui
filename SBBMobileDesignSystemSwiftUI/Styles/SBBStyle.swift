//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension View {
    
    /**
     Applies SBB styling to a View. You typically apply the sbbStyle() View modifier to the umpost View in the hierarchy. It applies a specific background color, adds a SBBNavigationBarSBBIcon as trailing Navigation Bar Item and sets a default Font.
     */
    func sbbStyle() -> some View {
        return self
            .background(Color.sbbColor(.background).edgesIgnoringSafeArea([.bottom, .horizontal]))
            .foregroundColor(.sbbColor(.textBlack))
            //.edgesIgnoringSafeAreaSBBStyle(edgesIgnoringSafeArea: edgesIgnoringSafeArea)
            .navigationBarItems(trailing: SBBNavigationBarSBBIcon())
            .sbbFont(.body)
    }
}
