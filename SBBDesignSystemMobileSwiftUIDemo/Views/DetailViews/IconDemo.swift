//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct IconDemo: View {
    
    @State var fplIconName: String = "product-ir-40"
    @State var komIconName: String = "station"
    @State var pictogramName: String = "Zug_r"
    
    @Binding var colorScheme: ColorScheme
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                SBBInfoView(image: Image(sbbIcon: .circle_information_small), text: Text("There are 3 different types of SBB Icons: FPL icons are only available in one size and have a fixed color. KOM icons are available in up to three sizes and inherit the foreground color. Pictograms are only available in one size and have a fixed color."))
                SBBFormGroup(title: "Fahrplan Icons (FPL):") {
                    HStack {
                        Spacer()
                        Image(sbbIcon: .ir_40)
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
                    HStack(alignment: .bottom) {
                        Spacer()
                        VStack {
                            Image(sbbIcon: .station_small)
                            Text("small")
                        }
                        Spacer()
                        VStack {
                            Image(sbbIcon: .station_medium)
                            Text("medium")
                        }
                        Spacer()
                        VStack {
                            Image(sbbIcon: .station_large)
                            Text("large")
                        }
                        Spacer()
                    }
                        .sbbFont(.small_light)
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
                SBBFormGroup(title: "Pictograms (Piktogramme):") {
                    HStack(alignment: .bottom) {
                        Spacer()
                        VStack {
                            Image(sbbIcon: .Zug_r)
                        }
                        Spacer()
                    }
                        .sbbFont(.small_light)
                        .padding(16)
                    Button(action: {
                        guard let url = URL(string: "https://digital.sbb.ch/de/brand_elemente/piktogramme"),
                            UIApplication.shared.canOpenURL(url) else {
                            return
                        }
                        UIApplication.shared.open(url)
                    }) {
                        Text("See all available pictograms")
                    }
                        .buttonStyle(SBBSecondaryButtonStyle())
                        .padding(16)
                }
                
                Spacer()
            }
                .sbbScreenPadding()
        }
            .navigationBarTitle("Icons")
            .sbbStyle()
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
