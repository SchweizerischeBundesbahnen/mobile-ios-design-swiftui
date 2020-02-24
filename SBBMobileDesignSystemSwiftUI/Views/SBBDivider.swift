//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBDivider: View {
    
    public init() {}
    
    public var body: some View {
        Rectangle()
            .fill(SBBColor.divider)
            .frame(idealWidth: .infinity, minHeight: 1, maxHeight: 1)
    }
}

struct SBBDivider_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBDivider()
                .previewDisplayName("Title only")
            SBBDivider()
                .previewDisplayName("Detail dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}
