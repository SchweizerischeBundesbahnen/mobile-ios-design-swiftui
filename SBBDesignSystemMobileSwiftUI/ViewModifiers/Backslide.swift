//
// Copyright (c) Schweizerische Bundesbahnen SBB, 2025
//  

import SwiftUI

extension AnyTransition {
    public static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))}
}
