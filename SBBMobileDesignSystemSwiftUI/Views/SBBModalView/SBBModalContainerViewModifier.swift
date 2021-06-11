//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension View {
    
    /**
     Allows modal views to be presented above the entire screen by using .sbbModalView modifier from anywhere in your view hierarchy. Needs to be applied to the main/root View.
     
     - Returns: A View containing the passed View with added presentable content above it.
     */
    func sbbModalContainer() -> some View {
            self.modifier(ModalViewContainer())
    }
}


struct ModalViewContainer: ViewModifier {
    
    @EnvironmentObject private var viewModel: SBBModalViewModel

    func body(content: Content) -> some View {
        content
            .overlay(
                Group {
                    if viewModel.isPresented {
                        Color.black.opacity(0.5)
                            .onTapGesture {
                                if viewModel.isPresented {
                                    viewModel.closeModal()
                                }
                            }
                    } else {
                        Color.clear
                    }
                }
                    .edgesIgnoringSafeArea(.all)
            )
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
