//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct ButtonDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var counter = 0
    @State private var disabled = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 8) {
                Group {
                    Button(action: increment) {
                        Text("My Primary Button")
                    }
                        .buttonStyle(SBBPrimaryButtonStyle())
                        .disabled(disabled)
                    Button(action: increment) {
                        Text("My Secondary Button")
                    }
                        .buttonStyle(SBBSecondaryButtonStyle())
                        .disabled(disabled)
                    Button(action: increment) {
                        Text("My Tertiary Large Button")
                    }
                        .buttonStyle(SBBTertiaryButtonStyle())
                        .disabled(disabled)
                    Button(action: increment) {
                        Text("My Tertiary Small Button")
                    }
                    .buttonStyle(SBBTertiaryButtonStyle(size: .small))
                        .disabled(disabled)
                    Button(action: increment) {
                        Image(sbbName: "station", size: .small)
                    }
                        .buttonStyle(SBBIconButtonStyle())
                        .disabled(disabled)
                    Button(action: increment) {
                        Image(sbbName: "station", size: .small)
                    }
                        .buttonStyle(SBBIconButtonStyle(size: .small))
                        .disabled(disabled)
                    Button(action: increment) {
                        Image(sbbName: "station", size: .small)
                    }
                        .buttonStyle(SBBIconButtonStyle(size: .small, style: .negative))
                        .disabled(disabled)
                        .background(Color.sbbColor(.red))
                    Button(action: increment) {
                        Image(sbbName: "station", size: .small)
                    }
                        .buttonStyle(SBBIconButtonStyle(showBorder: false))
                        .disabled(disabled)
                    Button(action: increment) {
                        Image(sbbName: "station", size: .small)
                    }
                        .buttonStyle(SBBIconButtonStyle(size: .small, showBorder: false))
                        .disabled(disabled)
                    Button(action: increment) {
                        VStack(alignment: .center, spacing: 4, content: {
                            Image(sbbName: "station", size: .large)
                            Text("Station")
                        })
                    }
                        .buttonStyle(SBBIconTextButtonStyle())
                        .disabled(disabled)
                }
                Text("Counter: \(counter)").padding()
                SBBCheckBox(isOn: $disabled, label: "Disabled", showTextFieldLine: false)
                Spacer()
            }
            .padding(16)
        }
        .navigationBarTitle("Buttons")
        .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.bottom))
        .colorScheme(colorScheme)
    }
    
    private func increment() {
        counter += 1
    }
}

struct ButtonDemo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ButtonDemo(colorScheme: .constant(.light))
            ButtonDemo(colorScheme: .constant(.dark))
        }
    }
}
