//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/**
 A  View to visually seaparate different content.
 
 ## Overview
 You create a SBBDivider like so:
 ```swift
 var body: some View {
    SBBDivider()
 }
 ```
 ![SBBDivider](SBBDivider)
 */
public struct SBBDivider: View {
    
    /**
     Initializes a new SBBDivider.
     
     - Returns: A SBBDivider.
     */
    public init() {}
    
    public var body: some View {
        Rectangle()
            .fill(Color.sbbColor(.divider))
            .frame(height: 1)
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
