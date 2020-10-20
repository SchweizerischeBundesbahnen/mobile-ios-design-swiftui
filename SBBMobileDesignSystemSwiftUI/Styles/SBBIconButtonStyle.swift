//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBIconButtonStyle: ButtonStyle {
    
    private let size: SBBButtonSize
        
    public init(size: SBBButtonSize = .large) {
        self.size = size
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        SBBIconButton(size: size, configuration: configuration)
    }
    
    private struct SBBIconButton: View {
        
        let size: SBBButtonSize
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        var padding: CGFloat {
            return (size == .large) ? 10 : 4
        }
        
        var diameter: CGFloat {
            return (size == .large) ? 44 : 32
        }
        
        var body: some View {
            configuration.label
                .foregroundColor(getForegroundColor(enabled: isEnabled))
                .padding(padding)
                .frame(width: diameter, height: diameter)
                .background(getBackgroundColor(isPressed: configuration.isPressed))
                .cornerRadius(diameter / 2)
                .background(
                    RoundedRectangle(cornerRadius: diameter / 2)
                        .stroke(getBorderColor(enabled: isEnabled), lineWidth: 1)
                )
        }
        
        private func getForegroundColor(enabled: Bool) -> Color {
            if !enabled {
                return .sbbColorInternal(.buttonTertiaryDisabledForeground)
            } else {
                return .sbbColor(.textBlack)
            }
        }
        
        private func getBorderColor(enabled: Bool) -> Color {
            if !enabled {
                return .sbbColorInternal(.buttonTertiaryDisabledBorder)
            } else {
                return .sbbColor(.smoke)
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

struct SSBBIconButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                Button(action: {}) {
                    Image(sbbName: "chevron-small-right", size: .small)
                    .resizable()
                }
                    .previewDisplayName("Large, Light enabled")
                Button(action: {}) {
                    Image(sbbName: "chevron-small-right", size: .small)
                        .resizable()
                }
                    .environment(\.isEnabled, false)
                    .previewDisplayName("Large, Light disabled")
                Button(action: {}) {
                    Image(sbbName: "chevron-small-right", size: .small)
                        .resizable()
                }
                    .previewDisplayName("Large, Dark enabled")
                    .environment(\.colorScheme, .dark)
                Button(action: {}) {
                    Image(sbbName: "chevron-small-right", size: .small)
                        .resizable()
                }
                    .environment(\.isEnabled, false)
                    .previewDisplayName("Large, Dark disabled")
                    .environment(\.colorScheme, .dark)
            }
                .buttonStyle(SBBIconButtonStyle())
            Group {
                Button(action: {}) {
                    Image(sbbName: "chevron-small-right", size: .small)
                    .resizable()
                }
                    .previewDisplayName("Small, Light enabled")
                Button(action: {}) {
                    Image(sbbName: "chevron-small-right", size: .small)
                        .resizable()
                }
                    .environment(\.isEnabled, false)
                    .previewDisplayName("Small, Light disabled")
                Button(action: {}) {
                    Image(sbbName: "chevron-small-right", size: .small)
                        .resizable()
                }
                    .previewDisplayName("Small, Dark enabled")
                    .environment(\.colorScheme, .dark)
                Button(action: {}) {
                    Image(sbbName: "chevron-small-right", size: .small)
                        .resizable()
                }
                    .environment(\.isEnabled, false)
                    .previewDisplayName("Small, Dark disabled")
                    .environment(\.colorScheme, .dark)
            }
            .buttonStyle(SBBIconButtonStyle(size: .small))
        }
            .previewLayout(.sizeThatFits)

    }
}
