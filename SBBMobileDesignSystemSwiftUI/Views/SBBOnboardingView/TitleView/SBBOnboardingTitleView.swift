//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2019.
//

import SwiftUI

/// A  View that is used for SBBOnboardingView as starting and ending View of the onboarding process.
public struct SBBOnboardingTitleView: View {
    
    private let image: Image
    private let title: Text
    
    private let paddingBetweenImageAndTitle: CGFloat = 36
    private let imageMinHeight: CGFloat = 200
    
    @State var titleHeight: CGFloat = 0
    
    /**
     Returns a SBBOnboardingTitleView displaying a title and an image.
     
     - Parameters:
        - image: An  image displayed centered vertically in the remaining space above the title.
        - title: A (multiline) title to be displayed on the bottom edge of the View
     */
    public init(image: Image, title: Text) {
        self.image = image
        self.title = title
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                HStack(spacing: 0) {
                    Spacer()
                    VStack(spacing: 0) {
                        Spacer()
                        image
                            .resizable()
                            .accessibility(hidden: true)
                            .aspectRatio(contentMode: .fit)
                        title
                            .padding(.top, paddingBetweenImageAndTitle)
                            .font(.sbbLight(size: 30))
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.sbbColor(.white))
                            .modifier(SizePreferenceKeyUpdater())
                            .onPreferenceChange(SizePreferenceKey.self) {
                                self.titleHeight = $0.height
                            }
                            .accessibility(addTraits: .isHeader)
                            .accessibility(identifier: "onboardingTitleViewText")
                        Spacer()
                    }
                    Spacer()
                }
                    .frame(height: getContentHeight(containingViewHeight: geometry.size.height))
            }
        }
    }
    
    private func getContentHeight(containingViewHeight: CGFloat) -> CGFloat {
        if titleHeight + imageMinHeight + paddingBetweenImageAndTitle > containingViewHeight {  // Content is bigger than ScrollView, image height corresponds to imageMinHeight
            return titleHeight + imageMinHeight + paddingBetweenImageAndTitle
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
