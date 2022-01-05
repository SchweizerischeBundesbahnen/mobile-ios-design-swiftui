//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

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
            .sbbScreenPadding()
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
