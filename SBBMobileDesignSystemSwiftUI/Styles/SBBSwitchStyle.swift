//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBSwitchStyle: ToggleStyle {
    
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        SBBSwitch(configuration: configuration)
    }
    
    private struct SBBSwitch: View {
        
        let configuration: ToggleStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        
        var body: some View {
            if #available(iOS 14.0, *) {
                Toggle<ToggleStyleConfiguration.Label>(isOn: configuration.$isOn, label: { configuration.label })
                    .toggleStyle(SwitchToggleStyle(tint: SBBColor.red))
            } else {
                Toggle<ToggleStyleConfiguration.Label>(isOn: configuration.$isOn, label: { configuration.label })
            }
        }
    }
}
