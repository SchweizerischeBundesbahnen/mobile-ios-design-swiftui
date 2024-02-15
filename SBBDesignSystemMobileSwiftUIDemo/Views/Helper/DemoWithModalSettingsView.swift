//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct DemoWithModalSettingsView<Demo: View, Settings: View>: View {
    @Binding var colorScheme: ColorScheme
    let demoTitle: String
    let demoView: Demo
    let settingsView: Settings
    let onClose: (() ->())?
    @State private var showSettings: Bool = false
    
    init(colorScheme: Binding<ColorScheme>, demoTitle: String, demoView: Demo, settingsView: Settings, onClose: (() ->())? = nil) {
        self._colorScheme = colorScheme
        self.demoTitle = demoTitle
        self.demoView = demoView
        self.settingsView = settingsView
        self.onClose = onClose
    }
    
    var body: some View {
        ZStack {
            demoView
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showSettings = true
                    }) {
                        Image(sbbIcon: .controls_medium)
                    }
                    .buttonStyle(SBBIconButtonStyle())
                    .padding(10)
                }
                Spacer()
            }
        }
        .navigationBarTitle(demoTitle)
        .sbbStyle()
        .colorScheme(colorScheme)
        .sbbModal(isPresented: $showSettings) {
            SBBModalView(title: Text("Settings"), style: .bottom, isPresented: $showSettings) {
                settingsView
                    .sbbStyle()
                    .padding(10)
                    .padding(.bottom, 16)
            }
            .colorScheme(colorScheme)
        }
        .onChange(of: showSettings) { value in
            if !value {
                onClose?()
            }
        }
    }
}
