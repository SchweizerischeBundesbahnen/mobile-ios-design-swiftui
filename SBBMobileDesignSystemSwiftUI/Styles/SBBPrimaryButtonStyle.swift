//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBPrimaryButtonStyle: ButtonStyle {
        
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        SBBPrimaryButton(configuration: configuration)
    }
    
    private struct SBBPrimaryButton: View {
        
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        var body: some View {
            configuration.label
                .sbbFont(.body)
                .foregroundColor(isEnabled ? SBBColor.textWhite : SBBColor.textMetal)
                .frame(height: 46)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(getBackgroundColor(enabled: isEnabled, isPressed: configuration.isPressed))
                .cornerRadius(23)
                .minimumScaleFactor(0.1)
        }
        
        private func getBackgroundColor(enabled: Bool, isPressed: Bool) -> Color {
            if !enabled {
                return SBBColor.disabledButtonBackground
            } else if isPressed {
                return SBBColor.red150
            } else {
                return SBBColor.red
            }
        }
    }
}

struct SBBPrimaryButtonStyle_Previews: PreviewProvider {
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
