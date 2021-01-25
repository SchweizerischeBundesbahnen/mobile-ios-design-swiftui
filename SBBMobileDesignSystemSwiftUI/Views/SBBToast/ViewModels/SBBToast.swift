//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public class SBBToast: Identifiable, ObservableObject {
    
    public let id = UUID()
    let label: Text
    let easeInOutAnimationDuration: Double
    let presentedDuration: Double
    
    @Published var isPresented = false
    
    public init(label: Text, easeInOutAnimationDuration: Double = 1, presentedDuration: Double = 2) {
        self.label = label
        self.easeInOutAnimationDuration = easeInOutAnimationDuration
        self.presentedDuration = presentedDuration
    }
    
    // initializer for SwiftUI Previews
    init(label: Text, isPresented: Bool) {
        self.label = label
        self.easeInOutAnimationDuration = 1
        self.presentedDuration = 2
        self.isPresented = isPresented
    }
}
