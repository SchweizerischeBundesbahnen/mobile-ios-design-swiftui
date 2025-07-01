//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2025.
//

import SwiftUI

public struct SBBCardView<Card: Equatable>: View {
    
    private let image: Image
    private let title: Text
    private let text: Text
    private let size: CGSize?
    private let canBeTried: Bool
    private let nextCard: Card?
    private let onNext: (Card?) -> Void
    @Binding private var showTrySheet: Bool
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.sizeCategory) private var sizeCategory
    
    private let contentWidthLandscape: CGFloat?
    private let buttonWidthLandscape: CGFloat?
    
    private let scrollViewHeight: CGFloat?
    
    public init(image: Image, title: Text, text: Text, size: CGSize? = nil, showTrySheet: Binding<Bool>, nextCard: Card?, onNext: @escaping (Card?) -> Void) {
        self.image = image
        self.title = title
        self.text = text
        self.size = size
        self.canBeTried = true
        self._showTrySheet = showTrySheet
        self.nextCard = nextCard
        self.onNext = onNext
        
        self.contentWidthLandscape = size?.width != nil ? 3 * size!.width / 4 : nil
        self.buttonWidthLandscape = size?.width != nil ? size!.width / 4 : nil
        self.scrollViewHeight = size?.width != nil ? size!.height - 54 - 16 : nil
    }
    
    public init(image: Image, title: Text, text: Text, size: CGSize? = nil, nextCard: Card?, onNext: @escaping (Card?) -> Void) {
        self.image = image
        self.title = title
        self.text = text
        self.size = size
        self.canBeTried = false
        self._showTrySheet = .constant(false)
        self.nextCard = nextCard
        self.onNext = onNext
        
        self.contentWidthLandscape = size?.width != nil ? 3 * size!.width / 4 : nil
        self.buttonWidthLandscape = size?.width != nil ? size!.width / 4 : nil
        self.scrollViewHeight = size?.width != nil ? size!.height - 54 - 16 : nil
    }
    
    @ViewBuilder
    private var imageView: some View {
        if !sizeCategory.isAccessibilityCategory {
            GeometryReader { geometry in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    .clipped()
                    .accessibility(hidden: true)
            }
        } else {
            Rectangle()
                .foregroundColor(Color.sbbColor(.background))
        }
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
    
    private var contentView: some View {
        VStack(spacing: 16) {
            title
                .font(.sbbBold(size: sizeCategory.isAccessibilityCategory ? 20 : 30))
                .foregroundColor(Color.sbbColor(.textBlack))
                .minimumScaleFactor(0.1)
                .multilineTextAlignment(.center)
                .accessibility(addTraits: .isHeader)
            text
                .sbbFont(.medium_light)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.1)
        }
    }
    
    @ViewBuilder
    private var dynamicPortraitContentView: some View {
        if sizeCategory.isAccessibilityCategory {
            ScrollView(showsIndicators: false) {
                contentView
                    .padding(.top, 24)
                    .padding(.bottom, 32 + (sizeCategory.isAccessibilityCategory ? 108 : 54))
            }
            .frame(height: scrollViewHeight)
        } else {
            contentView
                .padding(.top, 24)
                .padding(.bottom, 32 + (sizeCategory.isAccessibilityCategory ? 108 : 54))
        }
    }
    
    private var portraitView: some View {
        ZStack(alignment: .bottom) {
            VStack {
                imageView
                Spacer()
            }
            
            HStack(spacing: 0) {
                Spacer()
                ZStack(alignment: .bottom) {
                    dynamicPortraitContentView
                    
                    if sizeCategory.isAccessibilityCategory {
                        VStack(spacing: 8) {
                            if canBeTried {
                                tryButton
                            }
                            nextButton
                        }
                        .padding(.bottom, 16)
                    } else {
                        HStack {
                            if canBeTried {
                                tryButton
                                Spacer()
                            }
                            nextButton
                        }
                        .padding(.bottom, 16)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 32)
            .foregroundColor(.sbbColor(.textBlack))
            .background(Color.sbbColor(.viewBackground))
            .cornerRadius(16, corners: [.topLeft, .topRight])
            .shadow(color: Color.sbbColor(.tabshadow), radius: 20, x: 0, y: 0)
            .mask(Rectangle().padding(.top, -50))
        }
    }
    
    @ViewBuilder
    private var dynamicLandscapeContentView: some View {
        if sizeCategory.isAccessibilityCategory {
            ScrollView(showsIndicators: false) {
                contentView
                    .padding(.top, 24)
                    .padding(.bottom, 32)
            }
            .frame(height: scrollViewHeight)
            .padding(.horizontal, 48)
        } else {
            contentView
                .padding(.top, 24)
                .padding(.bottom, 32)
                .padding(.horizontal, 48)
        }
    }
    
    private var landscapeView: some View {
        ZStack(alignment: .bottom) {
            VStack {
                imageView
                Spacer()
            }
            
            HStack(spacing: 0) {
                Spacer()
                
                HStack(spacing: 0) {
                    dynamicLandscapeContentView
                        .frame(width: contentWidthLandscape)
                    
                    VStack(spacing: 16) {
                        if canBeTried {
                            tryButton
                        }
                        nextButton
                    }
                    .padding(.horizontal, 24)
                    .padding(.trailing, 24)
                }
                Spacer()
            }
            .foregroundColor(.sbbColor(.textBlack))
            .background(Color.sbbColor(.viewBackground))
            .cornerRadius(16, corners: [.topLeft, .topRight])
            .shadow(color: Color.sbbColor(.tabshadow), radius: 20, x: 0, y: 0)
            .mask(Rectangle().padding(.top, -50))
        }
    }
    
    public var body: some View {
        Group {
            if self.horizontalSizeClass == .compact && self.verticalSizeClass == .regular {
                portraitView
                    .edgesIgnoringSafeArea([.top, .horizontal])
            } else {
                landscapeView
                    .edgesIgnoringSafeArea(.all)
            }
        }
        
        .background(Color.sbbColor(.viewBackground).edgesIgnoringSafeArea(.all))
    }
}

#Preview("Without try function") {
    SBBCardView<Int>(image: Image("Onboarding_Card1"), title: Text("Title"), text: Text("This is the content of the card"), nextCard: nil, onNext: { _ in })
}

#Preview("With try function") {
    SBBCardView<Int>(image: Image("Onboarding_Card1"), title: Text("Title"), text: Text("This is the content of the card"), showTrySheet: .constant(false), nextCard: nil, onNext: { _ in })
}
