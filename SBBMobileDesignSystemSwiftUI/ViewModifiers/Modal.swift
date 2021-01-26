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
            if isPresented.wrappedValue {
                modalBody()
            }
        }
    }
}

