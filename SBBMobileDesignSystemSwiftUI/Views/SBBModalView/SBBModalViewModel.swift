//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import Combine
import SwiftUI

public class SBBModalViewModel: ObservableObject {

    @Published var isPresented: Bool = false {
        didSet {
            if !isPresented {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { [weak self] in
                    self?.content = AnyView(EmptyView())
                    self?.onDismiss = nil
                }
            }
        }
    }
    @Published private(set) var content: AnyView
    private(set) var onDismiss: (() -> Void)?
    
    public init() {
        content = AnyView(EmptyView())
    }

    public func updateModal<T>(isPresented: Bool? = nil, content: (() -> T)? = nil, onDismiss: (() -> Void)? = nil) where T: View {
        if let content = content {
            self.content = AnyView(content())
        }
        if let onDismiss = onDismiss {
            self.onDismiss = onDismiss
        }
        if let isPresented = isPresented {
            withAnimation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0)) {
                self.isPresented = isPresented
            }
        }
    }

    public func closeModal() {
        withAnimation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0)) {
            self.isPresented = false
        }
        self.onDismiss?()
    }
}
