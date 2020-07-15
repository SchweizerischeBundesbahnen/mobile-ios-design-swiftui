//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBTertiaryLargeButtonStyle: ButtonStyle {
        
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        SBBTertiaryLargeButton(configuration: configuration)
    }
    
    private struct SBBTertiaryLargeButton: View {
        
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        var body: some View {
            configuration.label
                .sbbFont(.body)
                .foregroundColor(SBBColor.textBlack)
                .frame(height: 44)
                .padding(.horizontal, 16)
                .background(getBackgroundColor(enabled: isEnabled, isPressed: configuration.isPressed))
                .cornerRadius(22)
                .background(
                    RoundedRectangle(cornerRadius: 22)
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

struct SBBTertiaryLargeButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBTertiaryLargeButtonStyle())
            .previewDisplayName("Light enabled")
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBTertiaryLargeButtonStyle())
            .environment(\.isEnabled, false)
            .previewDisplayName("Light disabled")
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBTertiaryLargeButtonStyle())
            .previewDisplayName("Dark enabled")
            .environment(\.colorScheme, .dark)
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBTertiaryLargeButtonStyle())
            .environment(\.isEnabled, false)
            .previewDisplayName("Dark disabled")
            .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
