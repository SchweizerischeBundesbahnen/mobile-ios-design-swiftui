//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2024.
//

import SwiftUI

public extension View {
    
    /**
     Shows a custom View (typically ``SBBFooterBox``) above the entire screen while blurring the View behind.
     
     - Parameters:
        - isPresented: The state controlling whether the custom View passed as content is currently presented or hidden.
        - content: The custom content to be shown when presented (typically a ``SBBFooterBox`).
     
     - Returns: A View containing the passed View with added presentable content above it.
     */
    func footer<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        FooterContainer(isPresented: isPresented, content: content, presentingView: self)
    }
}

fileprivate struct FooterContainer<PresentingView: View, ModalViewContent: View>: View {
        
    @Binding var isPresented: Bool
    let content: () -> ModalViewContent
    let presentingView: PresentingView

    var body: some View {
        ZStack(alignment: .bottom) {
            presentingView
                .accessibilityHidden(isPresented ? true : false)
            
            if isPresented {
                Rectangle()
                    .foregroundColor(Color.sbbColor(.iron).opacity(0.2)).edgesIgnoringSafeArea(.horizontal)
                    .accessibilityHidden(true)
                    .onTapGesture {
                        isPresented = false
                    }
                content()
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
