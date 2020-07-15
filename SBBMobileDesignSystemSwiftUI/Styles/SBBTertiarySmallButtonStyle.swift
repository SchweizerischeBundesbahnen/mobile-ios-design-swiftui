//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBTertiarySmallButtonStyle: ButtonStyle {
        
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        SBBTertiarySmallButton(configuration: configuration)
    }
    
    private struct SBBTertiarySmallButton: View {
        
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        var body: some View {
            configuration.label
                .sbbFont(.legend)
                .foregroundColor(SBBColor.textBlack)
                .frame(height: 32)
                .padding(.horizontal, 16)
                .background(getBackgroundColor(enabled: isEnabled, isPressed: configuration.isPressed))
                .cornerRadius(16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(SBBColor.smoke, lineWidth: 1)
                        
                        
                )
        }
        
        private func getBackgroundColor(enabled: Bool, isPressed: Bool) -> Color {
            if isPressed {
                return SBBColor.buttonTertiaryPressedBackground
            } else {
                return SBBColor.buttonTertiaryBackground
            }
        }
    }
}

struct SBBTertiarySmallButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBTertiarySmallButtonStyle())
            .previewDisplayName("Light enabled")
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBTertiarySmallButtonStyle())
            .environment(\.isEnabled, false)
            .previewDisplayName("Light disabled")
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBTertiarySmallButtonStyle())
            .previewDisplayName("Dark enabled")
            .environment(\.colorScheme, .dark)
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBTertiarySmallButtonStyle())
            .environment(\.isEnabled, false)
            .previewDisplayName("Dark disabled")
            .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
