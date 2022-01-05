//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct BannerDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @Binding var selectedBanner: SBBEnvironmentBanner
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            SBBRadioButtonGroup(title: "Banner type", selection: $selectedBanner, tags: SBBEnvironmentBanner.allCases) {
                SBBRadioButton(text: Text("None"))
                    .sbbEnvironmentBanner(.none)
                SBBRadioButton(text: Text("test"))
                    .sbbEnvironmentBanner(.test)
                SBBRadioButton(text: Text("dev"))
                    .sbbEnvironmentBanner(.dev)
                SBBRadioButton(text: Text("int"))
                    .sbbEnvironmentBanner(.int)
                SBBRadioButton(text: Text("poc"), showBottomLine: false)
                    .sbbEnvironmentBanner(.poc)
            }
            Spacer()
        }
        .sbbScreenPadding()
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
