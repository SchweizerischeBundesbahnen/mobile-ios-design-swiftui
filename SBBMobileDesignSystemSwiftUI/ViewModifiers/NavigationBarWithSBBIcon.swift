//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public extension View {
    func navigationBarWithSBBIcon(onTouchAction: (() -> ())? = nil) -> some View {
        self
            .navigationBarItems(trailing:
                Button(action: {
                    onTouchAction?()
                }) {
                    Image("sbb-logo-small", bundle: Helper.bundle)
                        .resizable()
                        .frame(width: 28, height: 14, alignment: .top)
                        .foregroundColor(SBBColor.textWhite)
                }
            )
    }
}
