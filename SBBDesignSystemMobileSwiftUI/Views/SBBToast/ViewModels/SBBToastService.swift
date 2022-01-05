//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

/// SBBToastService allows the presentation of SBBToast views inside the .sbbToastContainer() viewModifier.
public class SBBToastService: ObservableObject {
    
    @Published var toasts: [SBBToast]
    
    /**
     Returns a SBBToastService allowing the presentation SBBToast views.
     */
    public init() {
        self.toasts = [SBBToast]()
    }
    
    // initializer for SwiftUI Previews
    init(toasts: [SBBToast]) {
        self.toasts = toasts
    }

    /**
     Shows a SBBToast inside the .sbbToastContainer() ViewModifier.
     
     - Parameters:
        - toast: The SBBToast View to be presented
     */
    public func showToast(_ toast: SBBToast) {
        toasts.append(toast)
    }
    
    /**
     Instantaneously removes an already pressented SBBToast View. SBBToast Views are removed automatically after the defined presentation duration, this method allows to remove them sooner.
     
     - Parameters:
        - toast: The SBBToast View to be removed instantaneously.
     */
    func removeToast(_ toast: SBBToast) {
        toasts.removeAll(where: { $0.id == toast.id })
    }
}
