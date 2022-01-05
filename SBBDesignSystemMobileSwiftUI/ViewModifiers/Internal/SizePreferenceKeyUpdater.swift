//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

struct SizePreferenceKeyUpdater: ViewModifier {
    private var sizeView: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: SizePreferenceKey.self, value: geometry.size)
        }
    }

    func body(content: Content) -> some View {
        content.background(sizeView)
    }
}
