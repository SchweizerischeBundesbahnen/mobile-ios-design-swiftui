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
        title
            .font(.sbbLight(size: 30))
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.center)
            .accessibility(addTraits: .isHeader)
            .accessibility(identifier: "onboardingTitleViewTitle")
            .modifier(SizePreferenceKeyUpdater())
            .onPreferenceChange(SizePreferenceKey.self) {
                self.titleHeight = $0.height
            }
    }
    
    var subtitleView: some View {
        Group {
            if let subtitle = subtitle {
                subtitle
                    .sbbFont(.body)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .accessibility(identifier: "onboardingTitleViewSubtitle")
                    .modifier(SizePreferenceKeyUpdater())
                    .onPreferenceChange(SizePreferenceKey.self) {
                        self.subtitleHeight = $0.height
                    }
            }
        }
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                HStack(spacing: 0) {
                    Spacer()
                    VStack(spacing: 0) {
                        Spacer()
                        imageView
                            .frame(minHeight: imageMinHeight)
                        VStack(spacing: 16) {
                            titleView
                            if subtitle != nil {
                                subtitleView
                            }
                        }
                            .padding(.top, paddingBetweenImageAndTitle)
                            .foregroundColor(.sbbColor(.white))
                        Spacer()
                    }
                    Spacer()
                }
                    .frame(height: getContentHeight(containingViewHeight: geometry.size.height))
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
