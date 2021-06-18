//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension View {
    
    /**
     Applies SBB styling to a View. You typically apply the sbbStyle() View modifier to the umpost View in the hierarchy. It applies a specific background color, ignores bottom and horizontal Safe Areas (for landscape mode), adds a SBBNavigationBarSBBIcon as trailing Navigation Bar Item and sets a default Font.
     
     - Parameters:
        - edgesIgnoringSafeArea: The set of the edges in which to expand the size requested for this view. If you are using a TabView in your app, you need to pass .horizontal only.
     */
    func sbbStyle(edgesIgnoringSafeArea: Edge.Set = [.bottom, .horizontal]) -> some View {
        return self
            .background(Color.sbbColor(.background).edgesIgnoringSafeArea([.bottom, .horizontal]))
            .foregroundColor(.sbbColor(.textBlack))
            .edgesIgnoringSafeAreaSBBStyle(edgesIgnoringSafeArea: edgesIgnoringSafeArea)
            .navigationBarItems(trailing: SBBNavigationBarSBBIcon())
            .sbbFont(.body)
    }
}

extension View {
    func edgesIgnoringSafeAreaSBBStyle(edgesIgnoringSafeArea: Edge.Set = [.bottom, .horizontal]) -> some View {
        return self
            .edgesIgnoringSafeArea(edgesIgnoringSafeArea)
    }
}
