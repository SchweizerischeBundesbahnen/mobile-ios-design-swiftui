//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct StatusDemo: View {
    @Binding var colorScheme: ColorScheme
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                SBBInfoView(image: Image(sbbIcon: .circle_information_small), text: Text("There are 4 different status: .alert, .warning, .success and .info"))
                
                VStack(alignment: .center) {
                    Text("Without text")
                    HStack(spacing: 16) {
                        Spacer()
                        SBBStatus(statusType: .alert, showText: false)
                        SBBStatus(statusType: .warning, showText: false)
                        SBBStatus(statusType: .success, showText: false)
                        SBBStatus(statusType: .info, showText: false)
                        Spacer()
                    }
                    
                    Text("With text")
                    SBBStatus(statusType: .alert)
                    SBBStatus(statusType: .warning)
                    SBBStatus(statusType: .success)
                    SBBStatus(statusType: .info)
                }
                
                Spacer()
            }
            .sbbScreenPadding()
        }
            .navigationBarTitle("Status")
            .sbbStyle()
            .colorScheme(colorScheme)
    }
}


struct StatusDemo_Previews: PreviewProvider {
    static var previews: some View {
        StatusDemo(colorScheme: .constant(.light))
        StatusDemo(colorScheme: .constant(.dark))
    }
}
