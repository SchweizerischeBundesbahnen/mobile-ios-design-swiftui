//
// Copyright (c) Schweizerische Bundesbahnen SBB, 2025
//  

import SwiftUI

extension View {
    public func hspaced(_ alignment: HorizontalAlignment = .center) -> some View {
        return HStack {
            if alignment != .leading {
                Spacer()
            }
            self
            if alignment != .trailing {
                Spacer()
            }
        }
    }
    
    public func vspaced(_ alignment: VerticalAlignment = .center) -> some View {
        return VStack {
            if alignment != .top {
                Spacer()
            }
            self
            if alignment != .bottom {
                Spacer()
            }
        }
    }
}
