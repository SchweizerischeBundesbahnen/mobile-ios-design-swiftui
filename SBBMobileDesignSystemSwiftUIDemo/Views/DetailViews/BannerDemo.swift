//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct BannerDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @Binding var selectedBanner: SBBEnvironmentBanner
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            SBBRadioButtonGroup(title: "Banner type", selection: $selectedBanner, tags: SBBEnvironmentBanner.allCases) {
                SBBRadioButton(label: "None")
                    .sbbEnvironmentBanner(.none)
                SBBRadioButton(label: "test")
                    .sbbEnvironmentBanner(.test)
                SBBRadioButton(label: "dev")
                    .sbbEnvironmentBanner(.dev)
                SBBRadioButton(label: "int")
                    .sbbEnvironmentBanner(.int)
                SBBRadioButton(label: "poc", showBottomLine: false)
                    .sbbEnvironmentBanner(.poc)
            }
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 16)
        .navigationBarTitle("Banner")
        .sbbStyle()
        .colorScheme(colorScheme)
    }
}

struct BannerDemo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BannerDemo(colorScheme: .constant(.light), selectedBanner: .constant(.none))
            BannerDemo(colorScheme: .constant(.dark), selectedBanner: .constant(.none))
        }
    }
}
