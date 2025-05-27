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
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.sizeCategory) private var sizeCategory
    
    private let widthPortrait: CGFloat?
    
    private let contentWidthLandscape: CGFloat?
    private let buttonWidthLandscape: CGFloat?
    private let contentHeight: CGFloat?
        
    public init(image: Image, title: Text, text: Text, size: CGSize? = nil, showTrySheet: Binding<Bool>, nextCard: Card?, onNext: @escaping (Card?) -> Void) {
        self.image = image
        self.title = title
        self.text = text
        self.size = size
        self.canBeTried = true
        self._showTrySheet = showTrySheet
        self.nextCard = nextCard
        self.onNext = onNext
        
        self.widthPortrait = size?.width != nil ? size!.width : nil
        self.contentHeight = size?.height != nil ? 3 * size!.height / 4 : nil
        self.contentWidthLandscape = size?.width != nil ? 3 * size!.width / 4 : nil
        self.buttonWidthLandscape = size?.width != nil ? size!.width / 4 : nil
    }
    
    public init(image: Image, title: Text, text: Text, titleLineLimit: Int = 1, size: CGSize? = nil, nextCard: Card?, onNext: @escaping (Card?) -> Void) {
        self.image = image
        self.title = title
        self.text = text
        self.size = size
        self.canBeTried = false
        self._showTrySheet = .constant(false)
        self.nextCard = nextCard
        self.onNext = onNext
        
        self.widthPortrait = size?.width != nil ? size!.width : nil
        self.contentHeight = size?.height != nil ? 3 * size!.height / 4 : nil
        self.contentWidthLandscape = size?.width != nil ? 3 * size!.width / 4 : nil
        self.buttonWidthLandscape = size?.width != nil ? size!.width / 4 : nil
    }
    
    private var imageView: some View {
        GeometryReader { geometry in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                .clipped()
                .accessibility(hidden: true)
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
                            .minimumScaleFactor(0.1)
                            .multilineTextAlignment(.center)
                            .accessibility(addTraits: .isHeader)
                        text
                            .sbbFont(.medium_light)
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.1)
                    }
                    .frame(height: sizeCategory.isAccessibilityCategory ? contentHeight : nil)
                    
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
            .frame(width: sizeCategory.isAccessibilityCategory ? widthPortrait : nil)
            .foregroundColor(.sbbColor(.textBlack))
            .background(Color.sbbColor(.viewBackground))
            .cornerRadius(16, corners: [.topLeft, .topRight])
            .shadow(color: Color.sbbColor(.tabshadow), radius: 20, x: 0, y: 0)
        }
    }
    
    private var landscapeView: some View {
            ZStack {
                imageView
                
                VStack(spacing: 0) {
                    Spacer()
                    HStack(spacing: 0) {
                        Spacer()
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
                        .padding(.horizontal, 32)
                        .frame(width: sizeCategory.isAccessibilityCategory ? contentWidthLandscape : nil, height: sizeCategory.isAccessibilityCategory ? contentHeight : nil)
                        
                        VStack(spacing: 16) {
                            if canBeTried {
                                tryButton
                            }
                            nextButton
                        }
                        .padding(.leading, 16)
                        .padding(.trailing, 32)
                        .frame(width: buttonWidthLandscape)
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

#Preview("Without try function") {
    SBBCardView<Int>(image: Image("Onboarding_Card1"), title: Text("Title"), text: Text("This is the content of the card"), nextCard: nil, onNext: { _ in })
}

#Preview("With try function") {
    SBBCardView<Int>(image: Image("Onboarding_Card1"), title: Text("Title"), text: Text("This is the content of the card"), showTrySheet: .constant(false), nextCard: nil, onNext: { _ in })
}
