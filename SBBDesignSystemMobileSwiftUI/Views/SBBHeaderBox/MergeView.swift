//
// Copyright (c) Schweizerische Bundesbahnen SBB, 2026
//

import SwiftUI

struct MergeView<CollapsedContent: View, ExtendedContent: View>: View {
    let collapsedContent: CollapsedContent
    let extendedContent: ExtendedContent
    @Binding private var scrolled: CGFloat
    @Binding private var collapsibleSnap: CollapsibleSnap?
    
    @State private var collapsedContentHeight: CGFloat = .zero
    @State private var extendedContentHeight: CGFloat = .zero
    @State private var referenceHeight: CGFloat = .zero // When scroll stopped
    @State private var currentHeight: CGFloat = .zero
    
    init(scrolled: Binding<CGFloat>, collapsibleSnap: Binding<CollapsibleSnap?>, collapsedContent: CollapsedContent, extendedContent: ExtendedContent) {
        self._scrolled = scrolled
        self._collapsibleSnap = collapsibleSnap
        self.collapsedContent = collapsedContent
        self.extendedContent = extendedContent
    }
    
    /// The larger of the two content heights (the "open" height).
    private var maxContentHeight: CGFloat {
        max(collapsedContentHeight, extendedContentHeight)
    }
    
    /// The smaller of the two content heights (the "closed" height).
    private var minContentHeight: CGFloat {
        min(collapsedContentHeight, extendedContentHeight)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            collapsedContent
                .opacity(1 - collapseProgress(currentHeight))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 16)
                .viewHeight($collapsedContentHeight)
                .frame(maxWidth: .infinity)
                .frame(maxHeight: currentHeight, alignment: .top)
                .clipped()
            
            extendedContent
                .opacity(collapseProgress(currentHeight))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 16)
                .viewHeight($extendedContentHeight)
                .frame(maxWidth: .infinity)
                .frame(maxHeight: currentHeight, alignment: .top)
                .clipped()
        }
        .onAppear {
            self.currentHeight = maxContentHeight
            self.referenceHeight = currentHeight
        }
        .onChange(of: extendedContentHeight) { _ in
            self.currentHeight = maxContentHeight
            self.referenceHeight = currentHeight
        }
        .onChange(of: collapsedContentHeight) { _ in
            self.currentHeight = maxContentHeight
            self.referenceHeight = currentHeight
        }
        .onChange(of: scrolled) { _ in
            self.currentHeight = visibleHeight(scrolled)
        }
        .onChange(of: collapsibleSnap) { _ in
            switch collapsibleSnap {
            case .close:
                withAnimation {
                    self.currentHeight = minContentHeight
                }
            case .open:
                withAnimation {
                    self.currentHeight = maxContentHeight
                }
            case .closest:
                withAnimation {
                    if self.currentHeight > (maxContentHeight + minContentHeight) / 2 {
                        self.currentHeight = maxContentHeight
                    } else {
                        self.currentHeight = minContentHeight
                    }
                }
            default:
                break
            }
            self.referenceHeight = currentHeight // Set the new reference height
            self.collapsibleSnap = nil // Reset it so that it can be triggered on next
        }
    }
    
    // Calculates the visible height of the collapsible view.
    private func visibleHeight(_ scrolled: CGFloat) -> CGFloat {
        let scrollHeight = referenceHeight + scrolled
        return max(minContentHeight, min(scrollHeight, maxContentHeight))
    }
    
    /// Returns 0 when collapsed (show collapsedContent), 1 when extended (show extendedContent).
    private func collapseProgress(_ currentHeight: CGFloat) -> CGFloat {
        let heightDifference = abs(extendedContentHeight - collapsedContentHeight)
        // If heights are equal or not yet measured, show extended content
        guard heightDifference > 1, collapsedContentHeight > 0, extendedContentHeight > 0 else { return 1 }
        // Progress is based on how far currentHeight is from the smaller height toward the larger height
        let progress = (currentHeight - minContentHeight) / heightDifference
        return min(1, max(0, progress))
    }
}
