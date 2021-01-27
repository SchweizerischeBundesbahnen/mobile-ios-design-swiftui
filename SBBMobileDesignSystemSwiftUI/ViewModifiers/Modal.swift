//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public extension View {
    func modal<ModalView: View>(isPresented: Binding<Bool>, @ViewBuilder modalBody: () -> ModalView) -> some View {
        ZStack {
            self
                .overlay(isPresented.wrappedValue ? Color.black.opacity(0.5) : Color.clear)
                .onTapGesture {
                    isPresented.wrappedValue = false
                }
                .accessibilityElement(children: isPresented.wrappedValue ? .combine : .contain)
                .accessibility(hidden: isPresented.wrappedValue)
            if isPresented.wrappedValue {
                modalBody()
                    .accessibility(addTraits: .isModal) // unfortunately, this doesn't seem to hide the sibling views in VoiceOver (SwiftUI bug?), so we still need to hide them manually by using .accessibility(hidden:)
            }
        }
    }
}

