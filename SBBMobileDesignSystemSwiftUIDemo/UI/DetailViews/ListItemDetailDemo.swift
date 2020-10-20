//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct ListItemDetailDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 16) {
                Text("Detail View of selected List Item")
                Spacer()
            }
            Spacer()
        }
            .padding(16)
            .navigationBarTitle("Detail View")
            .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.bottom))
            .colorScheme(colorScheme)
    }
}

struct ListItemDetailDemo_Previews: PreviewProvider {
    static var previews: some View {
        ListItemDetailDemo(colorScheme: .constant(.light))
    }
}
