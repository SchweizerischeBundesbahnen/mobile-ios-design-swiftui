//
// Copyright (c) Schweizerische Bundesbahnen SBB, 2026
//  
import SwiftUI

enum CollapsibleSnap {
    case close
    case open
    case closest
}

struct CollapsibleView<CollapsibleContent: View>: View {
    let collapsibleContent: CollapsibleContent
    let collapseType: CollapseType
    @Binding private var scrolled: CGFloat
    @Binding private var collapsibleSnap: CollapsibleSnap?
    
    @State private var collapsibleContentHeight: CGFloat = .zero
    @State private var referenceHeight: CGFloat = .zero // When scroll stopped
    @State private var currentHeight: CGFloat = .zero
    
    init(scrolled: Binding<CGFloat>, collapsibleSnap: Binding<CollapsibleSnap?>, collapsibleContent: CollapsibleContent, collapseType: CollapseType) {
        self._scrolled = scrolled
        self._collapsibleSnap = collapsibleSnap
        self.collapsibleContent = collapsibleContent
        self.collapseType = collapseType
    }
    
    var body: some View {
        collapsibleContent
            .padding(.horizontal, 16)
            .opacity(collapseProgress(currentHeight))
            .fixedSize(horizontal: false, vertical: true)
            .padding(.bottom, 16)
            .viewHeight($collapsibleContentHeight)
            .offset(y: collapseType == .slidesUp ? currentHeight - collapsibleContentHeight : 0)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: currentHeight, alignment: .top)
            .clipped()
        .onAppear {
            self.currentHeight = collapsibleContentHeight
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
                    self.currentHeight = collapsibleContentHeight
                }
            case .closest:
                withAnimation {
                    if self.currentHeight > collapsibleContentHeight / 2 {
                        self.currentHeight = collapsibleContentHeight
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
        let maxHeight = collapsibleContentHeight
        let scrollHeight = referenceHeight + scrolled
        let height = max(0, min(scrollHeight, maxHeight))
        return height
    }
    
    private func collapseProgress(_ currentHeight: CGFloat) -> CGFloat {
        let maxHeight = collapsibleContentHeight
        return currentHeight / maxHeight
    }
}
