//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

/// A ButtonStyle for primary floating buttons (red background) with dynamic width, so it can be used as a floating button (typically inside a ZStack on the bottomLeading edge of the Screen. Only one primary button per screen is allowed.
public struct SBBPrimaryFloatingButtonStyle: ButtonStyle {
        
    /// Returns a Button in SBB primary floating button style (red background) with dynamic width.
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        SBBPrimaryFloatingButton(configuration: configuration)
    }
    
    private struct SBBPrimaryFloatingButton: View {
        
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        @Environment(\.horizontalSizeClass) var horizontalSizeClass
        
        var body: some View {
            configuration.label
                .sbbFont(.body)
                .padding(.horizontal, 24)
                .foregroundColor(isEnabled ? .sbbColor(.textWhite) : .sbbColor(.textMetal))
                .frame(height: 46)
                .background(getBackgroundColor(enabled: isEnabled, isPressed: configuration.isPressed))
                .cornerRadius(23)
                .minimumScaleFactor(0.1)
        }
        
        private func getBackgroundColor(enabled: Bool, isPressed: Bool) -> Color {
            if !enabled {
                return .sbbColor(.disabledButtonBackground)
            } else if isPressed {
                return .sbbColor(.red150)
            } else {
                return .sbbColor(.red)
            }
        }
    }
}

struct SBBPrimaryFloatingButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBPrimaryButtonStyle())
            .previewDisplayName("Light enabled")
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBPrimaryButtonStyle())
            .previewDisplayName("Light disabled")
            .environment(\.isEnabled, false)
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBPrimaryButtonStyle())
            .previewDisplayName("Dark enabled")
            .environment(\.colorScheme, .dark)
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBPrimaryButtonStyle())
            .previewDisplayName("Dark disabled")
            .environment(\.colorScheme, .dark)
            .environment(\.isEnabled, false)
        }
        .previewLayout(.sizeThatFits)
    }
}
