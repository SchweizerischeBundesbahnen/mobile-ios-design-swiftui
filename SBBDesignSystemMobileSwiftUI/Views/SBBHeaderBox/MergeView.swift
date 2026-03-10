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
    
    var body: some View {
        ZStack(alignment: .top) {
            collapsedContent
                .opacity(1 - collapseProgress(currentHeight))
                .padding(.bottom, 16)
                .viewHeight($collapsedContentHeight)
            
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
            self.currentHeight = extendedContentHeight
            self.referenceHeight = currentHeight
        }
        .onChange(of: extendedContentHeight) { _ in
            self.currentHeight = extendedContentHeight
            self.referenceHeight = currentHeight
        }
        .onChange(of: scrolled) { _ in
            self.currentHeight = visibleHeight(scrolled)
        }
        .onChange(of: collapsibleSnap) { _ in
            switch collapsibleSnap {
            case .close:
                withAnimation {
                    self.currentHeight = .zero
                }
            case .open:
                withAnimation {
                    self.currentHeight = extendedContentHeight
                }
            case .closest:
                withAnimation {
                    if self.currentHeight > extendedContentHeight / 2 {
                        self.currentHeight = extendedContentHeight
                    } else {
                        self.currentHeight = .zero
                    }
                }
            default:
                break
            }
            self.referenceHeight = currentHeight // Set the new reference height
            self.collapsibleSnap = nil // Reset it so that it can be trigger on next
        }
    }
    
    // Calculates the visible height of the collapsible view.
    private func visibleHeight(_ scrolled: CGFloat) -> CGFloat {
        let maxHeight = extendedContentHeight
        let minHeight = collapsedContentHeight
        let scrollHeight = referenceHeight + scrolled
        let height = max(minHeight, min(scrollHeight, maxHeight))
        return height
    }
    
    private func collapseProgress(_ currentHeight: CGFloat) -> CGFloat {
        let maxHeight = max(0, extendedContentHeight - collapsedContentHeight)
        let minHeight = collapsedContentHeight
        return (currentHeight - minHeight) / maxHeight
    }
}
