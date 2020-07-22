//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

// initializer without detail
public extension SBBOnboardingCardView where Content == AnyView {
    init(image: Image, title: Text, text: Text) {
        self.image = image
        self.title = title
        self.text = text
        self.content = nil
    }
}

public struct SBBOnboardingCardView<Content>: View where Content: View {
    
    private let image: Image
    private let title: Text
    private let text: Text
    private let content: Content?
    
    public init(image: Image, title: Text, text: Text, @ViewBuilder content: @escaping () -> Content) {
        self.image = image
        self.title = title
        self.text = text
        self.content = content()
    }
    
    public var body: some View {
        VStack {
            GeometryReader { geometry in
                self.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            }
            VStack(spacing: 16) {
                title
                    .sbbFont(.titleDefault)
                    .fixedSize(horizontal: false, vertical: true)
                text
                    .sbbFont(.body)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                if content != nil {
                    content
                }
            }
                .foregroundColor(SBBColor.textBlack)
                .padding(16)
        }
            .background(SBBColor.viewBackground)
            .cornerRadius(16)
    }
}

struct OnboardingCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            FakeSBBOnboardingCardViews.card1
                .previewDisplayName("Light")
            FakeSBBOnboardingCardViews.card1
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
            FakeSBBOnboardingCardViews.cardWithButton
                .previewDisplayName("Light, Card with custom content")
        }
            .previewLayout(.fixed(width: 300, height: 400))
    }
}
