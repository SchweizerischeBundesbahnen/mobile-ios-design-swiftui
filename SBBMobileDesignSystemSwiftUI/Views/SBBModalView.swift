//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBModalView<Content>: View where Content: View {

    private let title: Text
    @Binding private var isPresented: Bool
    private let content: Content

    public init(title: Text, isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self._isPresented = isPresented
        self.content = content()
    }
    
    public var body: some View {
        VStack {
            HStack {
                title
                Button(action: {
                    self.isPresented = false
                }) {
                    Text("close")
                }
            }
            content
        }
    }
}

struct SBBModalView_Previews: PreviewProvider {
    static var previews: some View {
        SBBModalView(title: Text("Modal View"), isPresented: .constant(true)) {
            Text("Custom content")
        }
    }
}
