//
// Copyright (c) Schweizerische Bundesbahnen SBB, 2025
//  

import SwiftUI

struct AdditionalView<AdditionalContent: View>: View {
    let topPadding: CGFloat
    let minYParent: CGFloat
    let additionalContent: AdditionalContent
    let backgroundColor: Color?
    @Binding var additionalContentHeight: CGFloat
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: topPadding)
                additionalContent
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .viewHeight($additionalContentHeight)
                    .frame(maxWidth: .infinity, minHeight: additionalContentHeight, alignment: .leading)
            }
            .background(backgroundColor != nil ? backgroundColor! : Color.sbbColor(colorScheme == .dark ? .midnight : .cloud))
            .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
            .offset(y: dynamicOffset(sticking: geometry, to: minYParent))
            .sbbScreenPadding(.horizontal)
            .shadow(color: Color.sbbColor(.tabshadow), radius: 5)
        }
    }
    
    // Calculates the dynamic offset for sticking a view (inside a ScrollView) between the minYParent and maxYParent
    private func dynamicOffset(sticking geometry: GeometryProxy, to minParent: CGFloat) -> CGFloat {
        let minY = geometry.frame(in: .global).minY
        let minYParent = minParent
        let maxYParent = minParent + topPadding
        let limitTop = minY < minYParent ? minYParent - minY : nil
        let limitBottom = minY > maxYParent ? maxYParent - minY : nil
        return limitTop ?? limitBottom ?? 0
    }
}
