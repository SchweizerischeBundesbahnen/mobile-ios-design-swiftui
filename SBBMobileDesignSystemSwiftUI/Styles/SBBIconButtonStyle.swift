//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/// A ButtonStyle for buttons with an icon instead of text (white outline and text color).
public struct SBBIconButtonStyle: ButtonStyle {
    
    /// SBBIconButton style.
    public enum Style {
        /// Normal SBBIconButton style (background with fixed color)
        case normal
        /// Negative SBBIconButton style (transparent background, to be used on colored backgrounds (e.g. NavigationBar))
        case negative
    }
    
    private let size: SBBButtonSize
    private let style: Style
    private let showBorder: Bool
        
    /**
     Returns a Button in SBB icon button style (white outline and text color) in the specified size and style.
     
     - Parameters:
        - size: The size of the button.
        - style: The style of the button.
        - showBorder: Flag showing or hiding a border around the button.
     */
    public init(size: SBBButtonSize = .large, style: Style = .normal, showBorder: Bool = true) {
        self.size = size
        self.style = style
        self.showBorder = showBorder
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        SBBIconButton(size: size, style: style, showBorder: showBorder, configuration: configuration)
    }
    
    private struct SBBIconButton: View {
        
        let size: SBBButtonSize
        let style: Style
        let showBorder: Bool
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
                .cornerRadius(showBorder ? diameter / 2 : 0)
                .background(
                    Group {
                        if showBorder {
                            RoundedRectangle(cornerRadius: diameter / 2)
                                .stroke(getBorderColor(enabled: isEnabled), lineWidth: 1)
                        }
                    }
                )
        }
        
        private func getForegroundColor(enabled: Bool) -> Color {
            switch style {
            case .normal:
                if !enabled {
                    return .sbbColorInternal(.buttonTertiaryDisabledForeground)
                } else {
                    return .sbbColor(.textBlack)
                }
            case .negative:
                return Color.sbbColor(.white).opacity(enabled ? 1 : 0.5)
            }
        }
        
        private func getBorderColor(enabled: Bool) -> Color {
            switch style {
            case .normal:
                if !enabled {
                    return .sbbColorInternal(.buttonTertiaryDisabledBorder)
                } else {
                    return .sbbColor(.smoke)
                }
            case .negative:
                return Color.sbbColor(.white).opacity(enabled ? 1 : 0.5)
            }
        }
        
        private func getBackgroundColor(isPressed: Bool) -> Color {
            switch style {
            case .normal:
                if isPressed {
                    return .sbbColorInternal(.buttonTertiaryPressedBackground)
                } else {
                    return .sbbColorInternal(.buttonTertiaryBackground)
                }
            case .negative:
                return Color.sbbColor(.black).opacity(isPressed ? 0.2 : 0)
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
            Group {
                Button(action: {}) {
                    Image(sbbName: "chevron-small-right", size: .small)
                    .resizable()
                }
                    .previewDisplayName("Small, negative, enabled")
                Button(action: {}) {
                    Image(sbbName: "chevron-small-right", size: .small)
                        .resizable()
                }
                    .environment(\.isEnabled, false)
                    .previewDisplayName("Small, negative, disabled")
            }
                .buttonStyle(SBBIconButtonStyle(size: .small, style: .negative))
                .background(Color.sbbColor(.primary))
            Group {
                Button(action: {}) {
                    Image(sbbName: "chevron-small-right", size: .small)
                    .resizable()
                }
                    .previewDisplayName("Small, Light, no border, enabled")
                Button(action: {}) {
                    Image(sbbName: "chevron-small-right", size: .small)
                        .resizable()
                }
                    .environment(\.isEnabled, false)
                    .previewDisplayName("Small, Light, no border, disabled")
                Button(action: {}) {
                    Image(sbbName: "chevron-small-right", size: .small)
                        .resizable()
                }
                    .previewDisplayName("Small, Dark, no border, enabled")
                    .environment(\.colorScheme, .dark)
                Button(action: {}) {
                    Image(sbbName: "chevron-small-right", size: .small)
                        .resizable()
                }
                    .environment(\.isEnabled, false)
                    .previewDisplayName("Small, Dark, no border, disabled")
                    .environment(\.colorScheme, .dark)
            }
                .buttonStyle(SBBIconButtonStyle(size: .small, showBorder: false))
        }
            .previewLayout(.sizeThatFits)

    }
}
