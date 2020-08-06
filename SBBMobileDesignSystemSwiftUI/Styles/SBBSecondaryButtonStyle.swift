//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBSecondaryButtonStyle: ButtonStyle {
        
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        SBBSecondaryButton(configuration: configuration)
    }
    
    private struct SBBSecondaryButton: View {
        
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        var body: some View {
            configuration.label
                .sbbFont(.body)
                .padding(.horizontal, 8)
                .foregroundColor(getColor(enabled: isEnabled, isPressed: configuration.isPressed))
                .frame(height: 44)
                .frame(minWidth: 0, maxWidth: .infinity)
                .contentShape(RoundedRectangle(cornerRadius: 23))
                .background(
                    RoundedRectangle(cornerRadius: 23)
                        .stroke(getColor(enabled: isEnabled, isPressed: configuration.isPressed), lineWidth: 1)
                )
                .minimumScaleFactor(0.1)
        }
        
        private func getColor(enabled: Bool, isPressed: Bool) -> Color {
            if !enabled {
                return SBBColor.metal
            } else if isPressed {
                return SBBColor.red125
            } else {
                return SBBColor.red
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
