//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/**
 A  View that is used for ``SBBOnboardingView`` and is swipped through during the onboarding process.
 
 ## Overview
 You can create a SBBOnboardingCardView by specifying an image, title, text and/or custom content. You can also specify an action to be executed when the card disappears (e.g. asking the user for certain permissions):
 ```swift
 SBBOnboardingCardView(image: Image("Onboarding_Card1"), title: Text("Card with additional custom content"), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."))
 }
 ```
 ![SBBOnboardingCardView](SBBOnboardingCardView)
 */
public struct SBBOnboardingCardView: View {
    
    private let image: Image?
    private let title: Text?
    private let text: Text?
    private let content: AnyView?
    let actionOnCardDisappear: (() -> ())?
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @State var scrollViewIntrinsicHeight: CGFloat = 0

    private var isCustomCard: Bool {
        return image == nil && title == nil && text == nil && content != nil
    }
    
    /**
     Returns a SBBOnboardingCardView with an optional action performed upon disappear of the view (when the user swipes it away). The CardView is vertically scrollable allowing it to fit large contents.
     
     - Parameters:
        - image: An optional image displayed at the top edge of the CardView. Will automatically shrink with increasing text length but remain a minimal height (using .fill as contentMode, so that it fills the entire view).
        - title: An optional (multiline) title to be displayed underneath the image and above the text.
        - text: An optional (multiline) text to be displayed underneath the title.
        - actionOnCardDisappear: An optional code block being executed upon disappear of the view (when the user swipes it away). Typically used to request app permissions from the user.
     */
    public init(image: Image? = nil, title: Text? = nil, text: Text? = nil, actionOnCardDisappear: (() -> ())? = nil) {
        self.image = image
        self.title = title
        self.text = text
        self.content = nil
        self.actionOnCardDisappear = actionOnCardDisappear
        
        UIScrollView.appearance().bounces = false
    }
    
    /**
     Returns a SBBOnboardingCardView with customizable content and an optional action performed upon disappear of the view (when the user swipes it away). The CardView is vertically scrollable allowing it to fit large contents.
     
     - Parameters:
        - image: An optional image displayed at the top edge of the CardView. Will automatically shrink with increasing text length but remain a minimal height (using .fill as contentMode, so that it fills the entire view).
        - title: An optional (multiline) title to be displayed underneath the image and above the text.
        - text: An optional (multiline) text to be displayed underneath the title.
        - actionOnCardDisappear: An optional code block being executed upon disappear of the view (when the user swipes it away). Typically used to request app permissions from the user.
        - content: Optional custom View content being shown underneath all other elements (or as single content if image, title and text are not set).
     */
    public init<Content: View>(image: Image? = nil, title: Text? = nil, text: Text? = nil, actionOnCardDisappear: (() -> ())? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.image = image
        self.title = title
        self.text = text
        self.content = AnyView(content())
        self.actionOnCardDisappear = actionOnCardDisappear
        
        UIScrollView.appearance().bounces = false
    }
    
    private var imageView: some View {
        Group {
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .accessibility(hidden: true)
            }
        }
    }
    
    private var titleView: some View {
        Group {
            if let title = title {
                title
                    .sbbFont(.titleDefault)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibility(addTraits: .isHeader)
            }
        }
    }
    
    private var textView: some View {
        Group {
            if let text = text {
                text
                    .sbbFont(.body)
                    .minimumScaleFactor(0.1)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: false)
            }
        }
    }
    
    private var portraitView: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    if image != nil {
                        imageView
                            .frame(height: getImageHeight(contentViewHeight: geometry.size.height))
                    }
                    HStack(spacing: 0) {
                        Spacer()
                        VStack(spacing: 16) {
                            titleView
                            
                            textView
                                .frame(maxHeight: geometry.size.height)
                            
                            if let content = content {
                                content
                            }
                        }
                        Spacer()
                    }
                        .padding(16)
                        .foregroundColor(.sbbColor(.textBlack))
                        .background(Color.sbbColor(.viewBackground))
                        .viewHeight($scrollViewIntrinsicHeight)
                }
                    .frame(minHeight: geometry.size.height)
                    .clipped()
            }
                .background(Color.sbbColor(.viewBackground))
                .cornerRadius(16)
        }
    }
    
    private var landscapeView: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                VStack {
                    Spacer()
                    imageView
                    Spacer()
                }
                    .frame(width: geometry.size.width / 2)
                    .frame(minHeight: geometry.size.height)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Spacer()
                            VStack(spacing: 16) {
                                titleView
                                
                                textView
                                    .frame(maxHeight: geometry.size.height)
                                
                                if let content = content {
                                    content
                                }
                            }
                            Spacer()
                        }
                    }
                        .padding(16)
                        .foregroundColor(.sbbColor(.textBlack))
                        .background(Color.sbbColor(.viewBackground))
                        .frame(minHeight: geometry.size.height)
                        .clipped()
                }
                    .frame(width: geometry.size.width / 2)
            }
        }
            .background(Color.sbbColor(.viewBackground))
            .cornerRadius(16)
    }
    
    public var body: some View {
        if self.isCustomCard {
            GeometryReader { _ in
                ScrollView(showsIndicators: false) {
                    self.content
                        .background(Color.sbbColor(.viewBackground))
                        .cornerRadius(16)
                }
            }
                .background(Color.sbbColor(.viewBackground))
                .cornerRadius(16)
        } else {
            Group {
                if self.horizontalSizeClass == .compact && self.verticalSizeClass == .regular {
                    portraitView
                } else {
                    landscapeView
                }
            }
        }
    }
    
    private func getImageHeight(contentViewHeight: CGFloat) -> CGFloat {
        let imageHeight = contentViewHeight - scrollViewIntrinsicHeight
        if imageHeight < 180 {
            return 180
        }
        return imageHeight
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
