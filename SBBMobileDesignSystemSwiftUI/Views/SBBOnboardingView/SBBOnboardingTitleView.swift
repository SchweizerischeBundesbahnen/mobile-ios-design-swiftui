//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
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
            VStack {
                Spacer()
                image
                title
                    .font(.sbbLight(size: 30))
                    .multilineTextAlignment(.center)
                    .foregroundColor(SBBColor.white)
                Spacer()
            }
            Spacer()
        }
    }
}

struct SBBOnboardingTitleView_Previews: PreviewProvider {
    static let image = Image(systemName: "car")
    static let title = Text("Welcome to the best SBB App")
    
    static var previews: some View {
        Group {
            SBBOnboardingTitleView(image: image, title: title)
                .previewDisplayName("Light")
            SBBOnboardingTitleView(image: image, title: title)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
