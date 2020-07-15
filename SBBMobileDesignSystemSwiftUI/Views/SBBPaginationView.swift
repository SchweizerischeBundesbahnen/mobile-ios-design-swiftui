//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBPaginationView: View {
    
    @Binding public var currentPageIndex: Int
    public var numberOfPages: Int
    
    public var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<numberOfPages) { index in
                if index == self.currentPageIndex {
                    Circle()
                        .fill(SBBColor.textBlack)
                        .frame(width: 8, height: 8)
                }
                Circle()
                    .fill(SBBColor.paginationInactive)
                    .frame(width: 4, height: 4)
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
