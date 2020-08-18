//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public enum SBBListItemType: Equatable {
    case normal
    case info
}

public struct SBBListItem: View {
    
    private let label: Text
    private let labelAccessibility: Text?
    private let image: Image?
    private let footnote: Text?
    private let footnoteAccessibility: Text?
    private let imageRight: Image
    
    @Environment(\.sizeCategory) var sizeCategory
    
    public init(label: Text, labelAccessibility: Text? = nil, image: Image? = nil, footnote: Text? = nil, footnoteAccessibility: Text? = nil, type: SBBListItemType = .normal) {
        self.label = label
        self.labelAccessibility = labelAccessibility
        self.image = image
        self.footnote = footnote
        self.footnoteAccessibility = footnoteAccessibility
        self.imageRight = Image(sbbName: (type == .normal ? "chevron-small-right" : "circle-information-small"), size: .small)
    }
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    if image != nil && !SizeCategories.accessibility.contains(sizeCategory) {
                        image!
                            .resizeToContentSizeCategory(originalHeight: 24)
                            .accessibility(hidden: true)
                    }
                    label
                        .sbbFont(.body)
                        .fixedSize(horizontal: false, vertical: true)
                        .accessibility(label: labelAccessibility ?? label)
                }
                if footnote != nil {
                    footnote!
                        .fixedSize(horizontal: false, vertical: true)
                        .sbbFont(.legend)
                        .foregroundColor(SBBColor.textMetal)
                        .accessibility(label: footnoteAccessibility ?? footnote!)
                }
            }
            Spacer()
            imageRight
                .accessibility(hidden: true)
                .frame(width: 32, height: 32)
                .clipShape(Circle())
                .overlay(Circle().stroke(SBBColor.border))
        }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .foregroundColor(SBBColor.textBlack)
            .background( SBBColor.viewBackground)
            .accessibilityElement(children: .combine)
    }
}

struct SBBListItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                SBBListItem(label: Text("Label"))
                SBBListItem(label: Text("Label"), type: .info)
                SBBListItem(label: Text("Label"), image: Image(sbbName: "circle-information", size: .small))
                SBBListItem(label: Text("Label"), footnote: Text("This is a footnote."))
                SBBListItem(label: Text("Label"), image: Image(sbbName: "circle-information", size: .small), footnote: Text("This is a longer multiline footnote. Here comes more text."))
            }
            Group {
                SBBListItem(label: Text("Label"))
                SBBListItem(label: Text("Label"), type: .info)
                SBBListItem(label: Text("Label"), image: Image(sbbName: "circle-information", size: .small))
                SBBListItem(label: Text("Label"), footnote: Text("This is a footnote."))
                SBBListItem(label: Text("Label"), image: Image(sbbName: "circle-information", size: .small), footnote: Text("This is a longer multiline footnote. Here comes more text."))
            }
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)

    }
}
