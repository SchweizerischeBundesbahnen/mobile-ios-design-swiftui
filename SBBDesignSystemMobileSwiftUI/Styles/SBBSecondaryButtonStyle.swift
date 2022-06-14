//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/**
 A ButtonStyle for secondary buttons (red outline and text color).
 
 ## Overview
 You create a normal Button and apply the .buttonStyle() ViewModifier:
 ```swift
 var body: some View {
     Button(action: {}) {
         Text("Secondary Button")
     }
         .buttonStyle(SBBSecondaryButtonStyle())
 }
 ```
 ![SBBSecondaryButtonStyle](SBBSecondaryButtonStyle)
 */
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
                .foregroundColor(textColor)
                .frame(height: 44)
                .frame(minWidth: 0, maxWidth: horizontalSizeClass == .compact ? .infinity : 343)
                .background(getBackgroundColor(enabled: isEnabled, isPressed: configuration.isPressed))
                .cornerRadius(44 / 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 23)
                        .strokeBorder(borderColor, lineWidth: 1)
                )
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        
        private var textColor: Color {
            if isEnabled {
                return (colorScheme == .light) ? .sbbColor(.textRed) : .sbbColor(.white)
            } else {
                return (colorScheme == .light) ? .sbbColor(.graphite) : .sbbColor(.smoke)
            }
        }
        
        private var borderColor: Color {
            if isEnabled {
                return (colorScheme == .light) ? .sbbColor(.textRed) : .sbbColor(.smoke)
            } else {
                return (colorScheme == .light) ? .sbbColor(.cloud) : .sbbColor(.iron)
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
