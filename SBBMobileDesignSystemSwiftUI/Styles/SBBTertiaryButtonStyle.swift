//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBTertiaryButtonStyle: ButtonStyle {
    
    private let size: SBBButtonSize
        
    public init(size: SBBButtonSize = .large) {
        self.size = size
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        SBBTertiaryButton(size: size, configuration: configuration)
    }
    
    private struct SBBTertiaryButton: View {
        
        let size: SBBButtonSize
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        var height: CGFloat {
            return (size == .large) ? 44 : 32
        }
        
        var body: some View {
            configuration.label
                .sbbFont(.body)
                .foregroundColor(getForegroundColor(enabled: isEnabled))
                .frame(height: height)
                .padding(.horizontal, 16)
                .background(getBackgroundColor(isPressed: configuration.isPressed))
                .cornerRadius(height / 2)
                .background(
                    RoundedRectangle(cornerRadius: height / 2)
                        .stroke(getBorderColor(enabled: isEnabled), lineWidth: 1)
                )
        }
        
        private func getForegroundColor(enabled: Bool) -> Color {
            if !enabled {
                return SBBColor.buttonTertiaryDisabledForeground
            } else {
                return SBBColor.textBlack
            }
        }
        
        private func getBorderColor(enabled: Bool) -> Color {
            if !enabled {
                return SBBColor.buttonTertiaryDisabledBorder
            } else {
                return SBBColor.smoke
            }
        }
        
        private func getBackgroundColor(isPressed: Bool) -> Color {
            if isPressed {
                return SBBColor.buttonTertiaryPressedBackground
            } else {
                return SBBColor.buttonTertiaryBackground
            }
        }
    }
}

struct SBBTertiaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                Button(action: {}) {
                    Text("Button")
                }
                .previewDisplayName("Large, Light enabled")
                Button(action: {}) {
                    Text("Button")
                }
                .environment(\.isEnabled, false)
                .previewDisplayName("Large, Light disabled")
                Button(action: {}) {
                    Text("Button")
                }
                .previewDisplayName("Large, Dark enabled")
                .environment(\.colorScheme, .dark)
                Button(action: {}) {
                    Text("Button")
                }
                .environment(\.isEnabled, false)
                .previewDisplayName("Large, Dark disabled")
                .environment(\.colorScheme, .dark)
            }
                .buttonStyle(SBBTertiaryButtonStyle())
            Group {
                Button(action: {}) {
                    Text("Button")
                }
                .previewDisplayName("Small, Light enabled")
                Button(action: {}) {
                    Text("Button")
                }
                .environment(\.isEnabled, false)
                .previewDisplayName("Small, Light disabled")
                Button(action: {}) {
                    Text("Button")
                }
                .previewDisplayName("Small, Dark enabled")
                .environment(\.colorScheme, .dark)
                Button(action: {}) {
                    Text("Button")
                }
                .environment(\.isEnabled, false)
                .previewDisplayName("Small, Dark disabled")
                .environment(\.colorScheme, .dark)
            }
            .buttonStyle(SBBTertiaryButtonStyle(size: .small))
        }
        .previewLayout(.sizeThatFits)
    }
}
