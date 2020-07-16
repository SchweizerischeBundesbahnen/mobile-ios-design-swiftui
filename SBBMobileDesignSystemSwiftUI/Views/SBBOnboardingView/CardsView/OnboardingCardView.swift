//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct OnboardingCardView: View {
    
    private let image: Image
    private let title: Text
    private let text: Text
    
    public init(image: Image, title: Text, text: Text) {
        self.image = image
        self.title = title
        self.text = text
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
            }
                .padding(16)
        }
            .background(SBBColor.viewBackground)
            .cornerRadius(16)
    }
}

struct OnboardingCardView_Previews: PreviewProvider {
    
    static let image = FakeSBBOnboardingCardViewModels.card1.image
    static let title = FakeSBBOnboardingCardViewModels.card1.title
    static let text = FakeSBBOnboardingCardViewModels.card1.text
    
    static var previews: some View {
        Group {
            OnboardingCardView(image: image, title: title, text: text)
                .previewDisplayName("Light")
            OnboardingCardView(image: image, title: title, text: text)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.fixed(width: 300, height: 400))
    }
}
