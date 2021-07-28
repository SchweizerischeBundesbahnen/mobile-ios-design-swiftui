//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension View {
    
    /**
     Sets the state for the EnvironmentKey .isSelected. This ViewModifier is typically used for a SBBRadioButton used without a SBBRadioButtonGroup.
     
     - Parameters:
        - isSelected: The state of the EnvironmentKey .isSelected.
     
     - Returns: A view with added EnvironmentKey.
     */
    func isSelected(_ isSelected: Bool) -> some View {
        self.modifier(SelectedModifier(isSelected: isSelected))
    }
}

struct SelectedModifier: ViewModifier {
    var isSelected: Bool
    
    public func body(content: Content) -> some View {
        content
            .environment(\.isSelected, isSelected)
    }
}

extension EnvironmentValues {
    struct SelectedKey: EnvironmentKey {
        static var defaultValue: Bool = false
    }
    
    
    var isSelected: Bool {
        get { self[SelectedKey] }
        set { self[SelectedKey] = newValue }
    }
}
