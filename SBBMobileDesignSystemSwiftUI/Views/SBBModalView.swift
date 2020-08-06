//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBModalView<Content>: View where Content: View {

    private let title: Text
    @Binding private var isPresented: Bool
    @Binding private var showBackButton: Bool
    private let actionOnBackButtonTouched: (() -> ())?
    private let content: Content

    public init(title: Text, isPresented: Binding<Bool>, showBackButton: Binding<Bool> = .constant(false), actionOnBackButtonTouched: (() -> ())? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self._isPresented = isPresented
        self._showBackButton = showBackButton
        self.actionOnBackButtonTouched = actionOnBackButtonTouched
        self.content = content()
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            HStack {
                if showBackButton {
                    Button(action: {
                        self.actionOnBackButtonTouched?()
                    }) {
                        Image(sbbName: "chevron-small-right", size: .small)
                            .rotationEffect(Angle(degrees: 180))
                            .accessibility(label: Text("back".localized))
                    }
                        .buttonStyle(SBBIconButtonStyle(size: .small))
                } else {
                    Spacer()
                        .frame(width: 32)
                }
                Spacer()
                title
                    .sbbFont(.titleModul)
                    .accessibility(addTraits: .isHeader)
                Spacer()
                Button(action: {
                    self.isPresented = false
                }) {
                    Image(sbbName: "cross", size: .small)
                        .accessibility(label: Text("close".localized))
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
            SBBModalView(title: Text("Modal View"), isPresented: .constant(true), showBackButton: .constant(true)) {
                Text("Custom content")
            }
                .previewDisplayName("Light, Back Button")
        }
            .previewLayout(.sizeThatFits)
    }
}
