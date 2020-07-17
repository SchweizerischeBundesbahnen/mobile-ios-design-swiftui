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
        VStack(spacing: 16) {
            HStack {
                title
                    .sbbFont(.titleModul)
                Spacer()
                Button(action: {
                    self.isPresented = false
                }) {
                    Image("cross_104_small", bundle: Helper.bundle)
                }
                    .buttonStyle(SBBIconButtonStyle(size: .small))
            }
            content
        }
            .padding(16)
    }
}

struct SBBModalView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBModalView(title: Text("Modal View"), isPresented: .constant(true)) {
                Text("Custom content")
            }
                .previewDisplayName("Light")
            SBBModalView(title: Text("Modal View"), isPresented: .constant(true)) {
                Text("Custom content")
            }
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}
