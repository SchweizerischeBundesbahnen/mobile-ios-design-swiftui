//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

/**
 A  View that is used to display a single item of a list. Usually used inside a ``SBBFormGroup`` and in combination with NavigationLink.
 
 ## Overview
 You create a SBBListItem by providing a label. You can optionally also provide an image and a footnote:
 ```swift
 var body: some View {
     SBBFormGroup(title: "Title") {
         NavigationLink(destination: ChildView(), label: {
            SBBListItem(label: Text("Label"), image: Image(sbbName: "station", size: .small), footnote: Text("Footnote"))
         })
    }
 }
 ```
 ![SBBListItem](SBBListItem)
 */
public struct SBBListItem: View {
    
    /// SBBListItem Type.
    public enum SBBListItemType: Equatable {
        /// Normal SBBListItem Style (chevron icon)
        case normal
        /// Info SBBListItem Style (information icon)
        case info
    }
    
    private let label: Text
    private let labelAccessibility: Text?
    private let image: Image?
    private let footnote: Text?
    private let footnoteAccessibility: Text?
    private let imageRight: Image
    private let showBottomLine: Bool
    
    var leftSwipeButtonText: Text?
    var leftSwipeButtonAction: (() -> ())?
    var rightSwipeButtonText: Text?
    var rightSwipeButtonAction: (() -> ())?
    
    @State var horizontalDragOffset = CGFloat.zero
    @State var horizontalFixedOffset = CGFloat.zero

    @Environment(\.sizeCategory) var sizeCategory
    @Environment(\.colorScheme) var colorScheme
    
    private var dragGesture: some Gesture {
        return DragGesture()
            .onChanged { gesture in
                self.horizontalDragOffset = gesture.translation.width
            }
            .onEnded { _ in
                if self.horizontalDragOffset > 81 / 2 && (self.leftSwipeButtonText != nil || self.horizontalFixedOffset < 0) {
                    if self.horizontalFixedOffset <= 0 {
                        self.horizontalFixedOffset += 81
                    }
                } else if self.horizontalDragOffset < -81 / 2 && (self.rightSwipeButtonText != nil || self.horizontalFixedOffset > 0) {
                    if self.horizontalFixedOffset >= 0 {
                        self.horizontalFixedOffset -= 81
                    }
                }
                self.horizontalDragOffset = .zero
            }
    }
    
    /**
     Returns a SBBListItem with a label, an optional Image and an optional footnote.
     
     - Parameters:
        - label: Sets the main label.
        - labelAccessibility: The optional alternative text for the label's VoiceOver.
        - image: An optional Image to be shown on the leading edge of the SBBTextField.
        - footnote: An optional label displayed underneath the main label.
        - footnoteAccessibility: The optional alternative text for the footnote's VoiceOver.
        - type: The type of the trailing edge's image.
        - showBottomLine: Shows or hides a separator line at the bottom of the View (typically only false for last elements in a List).
     */
    public init(label: Text, labelAccessibility: Text? = nil, image: Image? = nil, footnote: Text? = nil, footnoteAccessibility: Text? = nil, type: SBBListItemType = .normal, showBottomLine: Bool = true) {
        self.label = label
        self.labelAccessibility = labelAccessibility
        self.image = image
        self.footnote = footnote
        self.footnoteAccessibility = footnoteAccessibility
        self.imageRight = Image(sbbName: (type == .normal ? "chevron-small-right" : "circle-information-small"), size: .small)
        self.showBottomLine = showBottomLine
    }
    
    public var body: some View {
        ZStack(alignment: .bottomLeading) {
            HStack {
                if let leftSwipeButtonText = leftSwipeButtonText {
                    VStack(alignment: .center) {
                        Button(action: {
                            leftSwipeButtonAction?()
                        }) {
                            VStack {
                                Spacer()
                                leftSwipeButtonText
                                    .sbbFont(.copy)
                                Spacer()
                            }
                                .padding(.horizontal, 16)
                        }
                    }
                    .frame(width: max(self.horizontalDragOffset + self.horizontalFixedOffset, 0))
                    .foregroundColor(Color.sbbColor(.white))
                    .background(Color.sbbColor(.metal))
                }
                Spacer()
                if let rightSwipeButtonText = rightSwipeButtonText {
                    VStack(alignment: .center) {
                        Button(action: {
                            rightSwipeButtonAction?()
                        }) {
                            VStack {
                                Spacer()
                                rightSwipeButtonText
                                    .sbbFont(.copy)
                                Spacer()
                            }
                                .padding(.horizontal, 16)
                        }
                    }
                        .frame(width: max(-(self.horizontalDragOffset + self.horizontalFixedOffset), 0))
                        .foregroundColor(Color.sbbColor(.white))
                        .background(Color.sbbColor(.primary))
                }
            }
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        if !sizeCategory.isAccessibilityCategory, let image = image {
                            image
                                .resizeToContentSizeCategory(originalHeight: 24)
                                .accessibility(hidden: true)
                        }
                        label
                            .sbbFont(.body)
                            .fixedSize(horizontal: false, vertical: true)
                            .accessibility(label: labelAccessibility ?? label)
                            .multilineTextAlignment(.leading)
                    }
                    if let footnote = footnote {
                        footnote
                            .fixedSize(horizontal: false, vertical: true)
                            .sbbFont(.legend)
                            .foregroundColor(.sbbColor(colorScheme == .dark ? .cement : .red))
                            .accessibility(label: footnoteAccessibility ?? footnote)
                            .multilineTextAlignment(.leading)
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
            if showBottomLine {
                Rectangle()
                    .fill(Color.sbbColorInternal(.textfieldLineInactive))
                    .frame(height: 1)
            }
        }
            .gesture(dragGesture, including: tapGestureMask)
    }
    
    // this disables the dragGesture if none of the swipe buttons is set (otherwise it interferes with the ScrollView, see: https://developer.apple.com/forums/thread/122083)
    private var tapGestureMask: GestureMask {
            return (leftSwipeButtonText != nil || rightSwipeButtonText != nil) ? .all : .subviews
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
