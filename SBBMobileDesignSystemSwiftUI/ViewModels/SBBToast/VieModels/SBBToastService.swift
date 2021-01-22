//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public class SBBToastService: ObservableObject {
    
    @Published var toasts: [SBBToast]
    
    public init() {
        self.toasts = [SBBToast]()
    }
    
    // initializer for SwiftUI Previews
    init(toasts: [SBBToast]) {
        self.toasts = toasts
    }

    public func showToast(_ toast: SBBToast) {
        toasts.append(toast)
    }
    
    func removeToast(_ toast: SBBToast) {
        toasts.removeAll(where: { $0.id == toast.id })
    }
}
