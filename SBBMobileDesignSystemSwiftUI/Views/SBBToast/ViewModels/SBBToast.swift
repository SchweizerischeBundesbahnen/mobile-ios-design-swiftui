//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

/// SBBToast will show a View displaying a status information at the bottom of the screen and automatically hiding it after a given duration. A new SBBToast can be presented by using SBBToastService.
public class SBBToast: Identifiable, ObservableObject {
    
    public let id = UUID()
    let label: Text
    let easeInOutAnimationDuration: Double
    let presentedDuration: Double
    
    @Published var isPresented = false
    
    
    /**
     Returns a SBBToast to be presented by using SBBToastService.
     
     - Parameters:
        - label: The Text to display in the toast.
        - easeInOutAnimationDuration: The duration of the ease-in and ease-out animation performed upon presenting/hiding a toast.
        - presentedDuration: The duration during which the toast is presented on screen
     */
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
