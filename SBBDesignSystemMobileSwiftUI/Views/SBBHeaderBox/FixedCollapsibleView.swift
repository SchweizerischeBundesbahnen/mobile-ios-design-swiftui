//
// Copyright (c) Schweizerische Bundesbahnen SBB, 2025
//  
import SwiftUI

struct FixedCollapsibleView<CollapsibleContent: View, NonCollapsibleContent: View>: View {
    let minYParent: CGFloat
    let collapsibleContent: CollapsibleContent?
    let nonCollapsibleContent: NonCollapsibleContent?
    
    @Binding var collapsibleContentHeight: CGFloat
    @Binding var nonCollapsibleContentHeight: CGFloat
    var isLoading: Bool
    
    @State private var offsetX: CGFloat = 0
    
    var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer(minLength: computeTopSpacing(sticking: geometry, to: minYParent))
                        VStack(spacing: 0) {
                            if let collapsibleContent = collapsibleContent {
                                collapsibleContent
                                    .padding(.horizontal, 16)
                                    .opacity(1 - collapseProgress(in: geometry))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .viewHeight($collapsibleContentHeight)
                                    .padding(.bottom, nonCollapsibleContent == nil ? 16 : 0)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: visibleHeight(in: geometry), alignment: .top)
                                    .clipped()
                                
                                if let nonCollapsibleContent {
                                    nonCollapsibleContent
                                        .padding(.horizontal, 16)
                                        .viewHeight($nonCollapsibleContentHeight)
                                        .padding(.bottom, 16)
                                }
                            } else {
                                Text("")
                                    .padding(16)
                            }
                        }
                        .padding(.top, 32) // Corner radius 16 can only be done if >= 32 so add padding + offset.
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
                .background(Color.sbbColor(.viewBackground))
                .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
                .shadow(color: Color.sbbColor(.tabshadow), radius: 8)
                .sbbScreenPadding(.horizontal)
                .offset(y: dynamicOffset(sticking: geometry, to: minYParent))
            }
            .frame(height: collapsibleContentHeight + nonCollapsibleContentHeight > 0 ? collapsibleContentHeight + nonCollapsibleContentHeight : nil)
    }
    
    // Calculates the dynamic offset for sticking a view (inside a ScrollView) to minParent.
    private func dynamicOffset(sticking geometry: GeometryProxy, to minParent: CGFloat) -> CGFloat {
        let minY = geometry.frame(in: .global).minY
        let limitBottom = minY > minParent ? minParent - minY - 32 : nil
        return limitBottom ?? -32
    }
    
    private func computeTopSpacing(sticking geometry: GeometryProxy, to minParent: CGFloat) -> CGFloat {
        let minY = geometry.frame(in: .global).minY
        return max(0, minParent - minY)
    }
    
    // Calculates the visible height of the collapsible view.
    private func visibleHeight(in geometry: GeometryProxy) -> CGFloat {
        let full = max(1, collapsibleContentHeight + 16)
        let progress = collapseProgress(in: geometry)
        // Always keep 16 sticking out - corner radius.
        let visible = max(nonCollapsibleContent == nil ? 16 : 0, full * (1 - progress))
        return visible
    }
    
    private func collapseProgress(in geometry: GeometryProxy) -> CGFloat {
        let currentMinY = geometry.frame(in: .global).minY
        let minStickY = minYParent - collapsibleContentHeight - 16
        let maxStickY = minYParent
        let totalRange = max(1, maxStickY - minStickY)
        let clamped = min(max(currentMinY, minStickY), maxStickY)
        return (maxStickY - clamped) / totalRange
    }
}
