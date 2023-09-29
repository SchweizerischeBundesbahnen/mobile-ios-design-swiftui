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
             SBBListItem(label: Text("Label"), leftImage: Image(sbbIcon: station_small), footnote: Text("Footnote"))
         })
     }
 }
 ```
 ![SBBListItem](SBBListItem)
 */
public struct SBBListItem: View {
    
    private let label: Text
    private let labelAccessibility: Text?
    private let leftImage: Image?
    private let rightImage: Image?
    private let footnote: Text?
    private let footnoteAccessibility: Text?
    private let showBottomLine: Bool
    
    var leftSwipeButtonLabel: AnyView?
    var leftSwipeButtonAction: (() -> ())?
    var rightSwipeButtonLabel: AnyView?
    var rightSwipeButtonAction: (() -> ())?
    
    @State var horizontalDragOffset = CGFloat.zero
    @State var horizontalFixedOffset = CGFloat.zero
    
    @Environment(\.sizeCategory) var sizeCategory
    @Environment(\.colorScheme) var colorScheme
    
    /**
     Returns a SBBListItem with a label, an optional Image and an optional footnote.
     
     - Parameters:
     - label: Sets the main label.
     - labelAccessibility: The optional alternative text for the label's VoiceOver.
     - leftImage: An optional Image to be shown on the leading edge of the SBBListItem.
     - rightImage: An optional Image to be shown on the trailing edge of the SBBListItem.
     - footnote: An optional label displayed underneath the main label.
     - footnoteAccessibility: The optional alternative text for the footnote's VoiceOver.
     - showBottomLine: Shows or hides a separator line at the bottom of the View (typically only false for last elements in a List).
     */
    public init(label: Text, labelAccessibility: Text? = nil, leftImage: Image? = nil, rightImage: Image? = Image(sbbIcon: .chevron_small_right_small), footnote: Text? = nil, footnoteAccessibility: Text? = nil, showBottomLine: Bool = true) {
        self.label = label
        self.labelAccessibility = labelAccessibility
        self.leftImage = leftImage
        self.rightImage = rightImage
        self.footnote = footnote
        self.footnoteAccessibility = footnoteAccessibility
        self.showBottomLine = showBottomLine
    }
    
    /// SBBListItem Type.
    public enum SBBListItemType: Equatable {
        /// Normal SBBListItem Style (chevron icon)
        case normal
        /// Info SBBListItem Style (information icon)
        case info
    }
    
    @available(*, deprecated, message: "image renamed to leftImage. SBBListItemType removed, instead use rightImage to specify the desired image.")
    public init(label: Text, labelAccessibility: Text? = nil, image: Image, footnote: Text? = nil, footnoteAccessibility: Text? = nil, type: SBBListItemType = .normal, showBottomLine: Bool = true) {
        self.label = label
        self.labelAccessibility = labelAccessibility
        self.leftImage = image
        self.footnote = footnote
        self.footnoteAccessibility = footnoteAccessibility
        self.rightImage = Image(sbbIcon: (type == .normal ? .chevron_small_right_small : .circle_information_small_small))
        self.showBottomLine = showBottomLine
    }
    
    @available(*, deprecated, message: "image renamed to leftImage. SBBListItemType removed, instead use rightImage to specify the desired image.")
    public init(label: Text, labelAccessibility: Text? = nil, footnote: Text? = nil, footnoteAccessibility: Text? = nil, type: SBBListItemType, showBottomLine: Bool = true) {
        self.label = label
        self.labelAccessibility = labelAccessibility
        self.leftImage = nil
        self.footnote = footnote
        self.footnoteAccessibility = footnoteAccessibility
        self.rightImage = Image(sbbIcon: (type == .normal ? .chevron_small_right_small : .circle_information_small_small))
        self.showBottomLine = showBottomLine
    }
    
    public var body: some View {
        ZStack(alignment: .bottomLeading) {
            HStack {
                if let leftSwipeButtonLabel = leftSwipeButtonLabel {
                    VStack(alignment: .center) {
                        Button(action: {
                            leftSwipeButtonAction?()
                        }) {
                            VStack {
                                Spacer()
                                leftSwipeButtonLabel
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
                if let rightSwipeButtonLabel = rightSwipeButtonLabel {
                    VStack(alignment: .center) {
                        Button(action: {
                            rightSwipeButtonAction?()
                        }) {
                            VStack {
                                Spacer()
                                rightSwipeButtonLabel
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
                        if !sizeCategory.isAccessibilityCategory, let leftImage = leftImage {
                            leftImage
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
                            .foregroundColor(.sbbColor(colorScheme == .dark ? .cement : .granite))
                            .accessibility(label: footnoteAccessibility ?? footnote)
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(.vertical, 12)
                Spacer()
                if let rightImage {
                    rightImage
                        .accessibility(hidden: true)
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.sbbColor(.border)))
                        .padding(.vertical, 6)
                }
            }
            .frame(minHeight: 44)
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
        return (leftSwipeButtonLabel != nil || rightSwipeButtonLabel != nil) ? .all : .subviews
    }
    
    private var dragGesture: some Gesture {
        return DragGesture()
            .onChanged { gesture in
                self.horizontalDragOffset = gesture.translation.width
            }
            .onEnded { _ in
                if self.horizontalDragOffset > 81 / 2 && (self.leftSwipeButtonLabel != nil || self.horizontalFixedOffset < 0) {
                    if self.horizontalFixedOffset <= 0 {
                        withAnimation {
                            self.horizontalFixedOffset += 81
                        }
                    }
                } else if self.horizontalDragOffset < -81 / 2 && (self.rightSwipeButtonLabel != nil || self.horizontalFixedOffset > 0) {
                    if self.horizontalFixedOffset >= 0 {
                        withAnimation {
                            self.horizontalFixedOffset -= 81
                        }
                    }
                }
                withAnimation {
                    self.horizontalDragOffset = .zero
                }
            }
    }
}

struct SBBListItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Group {
                SBBListItem(label: Text("Label"))
                SBBListItem(label: Text("Label"), rightImage: Image(sbbIcon: .chevron_small_right_small))
                SBBListItem(label: Text("Label"), leftImage: Image(sbbIcon: .circle_information_small), rightImage: Image(sbbIcon: .circle_information_small_small))
                SBBListItem(label: Text("Label"), footnote: Text("This is a footnote."))
                SBBListItem(label: Text("Label"), leftImage: Image(sbbIcon: .circle_information_small), rightImage: Image(sbbIcon: .circle_information_small_small), footnote: Text("This is a longer multiline footnote. Here comes more text. much more text"))
            }
            Group {
                SBBListItem(label: Text("Label"))
                SBBListItem(label: Text("Label"), rightImage: Image(sbbIcon: .chevron_small_right_small))
                SBBListItem(label: Text("Label"), leftImage: Image(sbbIcon: .circle_information_small), rightImage: Image(sbbIcon: .circle_information_small_small))
                SBBListItem(label: Text("Label"), footnote: Text("This is a footnote."))
                SBBListItem(label: Text("Label"), leftImage: Image(sbbIcon: .circle_information_small), rightImage: Image(sbbIcon: .circle_information_small_small), footnote: Text("This is a longer multiline footnote. Here comes more text. much more text"))
                    .leftSwipeButton(label: Text("Left")) {
                        
                    }
                    .rightSwipeButton(label: Text("Right")) {
                        
                    }
            }
            .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
        
    }
}
