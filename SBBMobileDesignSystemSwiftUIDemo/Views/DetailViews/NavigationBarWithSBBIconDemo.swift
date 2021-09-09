//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct NavigationBarWithSBBIconDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var counter = 0
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            SBBFormGroup(title: "Number of Clicks") {
                HStack {
                    Text("SBB Icon Button touched \(self.counter)x")
                    Spacer()
                }
                .padding(16)
            }
            Spacer()
        }
        .sbbScreenPadding()
        .sbbStyle()
        .navigationBarTitle("NavBar Icon")
        .navigationBarItems(trailing: SBBNavigationBarSBBIcon(onTouchAction: {
            self.counter += 1
        }))
        .colorScheme(colorScheme)
    }
}

struct NavigationBarWithSBBIconDemo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationBarWithSBBIconDemo(colorScheme: .constant(.light))
            NavigationBarWithSBBIconDemo(colorScheme: .constant(.dark))
        }
    }
}
