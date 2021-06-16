//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

/// A  SBB-Icon to be used as trailing NavigationBarItem with an optional onTouchAction.
public struct SBBNavigationBarSBBIcon: View {
    
    private let onTouchAction: (() -> ())?
    
    /**
     Initializes a new SBBNavigationBarSBBIcon.
     
     - Parameters:
        - onTouchAction: The optional action to execute on touch events on the SBBIcon.
     
     - Returns: A SBBNavigationBarSBBIcon.
     */
    public init(onTouchAction: (() -> ())? = nil) {
        self.onTouchAction = onTouchAction
    }
    
    public var body: some View {
            Button(action: {
                onTouchAction?()
            }) {
                Image("sbb-logo-small", bundle: Helper.bundle)
                    .resizable()
                    .frame(width: 28, height: 14, alignment: .top)
                    .foregroundColor(.sbbColor(.textWhite))
                    .padding(.bottom, 7)
            }
            .accessibility(hidden: onTouchAction == nil)
            .disabled(onTouchAction == nil)
    }
}

struct SBBNavigationBarSBBIcon_Previews: PreviewProvider {
    static var previews: some View {
        SBBNavigationBarSBBIcon()
    }
}
