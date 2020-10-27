//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2019.
//

import SwiftUI

public struct SBBOnboardingTitleView: View {
    
    private let image: Image
    private let title: Text
    
    @State var scrollViewIntrinsicHeight: CGFloat = 0
    
    public init(image: Image, title: Text) {
        self.image = image
        self.title = title
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                HStack(spacing: 0) {
                    Spacer()
                    VStack(spacing: 40) {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .accessibility(hidden: true)
                            .frame(height: getImageHeight(contentViewHeight: geometry.size.height))
                        title
                            .font(.sbbLight(size: 30))
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.sbbColor(.white))
                    }
                    Spacer()
                }
                .frame(minHeight: geometry.size.height)
                .overlay(
                    GeometryReader { scrollViewIntrinsicGeometry in
                        Color.clear.onAppear {
                            self.scrollViewIntrinsicHeight = scrollViewIntrinsicGeometry.size.height
                        }
                    }
                )
            }
        }
    }
    
    private func getImageHeight(contentViewHeight: CGFloat) -> CGFloat {
        let imageHeight = contentViewHeight - scrollViewIntrinsicHeight
        if imageHeight < 200 {
            return 200
        }
        return imageHeight
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
