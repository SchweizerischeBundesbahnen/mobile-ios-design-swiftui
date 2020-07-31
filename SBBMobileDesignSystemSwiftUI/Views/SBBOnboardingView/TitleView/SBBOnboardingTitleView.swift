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
        HStack {
            Spacer()
            VStack(spacing: 36) {
                Spacer()
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .accessibility(hidden: true)
                title
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            Spacer()
        }
            .font(.sbbLight(size: 30))
            .multilineTextAlignment(.center)
            .foregroundColor(SBBColor.white)
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
