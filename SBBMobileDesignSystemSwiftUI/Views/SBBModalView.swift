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
                    .accessibility(addTraits: .isHeader)
                Spacer()
                Button(action: {
                    self.isPresented = false
                }) {
                    Image("cross_104_small", bundle: Helper.bundle)
                        .accessibility(label: Text("close"))
                }
                    .buttonStyle(SBBIconButtonStyle(size: .small))
            }
                .padding(16)
            content
        }
            .background(SBBColor.background.edgesIgnoringSafeArea(.bottom))
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
