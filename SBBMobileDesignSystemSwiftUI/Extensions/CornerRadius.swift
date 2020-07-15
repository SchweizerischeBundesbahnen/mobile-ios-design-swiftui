//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

// This View extension allows to apply cornerRadius only to certain corners (e.g. top left).
// Found in: https://stackoverflow.com/questions/56760335/round-specific-corners-swiftui

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
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
