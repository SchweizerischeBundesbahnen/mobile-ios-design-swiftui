//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2025.
//

import SwiftUI

public struct SBBCardView<Card: Equatable>: View {
    
    private let image: Image
    private let title: Text
    private let text: Text
    private let titleLineLimit: Int
    private let textLineLimit: Int
    private let bigTextLineLimit: Int
    private let textWidth: CGFloat?
    private let buttonWidth: CGFloat?
    private let canBeTried: Bool
    private let nextCard: Card?
    private let onNext: (Card?) -> Void
    @Binding private var showTrySheet: Bool
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.sizeCategory) private var sizeCategory
    
    
    public init(image: Image, title: Text, text: Text, titleLineLimit: Int = 1, textLineLimit: Int = 9, bigTextLineLimit: Int = 5, width: CGFloat? = nil, showTrySheet: Binding<Bool>,nextCard: Card?, onNext: @escaping (Card?) -> Void) {
        self.image = image
        self.title = title
        self.text = text
        self.titleLineLimit = titleLineLimit
        self.textLineLimit = textLineLimit
        self.bigTextLineLimit = bigTextLineLimit
        self.textWidth = width != nil ? 3 * width! / 4 : nil
        self.buttonWidth = width != nil ? width! / 4 : nil
        self.canBeTried = true
        self._showTrySheet = showTrySheet
        self.nextCard = nextCard
        self.onNext = onNext
    }
    
    public init(image: Image, title: Text, text: Text, titleLineLimit: Int = 1, textLineLimit: Int = 9, bigTextLineLimit: Int = 5, width: CGFloat? = nil, nextCard: Card?, onNext: @escaping (Card?) -> Void) {
        self.image = image
        self.title = title
        self.text = text
        self.titleLineLimit = titleLineLimit
        self.textLineLimit = textLineLimit
        self.bigTextLineLimit = bigTextLineLimit
        self.textWidth = width != nil ? 3 * width! / 4 : nil
        self.buttonWidth = width != nil ? width! / 4 : nil
        self.canBeTried = false
        self._showTrySheet = .constant(false)
        self.nextCard = nextCard
        self.onNext = onNext
    }
    
    private var imageView: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .accessibility(hidden: true)
    }
    
    private var nextButton: some View {
        Button(action: {
            withAnimation {
                onNext(nextCard)
            }
            UIAccessibility.post(notification: .screenChanged, argument: nil)   // reset voiceover focus (to the current card)
        }) {
            Text("next".localized)
        }
        .buttonStyle(SBBSecondaryButtonStyle(sizeToFit: !sizeCategory.isAccessibilityCategory && self.horizontalSizeClass == .compact && self.verticalSizeClass == .regular))
    }
    
    private var tryButton: some View {
        Button(action: {
            withAnimation {
                showTrySheet = true
            }
        }) {
            Text("try".localized)
        }
        .buttonStyle(SBBPrimaryButtonStyle(sizeToFit: !sizeCategory.isAccessibilityCategory && self.horizontalSizeClass == .compact && self.verticalSizeClass == .regular))
    }
    
    private var portraitView: some View {
        ZStack(alignment: .bottom) {
            VStack {
                imageView
                Spacer()
            }
            
            HStack(spacing: 0) {
                Spacer()
                VStack(spacing: 32) {
                    VStack(spacing: 16) {
                        title
                            .font(.sbbBold(size: sizeCategory.isAccessibilityCategory ? 20 : 30))
                            .foregroundColor(Color.sbbColor(.textBlack))
                            .multiline(alignment: .center, lineLimit: titleLineLimit)
                            .accessibility(addTraits: .isHeader)
                        text
                            .sbbFont(.medium_light)
                            .multiline(alignment: .center, lineLimit: textLineLimit)
                    }
                    
                    if sizeCategory.isAccessibilityCategory {
                        VStack(spacing: 8) {
                            if canBeTried {
                                tryButton
                            }
                            nextButton
                        }
                    } else {
                        HStack {
                            if canBeTried {
                                tryButton
                                Spacer()
                            }
                            nextButton
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
            .padding(.top, 24)
            .foregroundColor(.sbbColor(.textBlack))
            .background(Color.sbbColor(.viewBackground))
            .cornerRadius(16, corners: [.topLeft, .topRight])
            .shadow(color: Color.sbbColor(.tabshadow), radius: 20, x: 0, y: 0)
        }
    }
    
    private var landscapeView: some View {
            ZStack {
                VStack {
                    imageView
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    HStack(spacing: 0) {
                        Spacer()
                        VStack(spacing: 16) {
                            title
                                .font(.sbbBold(size: sizeCategory.isAccessibilityCategory ? 20 : 30))
                                .foregroundColor(Color.sbbColor(.textBlack))
                                .multiline(alignment: .center, lineLimit: 1)
                                .accessibility(addTraits: .isHeader)
                                
                            text
                                .sbbFont(.medium_light)
                                .multiline(alignment: .center, lineLimit: sizeCategory.isAccessibilityCategory ? bigTextLineLimit : textLineLimit)
                            
                        }
                        .padding(.leading, 32)
                        .frame(width: textWidth)
                        
                        VStack(spacing: 16) {
                            if canBeTried {
                                tryButton
                            }
                            nextButton
                        }
                        .padding(.leading, 16)
                        .padding(.trailing, 32)
                        .frame(width: buttonWidth)
                        Spacer()
                    }
                    .padding(.bottom, 32)
                    .padding(.top, 24)
                    .foregroundColor(.sbbColor(.textBlack))
                    .background(Color.sbbColor(.viewBackground))
                    .cornerRadius(16, corners: [.topLeft, .topRight])
                    .shadow(color: Color.sbbColor(.tabshadow), radius: 20, x: 0, y: 0)
                }
        }
    }
    
    public var body: some View {
        Group {
            if self.horizontalSizeClass == .compact && self.verticalSizeClass == .regular {
                portraitView
            } else {
                landscapeView
            }
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.sbbColor(.viewBackground))
    }
}

//#Preview("Without try function") {
//    SBBOnboardingCardWrapper<Int>(image: Image(sbbIcon: .unicorn_small), title: Text("Title"), text: Text("This is the content of the onboarding card."), titleLineLimit: 1, textLineLimit: 3, width: 300, nextCard: nil, onNext: { _ in })
//}
//
//#Preview("With try function") {
//    SBBOnboardingCardWrapper<Int>(image: Image(sbbIcon: .unicorn_small), title: Text("Title"), text: Text("This is the content of the onboarding card."), titleLineLimit: 1, textLineLimit: 3, width: 300, showTrySheet: .constant(true), nextCard: nil, onNext: { _ in })
//}
