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
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .navigationBarTitle("Detail View")
            .sbbStyle()
            .colorScheme(colorScheme)
    }
}

struct ListItemDetailDemo_Previews: PreviewProvider {
    static var previews: some View {
        ListItemDetailDemo(colorScheme: .constant(.light))
    }
}
