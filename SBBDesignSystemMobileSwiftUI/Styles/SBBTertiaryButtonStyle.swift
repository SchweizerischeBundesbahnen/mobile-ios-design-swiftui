//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/**
 A ButtonStyle for tertiary buttons (white outline and text color).
 
 ## Overview
 SBBTertiaryButtonStyle has two different ``SBBButtonSize``s. You create a normal Button and apply the .buttonStyle() ViewModifier:
 ```swift
 var body: some View {
     Button(action: {}) {
        Text("Primary Button")
     }
         .buttonStyle(SBBTertiaryButtonStyle())
 }
 ```
 ![SBBTertiaryButtonStyle](SBBTertiaryButtonStyle)
 */
public struct SBBTertiaryButtonStyle: ButtonStyle {
    
    private let size: SBBButtonSize
    private var horizontalPadding: CGFloat = 16
       
    /**
     Returns a Button in SBB tertiary button style (white outline and text color) in the specified size.
     
     - Parameters:
        - size: The size of the button.
     */
    public init(size: SBBButtonSize = .large) {
        self.size = size
    }
    
    // DSM internal initializer, can be used for custom views (e.g. SBBChip)
    init(size: SBBButtonSize = .large, horizontalPadding: CGFloat) {
        self.size = size
        self.horizontalPadding = horizontalPadding
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        SBBTertiaryButton(size: size, horizontalPadding: horizontalPadding, configuration: configuration)
    }
    
    private struct SBBTertiaryButton: View {
        
        let size: SBBButtonSize
        let horizontalPadding: CGFloat
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        @Environment(\.colorScheme) var colorScheme
        
        var height: CGFloat {
            return (size == .large) ? 44 : 32
        }
        
        var body: some View {
            configuration.label
                .sbbFont(.medium_light)
                .foregroundColor(textColor)
                .frame(height: height)
                .padding(.horizontal, horizontalPadding)
                .background(getBackgroundColor(enabled: isEnabled, isPressed: configuration.isPressed))
                .cornerRadius(height / 2)
                .overlay(
                    RoundedRectangle(cornerRadius: height / 2)
                        .strokeBorder(borderColor, lineWidth: 1)
                )
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        
        private var textColor: Color {
            if isEnabled {
                return .sbbColor(.textBlack)
            } else {
                return (colorScheme == .light) ? .sbbColor(.graphite) : .sbbColor(.smoke)
            }
        }
        
        private var borderColor: Color {
            if isEnabled {
                return .sbbColor(.smoke)
            } else {
                return (colorScheme == .light) ? .sbbColor(.cloud) : .sbbColor(.iron)
            }
        }
        
        private func getBackgroundColor(enabled: Bool, isPressed: Bool) -> Color {
            if !enabled {
                return (colorScheme == .light) ? .sbbColor(.white) : .sbbColor(.black)
            } else if isPressed {
                return (colorScheme == .light) ? .sbbColor(.graphite) : .sbbColor(.black)
            } else {
                return (colorScheme == .light) ? .sbbColor(.white) : .sbbColor(.charcoal)
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
