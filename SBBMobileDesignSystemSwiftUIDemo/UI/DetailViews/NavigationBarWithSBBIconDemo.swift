//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct NavigationBarWithSBBIconDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var counter = 0
    @State private var disabled = true
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            SBBFormGroup(title: "Number of Clicks") {
                HStack {
                    Text("SBB Icon Button touched \(self.counter)x")
                        .sbbFont(.body)
                    Spacer()
                }
                .padding(16)
            }
            Spacer()
        }
        .padding(16)
        .navigationBarTitle("NavBar Icon")
        .navigationBarWithSBBIcon(onTouchAction: {
            self.counter += 1
        })
        .background(SBBColor.background.edgesIgnoringSafeArea(.bottom))
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
