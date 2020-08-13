//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct IconDemo: View {
    
    @State var fplIconName: String = "product-ir-40"
    @State var komIconName: String = "station"
    
    @Binding var colorScheme: ColorScheme
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                SBBInfoView(image: Image(sbbName: "circle-information", size: .small), text: Text("There are 2 different types of SBB Icons: FPL icons are only available in one size and have a fixed color. KOM icons are available in up to three sizes and inherit the foreground color."))
                SBBFormGroup(title: "Fahrplan Icons (FPL):") {
                    SBBTextField(text: self.$fplIconName, label: "Icon Name")
                    HStack {
                        Spacer()
                        Image(sbbName: self.fplIconName)
                        Spacer()
                    }
                        .padding(16)
                    Button(action: {
                        guard let url = URL(string: "https://digital.sbb.ch/brand_elemente/fahrplan-icons"),
                            UIApplication.shared.canOpenURL(url) else {
                            return
                        }
                        UIApplication.shared.open(url)
                    }) {
                        Text("See all available FPL icons")
                    }
                        .buttonStyle(SBBSecondaryButtonStyle())
                        .padding(16)
                    
                }
                SBBFormGroup(title: "Allgemeine Icons (KOM):") {
                    SBBTextField(text: self.$komIconName, label: "Icon Name")
                    HStack(alignment: .bottom) {
                        Spacer()
                        VStack {
                            Image(sbbName: self.komIconName, size: .small)
                            Text("small")
                        }
                        Spacer()
                        VStack {
                            Image(sbbName: self.komIconName, size: .medium)
                            Text("medium")
                        }
                        Spacer()
                        VStack {
                            Image(sbbName: self.komIconName, size: .large)
                            Text("large")
                        }
                        Spacer()
                    }
                        .sbbFont(.legend)
                        .padding(16)
                    Button(action: {
                        guard let url = URL(string: "https://digital.sbb.ch/brand_elemente/icons"),
                            UIApplication.shared.canOpenURL(url) else {
                            return
                        }
                        UIApplication.shared.open(url)
                    }) {
                        Text("See all available KOM icons")
                    }
                        .buttonStyle(SBBSecondaryButtonStyle())
                        .padding(16)
                }
                Spacer()
            }
                .padding(16)
        }
            .navigationBarTitle("Icons")
            .background(SBBColor.background.edgesIgnoringSafeArea(.bottom))
            .colorScheme(colorScheme)
    }
}

struct IconDemo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IconDemo(colorScheme: .constant(.light))
                .previewDisplayName("Light")
            IconDemo(colorScheme: .constant(.dark))
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
