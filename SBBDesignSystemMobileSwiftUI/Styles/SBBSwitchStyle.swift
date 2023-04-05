//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/**
 A ToggleStyle in SBB style (red background)
 
 ## Overview
 You create a normal Toggle and apply the .toggleStyle() ViewModifier:
 ```swift
 @State var isOn = true
 var body: some View {
     Toggle(isOn: $isOn) {
         Text("Label")
     }
        .toggleStyle(SBBSwitchStyle())
 }
 ```
 ![SBBSwitchStyle](SBBSwitchStyle)
 */
public struct SBBSwitchStyle: ToggleStyle {
    /**
     Returns a Toggle in SBB switch style (red background).
     */
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        SBBSwitch(configuration: configuration)
    }
    
    private struct SBBSwitch: View {
        let configuration: ToggleStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        var body: some View {
            HStack {
                configuration.label
                    .sbbFont(.body)
                Spacer()
                Button("", action: {
                    configuration.isOn.toggle()
                })
                    .buttonStyle(SwitchButtonStyle(isOn: configuration.isOn))
            }
        }
    }
    
    // https://developer.apple.com/documentation/swiftui/switchtogglestyle
    // SwitchToggleStyle does not allow to change the color in disabled mode
    private struct SwitchButtonStyle: ButtonStyle {
        var onColor = Color.sbbColor(.primary)
        var offColor: Color = Color.sbbColorInternal(.sliderSwitchInactive)
        var thumbColor = Color.sbbColor(.white)
        var isOn: Bool
        
        @Environment(\.isEnabled) private var isEnabled: Bool
        @Environment(\.colorScheme) var colorScheme
        
        func makeBody(configuration: Self.Configuration) -> some View {
            RoundedRectangle(cornerRadius: 16, style: .circular)
                .fill(isOn ? onColor : offColor)
                .frame(width: 50, height: 31)
                .overlay(
                    RoundedRectangle(cornerRadius: 27 / 2, style: .circular)
                        .fill(thumbColor)
                        .frame(width: configuration.isPressed ? 33 : 27, height: 27)
                        .shadow(radius: 1, x: 0, y: 1)
                        .padding(2)
                        .offset(x: isOn ? configuration.isPressed ? 6.5 : 9.5 : configuration.isPressed ? -6.5 : -9.5))
                        
                .animation(Animation.easeInOut(duration: 0.1))
                .opacity(isEnabled ? 1.0 : 0.5)
        }
    }
}
