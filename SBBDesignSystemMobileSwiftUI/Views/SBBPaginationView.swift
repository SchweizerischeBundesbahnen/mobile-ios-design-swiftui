//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/**
 A  View that indicates that there are multiple elements or pages, through which the user can navigate. Also highlights the currently selected element or page.
 
 ## Overview
 You create a SBBPaginationView by providing a currentPageIndex binding and the total number of pages:
 ```swift
 @State var currentPageIndex: Int = 0

 var body: some View {
    SBBPaginationView(currentPageIndex: $currentPageIndex, numberOfPages: 3)
 }
 ```
 ![SBBPaginationView](SBBPaginationView)
 */
public struct SBBPaginationView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding private var currentPageIndex: Int
    private let numberOfPages: Int
    private let selectedDoubleSize: Bool
    
    /**
     Returns a SBBPaginationView with a dot for every page.
     
     - Parameters:
        - currentPageIndex: Sets the current page's index state.
        - numberOfPages: The total number of pages.
        - selectedDoubleSize: Whether the selected page point is double the size of the other.
     */
    public init(currentPageIndex: Binding<Int>, numberOfPages: Int, selectedDoubleSize: Bool = false) {
        self._currentPageIndex = currentPageIndex
        self.numberOfPages = numberOfPages
        self.selectedDoubleSize = selectedDoubleSize
    }
    
    public var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<numberOfPages, id:\.self) { index in
                HStack {    // Workaround needed, so that the Circle-Views get reloaded after a currentPageIndex change, see https://developer.apple.com/forums/thread/131577
                    if index == self.currentPageIndex {
                        Circle()
                            .fill(colorScheme == .light ? Color.sbbColor(.primary) : Color.sbbColor(.white))
                            .frame(width: selectedDoubleSize ? 16 : 8, height: selectedDoubleSize ? 16 : 8)
                    } else if selectedDoubleSize {
                        Circle()
                            .fill(selectedDoubleSize ? Color.sbbColorInternal(.paginationInactive) : Color.clear)
                            .frame(width: 8, height: 8)
                    } else {
                        Circle()
                            .strokeBorder(Color.sbbColorInternal(.paginationInactive), lineWidth: 1.0)
                            .frame(width: 6, height: 8)
                    }
                }
            }
        }
        .accessibility(label: Text(String.localizedStringWithFormat(NSLocalizedString("Step %lld out of %lld", tableName: nil, bundle: Helper.bundle, value: "", comment: ""), currentPageIndex + 1, numberOfPages)))
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
