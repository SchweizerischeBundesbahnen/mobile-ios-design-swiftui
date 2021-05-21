//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct BannerDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @EnvironmentObject var model: BannerViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            SBBFormGroup(title: "Banner type") {
                SBBRadioButton(isOn: $model.none, label: "None")
                SBBRadioButton(isOn: $model.dev, label: "dev")
                    .sbbEnvironmentBanner(.dev)
                SBBRadioButton(isOn: $model.test, label: "test")
                    .sbbEnvironmentBanner(.test)
                SBBRadioButton(isOn: $model.int, label: "int")
                    .sbbEnvironmentBanner(.int)
                SBBRadioButton(isOn: $model.poc, label: "poc", showBottomLine: false)
                    .sbbEnvironmentBanner(.poc)
            }
            Spacer()
        }
        .sbbFont(.body)
        .padding(16)
        .navigationBarTitle("Banner")
        .navigationBarItems(trailing: SBBNavigationBarSBBIcon())
        .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.bottom))
        .colorScheme(colorScheme)
    }
}

struct BannerDemo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BannerDemo(colorScheme: .constant(.light))
            BannerDemo(colorScheme: .constant(.dark))
        }
            .environmentObject(BannerViewModel())
    }
}
