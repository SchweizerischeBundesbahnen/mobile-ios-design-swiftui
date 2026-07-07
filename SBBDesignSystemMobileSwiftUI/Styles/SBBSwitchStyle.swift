//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/**
 A classic ToggleStyle in SBB style (red background)
 
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
                    .sbbFont(.medium_light)
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
        @StateObject private var onOffSwitchLabelSettings = OnOffSwitchLabelsSettings()
        
        func makeBody(configuration: Self.Configuration) -> some View {
            RoundedRectangle(cornerRadius: 16, style: .circular)
                .fill(isOn ? onColor : offColor)
                .frame(width: 50, height: 31)
                .overlay(
                    ZStack {
                        if onOffSwitchLabelSettings.enabled {
                            HStack {
                                Text("I")
                                    .sbbFont(.medium_light)
                                    .foregroundColor(.white)
                                    .opacity(isOn ? 1 : 0)
                                    .animation(.easeInOut(duration: 0.1), value: isOn)
                                    .accessibilityHidden(true)

                                Spacer()

                                Text("O")
                                    .sbbFont(.medium_light)
                                    .foregroundColor(.black)
                                    .opacity(isOn ? 0 : 1)
                                    .animation(.easeInOut(duration: 0.1), value: isOn)
                                    .accessibilityHidden(true)
                            }
                            .padding(.horizontal, 8)
                            .frame(width: 50)
                        }
                        RoundedRectangle(cornerRadius: 27 / 2, style: .circular)
                            .fill(thumbColor)
                            .frame(width: configuration.isPressed ? 33 : 27, height: 27)
                            .shadow(radius: 1, x: 0, y: 1)
                            .padding(2)
                            .offset(x: isOn ? configuration.isPressed ? 6.5 : 9.5 : configuration.isPressed ? -6.5 : -9.5)
                    }
                )
                        
                .animation(Animation.easeInOut(duration: 0.1), value: isOn)
                .opacity(isEnabled ? 1.0 : 0.5)
        }
    }
}
