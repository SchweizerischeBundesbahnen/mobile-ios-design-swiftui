//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/**
 A ButtonStyle for primary buttons (red background). Only one primary button per screen is allowed.
 
 ## Overview
 You create a normal Button and apply the .buttonStyle() ViewModifier:
 ```swift
 var body: some View {
     Button(action: {}) {
         Text("Primary Button")
     }
         .buttonStyle(SBBPrimaryButtonStyle())
 }
 ```
 ![SBBPrimaryButtonStyle](SBBPrimaryButtonStyle)
 */
public struct SBBPrimaryButtonStyle: ButtonStyle {
        
    private let sizeToFit: Bool
    
    /**
     Returns a Button in SBB primary button style (red background).
     
     - Parameters:
        - sizeToFit: If the button's width should only fit it's content or expand to the entire available width. You would typically set sizeToFit to true when using a floating primary button in a ZStack at the .bottomLeading edge of your view.
     */
    public init(sizeToFit: Bool = false) {
        self.sizeToFit = sizeToFit
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        SBBPrimaryButton(configuration: configuration, sizeToFit: sizeToFit)
    }
    
    private struct SBBPrimaryButton: View {
        
        let configuration: ButtonStyle.Configuration
        let sizeToFit: Bool
        @Environment(\.isEnabled) private var isEnabled: Bool
        @Environment(\.horizontalSizeClass) var horizontalSizeClass
        @Environment(\.colorScheme) var colorScheme
        
        @ViewBuilder
        var body: some View {
            if sizeToFit {
                configuration.label
                    .sbbFont(.medium_light)
                    .padding(.horizontal, 24)
                    .foregroundColor(textColor)
                    .frame(height: 46)
                    .background(getBackgroundColor(enabled: isEnabled, isPressed: configuration.isPressed))
                    .cornerRadius(23)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
            } else {
                configuration.label
                    .sbbFont(.medium_light)
                    .padding(.horizontal, 8)
                    .foregroundColor(textColor)
                    .frame(height: 46)
                    .frame(minWidth: 0, maxWidth: horizontalSizeClass == .compact ? .infinity : 343)
                    .background(getBackgroundColor(enabled: isEnabled, isPressed: configuration.isPressed))
                    .cornerRadius(23)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
            }
            
        }
        
        private var textColor: Color {
            if isEnabled {
                return .sbbColor(.textWhite)
            } else {
                return (colorScheme == .light) ? .sbbColor(.textWhite) : .sbbColor(.smoke)
            }
        }
        
        private func getBackgroundColor(enabled: Bool, isPressed: Bool) -> Color {
            if isPressed {
                return .sbbColor(.secondary)
            } else if enabled {
                return .sbbColor(.primary)
            } else {
                return (colorScheme == .light) ? .sbbColor(.graphite) : .sbbColor(.iron)
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
