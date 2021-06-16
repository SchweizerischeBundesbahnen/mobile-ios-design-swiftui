//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/// A ButtonStyle for buttons with custom content (e.g. text and icon).
public struct SBBIconTextButtonStyle: ButtonStyle {
    
    /**
     Returns a Button in SBB icon and text button style.
     */
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        SBBIconButton(configuration: configuration)
    }
    
    private struct SBBIconButton: View {
        
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        var body: some View {
            configuration.label
                .sbbFont(.legend)
                .foregroundColor(getForegroundColor(enabled: isEnabled))
                .padding(.vertical, 16)
                .padding(.horizontal, 8)
                .frame(width: 96, height: 104)
                .background(getBackgroundColor(isPressed: configuration.isPressed))
                .cornerRadius(16)
        }
        
        private func getForegroundColor(enabled: Bool) -> Color {
            if !enabled {
                return .sbbColorInternal(.buttonTertiaryDisabledForeground)
            } else {
                return .sbbColor(.textBlack)
            }
        }
        
        private func getBackgroundColor(isPressed: Bool) -> Color {
            if isPressed {
                return .sbbColorInternal(.buttonTertiaryPressedBackground)
            } else {
                return .sbbColorInternal(.buttonTertiaryBackground)
            }
        }
    }
}

struct SSBBIconTextButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                Button(action: {}) {
                    VStack(alignment: .center, spacing: 4, content: {
                        Image(sbbName: "station", size: .large)
                        Text("Station")
                    })
                }
                    .previewDisplayName("Large, Light enabled")
                Button(action: {}) {
                    VStack(alignment: .center, spacing: 4, content: {
                        Image(sbbName: "station", size: .large)
                        Text("Station")
                    })
                }
                    .environment(\.isEnabled, false)
                    .previewDisplayName("Large, Light disabled")
                Button(action: {}) {
                    VStack(alignment: .center, spacing: 4, content: {
                        Image(sbbName: "station", size: .large)
                        Text("Station")
                    })
                }
                    .previewDisplayName("Large, Dark enabled")
                    .environment(\.colorScheme, .dark)
                Button(action: {}) {
                    VStack(alignment: .center, spacing: 4, content: {
                        Image(sbbName: "station", size: .large)
                        Text("Station")
                    })
                }
                    .environment(\.isEnabled, false)
                    .previewDisplayName("Large, Dark disabled")
                    .environment(\.colorScheme, .dark)
            }
                .buttonStyle(SBBIconTextButtonStyle())
        }
            .previewLayout(.sizeThatFits)

    }
}
