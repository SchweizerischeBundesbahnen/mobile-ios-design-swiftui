//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public struct SBBInfoView: View {
    
    let image: Image
    let text: Text
    
    @Environment(\.sizeCategory) var sizeCategory
    
    public init(image: Image, text: Text) {
        self.image = image
        self.text = text
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 16) {
            if !SizeCategories.accessibility.contains(sizeCategory) {
                image
                    .resizeToContentSizeCategory(originalHeight: 36)
                    .accessibility(hidden: true)
            }
            text
                .sbbFont(.body)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
            .padding(16)
            .background(SBBColor.viewBackground)
            .cornerRadius(16)
            .accentColor(SBBColor.textBlack)
            .accessibilityElement(children: .combine)
            .accessibility(identifier: "infoView")
    }
}

struct SBBInfoView_Previews: PreviewProvider {
    
    static let image = Image(sbbName: "circle-information-small", size: .medium)
    static let text = Text("Dies ist ein Info Text. Er informiert über Informationen.")
    
    static var previews: some View {
        Group {
            SBBInfoView(image: image, text: text)
                .previewDisplayName("Light")
            SBBInfoView(image: image, text: text)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
            SBBInfoView(image: image, text: text)
                .previewDisplayName("Accessibility Text Size (no icon)")
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        }
            .previewLayout(.sizeThatFits)
    }
}
