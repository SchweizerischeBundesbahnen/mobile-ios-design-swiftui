//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBOnboardingCardView: View {
    
    private let image: Image
    private let title: Text
    private let text: Text
    
    public init(image: Image, title: Text, text: Text) {
        self.image = image
        self.title = title
        self.text = text
    }
    
    public var body: some View {
        VStack {
            image
            title
            text
        }
    }
}

struct OnboardingCardView_Previews: PreviewProvider {
    
    static let image = Image(systemName: "car")
    static let title = Text("Title")
    static let text = Text("...")
    
    static var previews: some View {
        Group {
            SBBOnboardingCardView(image: image, title: title, text: text)
                .previewDisplayName("Light")
            SBBOnboardingCardView(image: image, title: title, text: text)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}
