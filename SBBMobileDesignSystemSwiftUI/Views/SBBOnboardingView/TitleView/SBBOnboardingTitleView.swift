//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2019.
//

import SwiftUI

public struct SBBOnboardingTitleView: View {
    
    private let image: Image
    private let title: Text
    
    public init(image: Image, title: Text) {
        self.image = image
        self.title = title
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(spacing: 0) {
                Spacer()
                VStack(spacing: 40) {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .accessibility(hidden: true)
                    title
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
            }
                .font(.sbbLight(size: 30))
                .multilineTextAlignment(.center)
                .foregroundColor(.sbbColor(.white))
            Spacer()
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
