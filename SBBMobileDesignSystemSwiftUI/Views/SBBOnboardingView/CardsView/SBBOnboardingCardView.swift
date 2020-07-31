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
    
    private var isCustomCard: Bool {
        return image == nil && title == nil && text == nil && content != nil
    }
    
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
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                if self.isCustomCard {
                    self.content
                } else {
                    ZStack(alignment: .top) {
                        if self.image != nil {
                            self.image!
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .accessibility(hidden: true)
                        }
                        VStack(spacing: 0) {
                            Spacer()
                                .frame(minHeight: 200, maxHeight: .infinity)
                            HStack(spacing: 0) {
                                Spacer()
                                VStack(spacing: 16) {
                                    if self.title != nil {
                                        self.title
                                            .sbbFont(.titleDefault)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .accessibility(addTraits: .isHeader)
                                    }
                                    if self.text != nil {
                                        self.text
                                            .sbbFont(.body)
                                            .multilineTextAlignment(.center)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                    if self.content != nil {
                                        self.content
                                    }
                                }
                                Spacer()
                            }
                                .padding(16)
                                .foregroundColor(SBBColor.textBlack)
                                .background(SBBColor.viewBackground)
                        }
                    }
                        .frame(minHeight: geometry.size.height)
                }
            }
                .background(SBBColor.viewBackground)
                .cornerRadius(16)
        }
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
                .previewDisplayName("Light, Normal Card with custom content")
            FakeSBBOnboardingCardViews.customCard
                .previewDisplayName("Dark, Custom Card")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.fixed(width: 300, height: 400))
    }
}
