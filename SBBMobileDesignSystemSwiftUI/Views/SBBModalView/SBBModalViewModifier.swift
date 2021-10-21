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
        ModalViewContainer(isPresented: isPresented, content: content, presentingView: self)
    }
}

fileprivate struct ModalViewContainer<PresentingView: View, ModalViewContent: View>: View {
        
    @Binding var isPresented: Bool
    let content: () -> ModalViewContent
    let presentingView: PresentingView
    
    // Removes the background added when using .fullScreenCover() and appear animation, inspiration by https://stackoverflow.com/questions/64301041/swiftui-translucent-background-for-fullscreencover
    // Can be removed, once .fullScreenCover allows to select the appropriate appear/disappear animation
    struct BackgroundTransparentView: UIViewRepresentable {
        func makeUIView(context: Context) -> UIView {
            let view = UIView()
            DispatchQueue.main.async {
                view.superview?.superview?.backgroundColor = .clear
                view.superview?.superview?.layer.removeAllAnimations()
            }
            return view
        }

        func updateUIView(_ uiView: UIView, context: Context) {}
    }


    var body: some View {
        presentingView
            .fullScreenCover(isPresented: $isPresented) {
                ZStack {
                    Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            isPresented = false
                        }
                    content()
                }
                .background(BackgroundTransparentView())
            }
    }
}
