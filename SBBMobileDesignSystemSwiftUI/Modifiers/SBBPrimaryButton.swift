//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBPrimaryButton: ViewModifier {
    
    @Environment(\.isEnabled) private var isEnabled
    
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .buttonStyle(SBBPrimaryButtonStyle(enabled: isEnabled))
    }
}

public extension Button {
    
    func sbbPrimary() -> some View {
        self.modifier(SBBPrimaryButton())
    }
}
