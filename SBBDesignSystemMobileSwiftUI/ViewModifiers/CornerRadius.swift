//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public extension View {
    /**
     Clips this view to its bounding frame, with the specified corner radius in the specified corners.
     
     - Parameters:
        - radius: The corner radius to apply to the specified corners.
        - corners: The corners to which the specified corner radius should be applied.
     
     - Returns: A view that clips this view to its bounding frame with the specified corner radius in the specified corners.
     */
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
