//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/**
 A ButtonStyle for buttons with custom content (e.g. text and icon).
 
 ## Overview
 You create a normal Button and apply the .buttonStyle() ViewModifier:
 ```swift
 var body: some View {
     Button(action: {}) {
         VStack(alignment: .center, spacing: 4, content: {
             Image(sbbName: "station", size: .large)
             Text("Station")
         })
     }
         .buttonStyle(SBBIconTextButtonStyle())
 }
 ```
 ![SBBIconTextButtonStyle](SBBIconTextButtonStyle)
 */
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
        @Environment(\.colorScheme) var colorScheme

        var body: some View {
            configuration.label
                .sbbFont(.legend)
                .foregroundColor(getForegroundColor(enabled: isEnabled))
                .padding(.vertical, 16)
                .padding(.horizontal, 8)
                .frame(width: 96, height: 104)
                .background(getBackgroundColor(enabled: isEnabled, isPressed: configuration.isPressed))
                .cornerRadius(16)
        }
        
        private func getForegroundColor(enabled: Bool) -> Color {
            if !enabled {
                return (colorScheme == .light) ? .sbbColor(.graphite) : .sbbColor(.smoke)
            } else {
                return .sbbColor(.textBlack)
            }
        }
        
        private func getBackgroundColor(enabled: Bool, isPressed: Bool) -> Color {
            if !enabled {
                return (colorScheme == .light) ? .sbbColor(.white) : .sbbColor(.black)
            } else  if isPressed {
                return (colorScheme == .light) ? .sbbColor(.graphite) : .sbbColor(.black)
            } else {
                return (colorScheme == .light) ? .sbbColor(.white) : .sbbColor(.charcoal)
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
