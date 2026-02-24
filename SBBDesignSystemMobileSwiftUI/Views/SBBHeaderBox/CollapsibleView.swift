//
// Copyright (c) Schweizerische Bundesbahnen SBB, 2025
//  

import SwiftUI

struct CollapsibleView<CollapsibleContent: View>: View {
    let minYParent: CGFloat
    let collapsibleContent: CollapsibleContent?
    
    @Binding var collapsibleContentHeight: CGFloat
    var isLoading: Bool
    
    @State private var offsetX: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                if let collapsibleContent = collapsibleContent {
                    collapsibleContent
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                        .opacity(1 - collapseProgress(in: geometry))
                } else {
                    Text("") // Keep the collapsible view anyway, as it is the bottom of the bubble view (in particular for background of additional content in corner radius)
                        .padding(16)
                }
                if isLoading {
                    GeometryReader { geometry in
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.clear, Color.sbbColor(.primary)]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 64, height: 2)
                            .offset(x: offsetX, y: geometry.size.height / 2)
                            .onAppear {
                                offsetX = 0
                                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                                    self.offsetX = geometry.size.width
                                }
                            }
                    }
                    .frame(height: 2)
                    .accessibilityHidden(true)
                }
            }
            .viewHeight($collapsibleContentHeight)
            .frame(maxWidth: .infinity, minHeight: collapsibleContentHeight, alignment: .leading)
            .background(Color.sbbColor(.viewBackground))
            .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
            .shadow(color: Color.sbbColor(.tabshadow), radius: 8)
            .offset(y: dynamicOffset(sticking: geometry, to: minYParent))
            .sbbScreenPadding(.horizontal)
        }
    }
    
    // Calculates the dynamic offset for sticking a view (inside a ScrollView) between the minYParent and maxYParent
    private func dynamicOffset(sticking geometry: GeometryProxy, to minParent: CGFloat) -> CGFloat {
        let minY = geometry.frame(in: .global).minY
        // The collapsible view should be underneath the content, but with the 16 bottom sticking out.
        let minYParent = minParent - collapsibleContentHeight + 16
        let maxYParent = minParent
        let limitTop = minY < minYParent ? minYParent - minY : nil
        let limitBottom = minY > maxYParent ? maxYParent - minY : nil
        return limitTop ?? limitBottom ?? 0
    }
    
    private func collapseProgress(in geometry: GeometryProxy) -> CGFloat {
        let minY = geometry.frame(in: .global).minY
        let minStickY = minYParent - collapsibleContentHeight
        let maxStickY = minYParent
        
        let totalRange = max(1, maxStickY - minStickY)
        let clampedY = min(max(minY, minStickY), maxStickY)
        return (maxStickY - clampedY) / totalRange
    }
}
