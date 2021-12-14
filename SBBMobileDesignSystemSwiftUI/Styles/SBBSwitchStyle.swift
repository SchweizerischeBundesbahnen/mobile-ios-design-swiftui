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
            Toggle<ToggleStyleConfiguration.Label>(isOn: configuration.$isOn, label: { configuration.label })
                .toggleStyle(SwitchToggleStyle(tint: .sbbColor(.primary)))
        }
    }
}
