//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBButton: View {
    
    @Environment(\.isEnabled) private var isEnabled
    private let action: () -> Void
    private let label: String
    
    public init(action: @escaping () -> Void, label: String) {
        self.action = action
        self.label = label
    }
    
    public var body: some View {
        Button(action: action) {
            Text(label)
        }
        .buttonStyle(SBBButtonStyle(enabled: isEnabled))
    }
}

struct SBBButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBButton(action: {}, label: "Button")
                .previewDisplayName("Light")
            SBBButton(action: {}, label: "Button")
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
            SBBButton(action: {}, label: "Button")
                .disabled(true)
                .previewDisplayName("Light disabled")
            SBBButton(action: {}, label: "Button")
                .disabled(true)
                .previewDisplayName("Dark disabled")
                .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
