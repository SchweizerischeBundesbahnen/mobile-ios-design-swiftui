//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBOnboardingTitleViewModel {
    let image: Image
    let title: Text
    
    public init(image: Image, title: Text) {
        self.image = image
        self.title = title
    }
}
