//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

struct SBBButtonStyle: ButtonStyle {
    
    var enabled: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
      configuration.label
        .sbbFont(.body)
        .foregroundColor(enabled ? SBBColor.textWhite : SBBColor.textMetal)
        .frame(height: 46)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(getBackgroundColor(enabled: enabled, isPressed: configuration.isPressed))
        .cornerRadius(23)
    }
    
    private func getBackgroundColor(enabled: Bool, isPressed: Bool) -> Color {
        if !enabled {
            return SBBColor.disabledButtonBackground
        } else if isPressed {
            return SBBColor.red150
        } else {
            return SBBColor.red
        }
    }
}

struct SBBButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBButtonStyle(enabled: true))
            .previewDisplayName("Light enabled")
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBButtonStyle(enabled: false))
            .previewDisplayName("Light disabled")
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBButtonStyle(enabled: true))
            .previewDisplayName("Dark enabled")
            .environment(\.colorScheme, .dark)
            Button(action: {}) {
                Text("Button")
            }
            .buttonStyle(SBBButtonStyle(enabled: false))
            .previewDisplayName("Dark disabled")
            .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
