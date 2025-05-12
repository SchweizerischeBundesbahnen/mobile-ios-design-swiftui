//
// Copyright (c) Schweizerische Bundesbahnen SBB, 2025
//

import SwiftUI

/**
 A ToggleStyle in SBB style (red background)
 
 ## Overview
 You create a normal Toggle and apply the .toggleStyle() ViewModifier:
 ```swift
 @State var isOn = true
 var body: some View {
     Toggle("", isOn: $isOn)
        .toggleStyle(SBBSwitchButtonStyle())
 }
 ```
 The label of the toggle is ignored, as this is the button only.
 Use SBBSwitchItem when using a label.
 
 ![SBBSwitchButtonStyle](SBBSwitchButtonStyle)
 */
public struct SBBSwitchButtonStyle: ToggleStyle {
    /**
     Returns a Toggle in SBB switch style (red background).
     */
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        SBBToggle(configuration: configuration)
    }
    
    private struct SBBToggle: View {
        let configuration: ToggleStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        var body: some View {
            Button("", action: {
                configuration.isOn.toggle()
            })
                .buttonStyle(SwitchButtonStyle(isOn: configuration.isOn))
        }
    }
    
    // https://developer.apple.com/documentation/swiftui/switchtogglestyle
    // SwitchToggleStyle does not allow to change the color in disabled mode
    private struct SwitchButtonStyle: ButtonStyle {
        var onColor: Color {
            Color.sbbColor(.primary).opacity(isEnabled ? 1.0 : 0.5)
        }
        var offColor: Color {
            Color.sbbColor(.graphite).opacity(isEnabled ? 1.0 : 0.5)
        }
        var borderColor: Color {
            Color.sbbColor(isOn ? .primary : .granite).opacity(isEnabled ? 1.0 : 0.5)
        }
        var isOn: Bool
        
        @Environment(\.isEnabled) private var isEnabled: Bool
        @Environment(\.colorScheme) var colorScheme
        
        func makeBody(configuration: Self.Configuration) -> some View {
            RoundedRectangle(cornerRadius: 16, style: .circular)
                .fill(isOn ? onColor : offColor)
                .frame(width: 52, height: 20)
                .overlay(
                    ZStack {
                        Circle()
                            .foregroundColor(Color.sbbColor(.white))
                            .shadow(color: Color.sbbColor(.shadow).opacity(0.3), radius: 2, x: 0, y: 0)
                        Circle()
                            .strokeBorder(borderColor, lineWidth: 1)
                        
                        if isOn {
                            Image(sbbIcon: .tick_small)
                                .foregroundColor(borderColor)
                                .accessibilityHidden(true)
                        }
                    }
                        .frame(width: 28, height: 28)
                        .offset(x: isOn ? 12 : -12)
                )
                .frame(width: 52, height: 28)
                .animation(Animation.easeInOut(duration: 0.1), value: isOn)
        }
    }
}
