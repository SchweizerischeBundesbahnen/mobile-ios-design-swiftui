//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension View {
    func sbbModalContainer() -> some View {
            self.modifier(ModalViewContainer())
    }
}


struct ModalViewContainer: ViewModifier {
    
    @EnvironmentObject private var viewModel: SBBModalViewModel

    func body(content: Content) -> some View {
        content
            .overlay((viewModel.isPresented ? Color.black.opacity(0.5) : Color.clear).edgesIgnoringSafeArea(.all))
            .onTapGesture {
                if viewModel.isPresented {
                    viewModel.closeModal()
                }
            }
            .accessibilityElement(children: viewModel.isPresented ? .combine : .contain)
            .accessibility(hidden: viewModel.isPresented)
            .overlay(
                Group {
                    if viewModel.isPresented {
                        viewModel.content
                        .accessibility(addTraits: .isModal) // unfortunately, this doesn't seem to hide the sibling views in VoiceOver (SwiftUI bug?), so we still need to hide them manually by using .accessibility(hidden:)
                    }
                }
            )
    }
}
