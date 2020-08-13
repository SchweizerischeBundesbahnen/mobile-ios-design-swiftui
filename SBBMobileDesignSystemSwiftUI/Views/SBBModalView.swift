//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public enum SBBModalViewTitleAlignment {
    case leading
    case center
}

public struct SBBModalView<Content>: View where Content: View {

    private let title: Text
    private let titleAlignment: SBBModalViewTitleAlignment
    @Binding private var isPresented: Bool
    @Binding private var showBackButton: Bool
    private let actionOnBackButtonTouched: (() -> ())?
    private let content: Content

    public init(title: Text, titleAlignment: SBBModalViewTitleAlignment = .leading, isPresented: Binding<Bool>, showBackButton: Binding<Bool> = .constant(false), actionOnBackButtonTouched: (() -> ())? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.titleAlignment = titleAlignment
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
                } else if titleAlignment == .center {
                    Spacer()
                        .frame(width: 32)
                }
                if titleAlignment == .center {
                    Spacer()
                }
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
                .previewDisplayName("Light, leading alignment")
            SBBModalView(title: Text("Modal View"), isPresented: .constant(true)) {
                Text("Custom content")
            }
                .previewDisplayName("Dark, leading alignment")
                .environment(\.colorScheme, .dark)
            SBBModalView(title: Text("Modal View"), titleAlignment: .center, isPresented: .constant(true)) {
                Text("Custom content")
            }
                .previewDisplayName("Light, center alignment")
            SBBModalView(title: Text("Modal View"), titleAlignment: .center, isPresented: .constant(true), showBackButton: .constant(true)) {
                Text("Custom content")
            }
                .previewDisplayName("Light, Back Button")
        }
            .previewLayout(.sizeThatFits)
    }
}
