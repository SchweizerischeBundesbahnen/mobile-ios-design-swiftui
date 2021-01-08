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
    
    var leftSwipeButton: Button<Text>?
    var rightSwipeButton: Button<Text>?
    
    @State var horizontalDragOffset = CGFloat.zero
    @State var horizontalFixedOffset = CGFloat.zero

    @Environment(\.sizeCategory) var sizeCategory
    
    private var dragGesture: some Gesture {
        return DragGesture()
            .onChanged { gesture in
                self.horizontalDragOffset = gesture.translation.width
            }
            .onEnded { _ in
                if self.horizontalDragOffset > 81 / 2 && (self.leftSwipeButton != nil || self.horizontalFixedOffset < 0) {
                    if self.horizontalFixedOffset <= 0 {
                        self.horizontalFixedOffset += 81
                    }
                } else if self.horizontalDragOffset < -81 / 2 && (self.rightSwipeButton != nil || self.horizontalFixedOffset > 0) {
                    if self.horizontalFixedOffset >= 0 {
                        self.horizontalFixedOffset -= 81
                    }
                }
                self.horizontalDragOffset = .zero
            }
    }
    
    public init(label: Text, labelAccessibility: Text? = nil, image: Image? = nil, footnote: Text? = nil, footnoteAccessibility: Text? = nil, type: SBBListItemType = .normal) {
        self.label = label
        self.labelAccessibility = labelAccessibility
        self.image = image
        self.footnote = footnote
        self.footnoteAccessibility = footnoteAccessibility
        self.imageRight = Image(sbbName: (type == .normal ? "chevron-small-right" : "circle-information-small"), size: .small)
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                if leftSwipeButton != nil {
                    VStack(alignment: .center) {
                        Spacer()
                        leftSwipeButton!
                            .sbbFont(.copy)
                        Spacer()
                    }
                        .frame(width: self.horizontalDragOffset + self.horizontalFixedOffset)
                        .foregroundColor(Color.sbbColor(.white))
                        .background(Color.sbbColor(.metal))
                }
                Spacer()
                if rightSwipeButton != nil {
                    VStack(alignment: .center) {
                        Spacer()
                        rightSwipeButton!
                            .sbbFont(.copy)
                        Spacer()
                    }
                        .frame(width: -(self.horizontalDragOffset + self.horizontalFixedOffset))
                        .foregroundColor(Color.sbbColor(.white))
                        .background(Color.sbbColor(.red))
                }
            }
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
                            .foregroundColor(.sbbColor(.textMetal))
                            .accessibility(label: footnoteAccessibility ?? footnote!)
                    }
                }
                Spacer()
                imageRight
                    .accessibility(hidden: true)
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.sbbColor(.border)))
            }
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                .foregroundColor(.sbbColor(.textBlack))
                .background(Color.sbbColor(.viewBackground))
                .accessibilityElement(children: .combine)
                .offset(x: self.horizontalDragOffset + self.horizontalFixedOffset)
        }
            .gesture(dragGesture, including: tapGestureMask)
    }
    
    // this disables the dragGesture if none of the swipe buttons is set (otherwise it interferes with the ScrollView, see: https://developer.apple.com/forums/thread/122083)
    private var tapGestureMask: GestureMask {
            return (leftSwipeButton != nil || rightSwipeButton != nil) ? .all : .subviews
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
