//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension View {
    func sbbToastContainer() -> some View {
            self
                .overlay(
                    ToastContainerView()
                )
    }
}
