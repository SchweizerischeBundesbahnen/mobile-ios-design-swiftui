//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBPaginationView: View {
    
    @Binding private var currentPageIndex: Int
    private var numberOfPages: Int
    
    public init(currentPageIndex: Binding<Int>, numberOfPages: Int) {
        self._currentPageIndex = currentPageIndex
        self.numberOfPages = numberOfPages
    }
    
    public var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<numberOfPages) { index in
                HStack {    // Workaround needed, so that the Circle-Views get reloaded after a currentPageIndex change, see https://developer.apple.com/forums/thread/131577
                    if index == self.currentPageIndex {
                        Circle()
                            .fill(SBBColor.textBlack)
                            .frame(width: 8, height: 8)
                    } else {
                        Circle()
                            .fill(SBBColor.paginationInactive)
                            .frame(width: 4, height: 4)
                    }
                }
            }
        }
    }
}

struct SBBPaginationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBPaginationView(currentPageIndex: .constant(0), numberOfPages: 4)
                .previewDisplayName("light")
            SBBPaginationView(currentPageIndex: .constant(2), numberOfPages: 4)
                .previewDisplayName("dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}
