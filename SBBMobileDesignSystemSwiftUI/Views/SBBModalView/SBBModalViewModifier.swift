//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension View {
    func sbbModal<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        ModalView(isPresented: isPresented, content: content, presentingView: self)
    }
}

struct ModalView<PresentingView: View, ModalViewContent: View>: View {
    
    @EnvironmentObject var partialSheetManager: SBBModalViewModel
    
    @Binding var isPresented: Bool
    let content: () -> ModalViewContent
    let presentingView: PresentingView
    
    @State var model = Model()

    var body: some View {
        if model.update(value: isPresented) {
            DispatchQueue.main.async(execute: updateContent)
        }
        return presentingView
    }
    
    func updateContent() {
        partialSheetManager.updateModal(isPresented: isPresented, content: content, onDismiss: {
            self.isPresented = false
        })
    }
    
    // hack around .onChange not being available in iOS13
    class Model {
        private var savedValue: Bool?
        func update(value: Bool) -> Bool {
            guard value != savedValue else { return false }
            savedValue = value
            return true
        }
    }
}

