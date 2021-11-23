//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/// A ButtonStyle for secondary buttons (red outline and text color).
public struct SBBSecondaryButtonStyle: ButtonStyle {
        
    /// Returns a Button in SBB secondary button style (red outline and text color).
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        SBBSecondaryButton(configuration: configuration)
    }
    
    private struct SBBSecondaryButton: View {
        
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        @Environment(\.horizontalSizeClass) var horizontalSizeClass
        @Environment(\.colorScheme) var colorScheme

        var body: some View {
            configuration.label
                .sbbFont(.body)
                .padding(.horizontal, 8)
                .foregroundColor(getForegroundColor(enabled: isEnabled, isPressed: configuration.isPressed))
                .frame(height: 44)
                .frame(minWidth: 0, maxWidth: horizontalSizeClass == .compact ? .infinity : 343)
                .background(getBackgroundColor(enabled: isEnabled, isPressed: configuration.isPressed))
                .cornerRadius(44 / 2)
                .background(
                    RoundedRectangle(cornerRadius: 23)
                        .stroke(getForegroundColor(enabled: isEnabled, isPressed: configuration.isPressed), lineWidth: 1)
                )
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        
        private func getForegroundColor(enabled: Bool, isPressed: Bool) -> Color {
            if !enabled {
                return (colorScheme == .light) ? .sbbColor(.graphite) : .sbbColor(.smoke)
            } else if isPressed {
                return (colorScheme == .light) ? .sbbColor(.secondary) : .sbbColor(.white)
            } else {
                return (colorScheme == .light) ? .sbbColor(.primary) : .sbbColor(.white)
            }
        }
        
        private func getBackgroundColor(enabled: Bool, isPressed: Bool) -> Color {
            if !enabled {
                return (colorScheme == .light) ? .sbbColor(.white) : .sbbColor(.black)
            } else if isPressed {
                return (colorScheme == .light) ? .sbbColor(.graphite) : .sbbColor(.charcoal)
            } else {
                return (colorScheme == .light) ? .sbbColor(.white) : .sbbColor(.iron)
            }
        }
    }
}

struct SBBSecondaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBSecondaryButtonStyle())
            .previewDisplayName("Light enabled")
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBSecondaryButtonStyle())
            .environment(\.isEnabled, false)
            .previewDisplayName("Light disabled")
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBSecondaryButtonStyle())
            .previewDisplayName("Dark enabled")
            .environment(\.colorScheme, .dark)
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBSecondaryButtonStyle())
            .environment(\.isEnabled, false)
            .previewDisplayName("Dark disabled")
            .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}
