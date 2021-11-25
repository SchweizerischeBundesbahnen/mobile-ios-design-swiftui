//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/**
 A  View that indicates that there are multiple elements or pages, through which the user can navigate. Also highlights the currently selected element or page.
 
 ## Overview
 You create a SBBPaginationView by providing an currentPageIndex binding and the total number of pages:
 ```swift
 @State var currentPageIndex: Int = 0

 var body: some View {
    SBBPaginationView(currentPageIndex: $currentPageIndex, numberOfPages: 3)
 }
 ```
 ![SBBPaginationView.](SBBPaginationView)
 */
public struct SBBPaginationView: View {
    
    @Binding private var currentPageIndex: Int
    private var numberOfPages: Int
    
    /**
     Returns a SBBPaginationView with a dot for every page.
     
     - Parameters:
        - currentPageIndex: Sets the current page's index state.
        - numberOfPages: The total number of pages.
     */
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
                            .fill(Color.sbbColor(.textBlack))
                            .frame(width: 8, height: 8)
                    } else {
                        Circle()
                            .fill(Color.sbbColorInternal(.paginationInactive))
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
