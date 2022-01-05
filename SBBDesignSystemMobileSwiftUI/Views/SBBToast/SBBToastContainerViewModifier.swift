//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension View {
    
    /**
     Allows SBBToasts to be presented above the current screen by using the SBBToastService from anywhere in your view hierarchy. Needs to be applied to the main/root View.
     
     - Returns: A View containing the passed View with added presentable content above it.
     */
    func sbbToastContainer() -> some View {
            self
                .overlay(
                    ToastContainerView()
                )
    }
}
