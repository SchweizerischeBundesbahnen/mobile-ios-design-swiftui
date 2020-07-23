//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBOnboardingCardView: View {
    
    private let image: Image?
    private let title: Text?
    private let text: Text?
    private let content: AnyView?
    let actionOnCardDisappear: (() -> ())?
    
    public init(image: Image? = nil, title: Text? = nil, text: Text? = nil, actionOnCardDisappear: (() -> ())? = nil) {
        self.image = image
        self.title = title
        self.text = text
        self.content = nil
        self.actionOnCardDisappear = actionOnCardDisappear
        
        UIScrollView.appearance().bounces = false
    }
    
    public init<Content: View>(image: Image? = nil, title: Text? = nil, text: Text? = nil, actionOnCardDisappear: (() -> ())? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.image = image
        self.title = title
        self.text = text
        self.content = AnyView(content())
        self.actionOnCardDisappear = actionOnCardDisappear
        
        UIScrollView.appearance().bounces = false
    }
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                if image != nil {
                    self.image!
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                VStack(spacing: 16) {
                    if title != nil {
                        title
                            .sbbFont(.titleDefault)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    if text != nil {
                        text
                            .sbbFont(.body)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    if content != nil {
                        content
                    }
                }
                    .foregroundColor(SBBColor.textBlack)
                    .padding(16)
            }
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
