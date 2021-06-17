//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension View {
    
    /**
     Applies SBB styling to a View. You typically apply the sbbStyle() View modifier to the umpost View in the hierarchy. It applies a specific background color, ignores bottom and horizontal Safe Areas (for landscape mode), adds a SBBNavigationBarSBBIcon as trailing Navigation Bar Item and sets a default Font.
     */
    func sbbStyle() -> some View {
        return self
            .background(Color.sbbColor(.background))
            .foregroundColor(.sbbColor(.textBlack))
            .edgesIgnoringSafeAreaSBBStyle()
            .navigationBarItems(trailing: SBBNavigationBarSBBIcon())
            .sbbFont(.body)
    }
}

extension View {
    func edgesIgnoringSafeAreaSBBStyle() -> some View {
        return self
            .edgesIgnoringSafeArea([.bottom, .horizontal])
    }
}
