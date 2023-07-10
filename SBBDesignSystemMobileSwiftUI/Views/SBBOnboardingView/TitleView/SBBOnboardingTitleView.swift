//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2019.
//

import SwiftUI

/**
 A  View that is used for ``SBBOnboardingView`` as starting or ending View of the onboarding process.
 
 ## Overview
 You can create a SBBOnboardingTitleView by specifying an image, title and optional subtitle:
 ```swift
 SBBOnboardingTitleView(image: Image("Onboarding_Luc"), title: Text("Willkommen"))
 }
 ```
 ![SBBOnboardingTitleView](SBBOnboardingTitleView)
 */
public struct SBBOnboardingTitleView: View {
    
    private let image: Image
    private let title: Text
    private let subtitle: Text?
    
    private let paddingBetweenImageAndTitle: CGFloat = 36
    private let imageMinHeight: CGFloat = 200
    
    @Environment(\.sizeCategory) private var sizeCategory
    
    @State var titleHeight: CGFloat = 0
    @State var subtitleHeight: CGFloat = 0
    
    /**
     Returns a SBBOnboardingTitleView displaying a title and an image.
     
     - Parameters:
        - image: An  image displayed centered vertically in the remaining space above the title.
        - title: A (multiline) title to be displayed on the bottom edge of the View
        - title: An optional (multiline) subtitle to be displayed under the title
     */
    public init(image: Image, title: Text, subtitle: Text? = nil) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }
    
    var imageView: some View {
        image
            .resizable()
            .accessibility(hidden: true)
            .aspectRatio(contentMode: .fit)
    }
    
    var titleView: some View {
        Group {
            if sizeCategory.isAccessibilityCategory {
                title
                    .fixedSize(horizontal: false, vertical: false)
                    .minimumScaleFactor(0.1)
            } else {
                title
                    .fixedSize(horizontal: false, vertical: true)
            }
                
        }
            .font(.sbbLight(size: 30))
            .multilineTextAlignment(.center)
            .accessibility(addTraits: .isHeader)
            .accessibility(identifier: "onboardingTitleViewTitle")
            .viewHeight($titleHeight)
    }
    
    var subtitleView: some View {
        Group {
            if let subtitle = subtitle {
                if sizeCategory.isAccessibilityCategory {
                    subtitle
                        .fixedSize(horizontal: false, vertical: false)
                        .minimumScaleFactor(0.1)
                } else {
                    subtitle
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
            .sbbFont(.body)
            .multilineTextAlignment(.center)
            .accessibility(identifier: "onboardingTitleViewSubtitle")
            .viewHeight($subtitleHeight)
    }
    
    private func contentView(geometry: GeometryProxy) -> some View {
        HStack(spacing: 0) {
            Spacer()
            VStack(spacing: 0) {
                Spacer()
                if sizeCategory.isAccessibilityCategory {
                    imageView
                        .frame(height: imageMinHeight)
                } else {
                    imageView
                        .frame(minHeight: imageMinHeight)
                }
                VStack(spacing: 16) {
                    if sizeCategory.isAccessibilityCategory {
                        titleView
                            .frame(maxHeight: geometry.size.height - imageMinHeight - paddingBetweenImageAndTitle)
                        if subtitle != nil {
                            subtitleView
                                .frame(maxHeight: geometry.size.height)
                        }
                    } else {
                        titleView
                        if subtitle != nil {
                            subtitleView
                        }
                    }
                }
                .padding(.top, paddingBetweenImageAndTitle)
                .foregroundColor(.sbbColor(.white))
                Spacer()
            }
            Spacer()
        }
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                if sizeCategory.isAccessibilityCategory {
                    contentView(geometry: geometry)
                } else {
                    contentView(geometry: geometry)
                        .frame(height: getContentHeight(containingViewHeight: geometry.size.height))
                }
            }
        }
    }
    
    private func getContentHeight(containingViewHeight: CGFloat) -> CGFloat {
        if titleHeight + 16 + subtitleHeight + imageMinHeight + paddingBetweenImageAndTitle > containingViewHeight {  // Content is bigger than ScrollView, image height corresponds to imageMinHeight
            return titleHeight + 16 + subtitleHeight + imageMinHeight + paddingBetweenImageAndTitle
        } else {    // Content is smaller than ScrollView, image can take all the available space
            return containingViewHeight
        }
    }
}

struct SBBOnboardingTitleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FakeSBBOnboardingTitleViews.start
                .previewDisplayName("StartView")
            FakeSBBOnboardingTitleViews.end
                .previewDisplayName("EndView Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
