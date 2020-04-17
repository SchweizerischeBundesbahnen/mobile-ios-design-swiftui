//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public extension Button {
    
    func sbbPrimary() -> some View {
        self.buttonStyle(SBBPrimaryButtonStyle())
    }
}
