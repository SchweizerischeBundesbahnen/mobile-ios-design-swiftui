//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct PaginationViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @State var currentPageIndex: Int = 0
    let numberOfPages = 4
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            SBBPaginationView(currentPageIndex: $currentPageIndex, numberOfPages: numberOfPages)
            Spacer()
            SBBDivider()
            HStack {
                Button(action: {
                    self.currentPageIndex = (self.currentPageIndex + self.numberOfPages - 1) % numberOfPages
                }) {
                    Image(sbbIcon: .chevron_small_right_small)
                        .resizable()
                        .rotationEffect(Angle(degrees: 180))
                }
                    .buttonStyle(SBBIconButtonStyle(size: .small))
                Button(action: {
                    self.currentPageIndex = (self.currentPageIndex + 1) % numberOfPages
                }) {
                    Image(sbbIcon: .chevron_small_right_small)
                        .resizable()
                }
                    .buttonStyle(SBBIconButtonStyle(size: .small))
            }
        }
            .sbbScreenPadding()
            .navigationBarTitle("Pagination")
            .sbbStyle()
            .colorScheme(colorScheme)
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
