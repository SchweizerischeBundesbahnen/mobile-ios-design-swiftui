//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct PaginationViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @State var currentPageIndex: Int = 0
    let numberOfPages = 4
    
    var body: some View {
        VStack(spacing: 16) {
            SBBPaginationView(currentPageIndex: $currentPageIndex, numberOfPages: numberOfPages)
            SBBDivider()
            HStack {
                Button(action: {
                    self.currentPageIndex = (self.currentPageIndex + self.numberOfPages - 1) % 4
                }) {
                    Image("chevron_small_right_45_small")
                        .resizable()
                        .rotationEffect(Angle(degrees: 180))
                }
                    .buttonStyle(SBBIconButtonStyle(size: .small))
                Button(action: {
                    self.currentPageIndex = (self.currentPageIndex + 1) % 4
                }) {
                    Image("chevron_small_right_45_small")
                        .resizable()
                }
                    .buttonStyle(SBBIconButtonStyle(size: .small))
            }
            Spacer()
        }
            .padding(16)
    }
}

struct PaginationViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PaginationViewDemo(colorScheme: .constant(.light))
            PaginationViewDemo(colorScheme: .constant(.dark))
        }
    }
}
