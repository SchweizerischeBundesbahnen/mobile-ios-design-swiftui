//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension View {
    
    /**
     Applies SBB specific padding to a Screen (horizontal: 8, vertical: 16). You typically apply this ViewModifier to Views that cover the entire screen.
     - Parameters:
        - edges: The set of edges along which to pad this view.
     - Returns: A view with SBB specific padding on the specified edges.
     */
    func sbbScreenPadding(_ edges: Edge.Set = .all) -> some View {
        self.modifier(PaddingModifier(edges: edges))
    }
}

struct PaddingModifier: ViewModifier {
    
    let edges: Edge.Set
    
    let horizontalPadding: CGFloat = 8
    let verticalPadding: CGFloat = 16
    
    public func body(content: Content) -> some View {
        switch edges {
        case .all:
            content
                .padding(.horizontal, horizontalPadding)
                .padding(.vertical, verticalPadding)
        case .horizontal:
            content
                .padding(.horizontal, horizontalPadding)
        case .vertical:
            content
                .padding(.vertical, verticalPadding)
        case .leading:
            content
                .padding(.leading, horizontalPadding)
        case .trailing:
            content
                .padding(.trailing, horizontalPadding)
        case .top:
            content
                .padding(.top, verticalPadding)
        case .bottom:
            content
                .padding(.bottom, verticalPadding)
        default:
            content
        }
    }
}
