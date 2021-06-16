//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension View {
    
    /**
     Shows a custom View (typically SBBModalView) above the entire screen. You also need to create a SBBModalViewModel injected as an EnvironmentObject and add the .sbbBodalContainer() ViewModifier on your main/root View.
     
     - Parameters:
        - isPresented: The state controlling whether the custom View passed as content is currently presented or hidden.
        - content: The custom content to be shown when presented (typically a SBBModalView).
     
     - Returns: A View containing the passed View with added presentable content above it.
     */
    func sbbModal<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        ModalView(isPresented: isPresented, content: content, presentingView: self)
    }
}

struct ModalView<PresentingView: View, ModalViewContent: View>: View {
    
    @EnvironmentObject var modalViewModel: SBBModalViewModel
    
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
        modalViewModel.updateModal(isPresented: isPresented, content: content, onDismiss: {
            self.isPresented = false
        })
    }
    
    // workaround: .onChange is not available in iOS13
    class Model {
        private var savedValue: Bool?
        func update(value: Bool) -> Bool {
            guard value != savedValue else { return false }
            savedValue = value
            return true
        }
    }
}

