//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI

public extension SBBBubbleView where ExpandableContent == EmptyView, SubtitleContent == EmptyView, FixedContent == EmptyView {
    /**
     Returns a SBBBubbleView.
     
     - Parameters:
        - image: The Image to display on the top leading edge (typically a SBB Icon).
        - title: The Text to display as title.
        - titleAccessibility: The optional alternative text for the title's VoiceOver.
        - subtitle: The Text to display as subtitle.
        - subtitleAccessibility: The optional alternative text for the subtitle's VoiceOver.
        - extendNavigationBarBackground: Flag indicating whether the BubbleView is used right below a NavigationBar and if it should extend the background of the NavigationBar.
     */
    init(image: Image, title: Text, titleAccessibility: Text? = nil, subtitle: Text? = nil, subtitleAccessibility: Text? = nil, extendNavigationBarBackground: Bool = true) {
        self.image = image
        self.title = title
        self.titleAccessibility = titleAccessibility
        self.subtitle = subtitle
        self.subtitleAccessibility = subtitleAccessibility
        self._expanded = .constant(false)
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.expandableContent = nil
        self.subtitleContent = nil
        self.fixedContent = nil
    }
}

public extension SBBBubbleView where FixedContent == EmptyView, SubtitleContent == EmptyView {
    /**
     Returns a SBBBubbleView with expandable custom content.
     
     - Parameters:
        - image: The Image to display on the top leading edge (typically a SBB Icon).
        - title: The Text to display as title.
        - titleAccessibility: The optional alternative text for the title's VoiceOver.
        - subtitle: The Text to display as subtitle.
        - subtitleAccessibility: The optional alternative text for the subtitle's VoiceOver.
        - expanded: Sets the collapsed/expanded state of the BubbleView.
        - extendNavigationBarBackground: Flag indicating whether the BubbleView is used right below a NavigationBar and if it should extend the background of the NavigationBar.
        - expandableContent: The custom View which can be collapsed.
     */
    init(image: Image, title: Text, titleAccessibility: Text? = nil, subtitle: Text? = nil, subtitleAccessibility: Text? = nil, expanded: Binding<Bool>, extendNavigationBarBackground: Bool = true, @ViewBuilder expandableContent: @escaping () -> ExpandableContent) {
        self.image = image
        self.title = title
        self.titleAccessibility = titleAccessibility
        self.subtitle = subtitle
        self.subtitleAccessibility = subtitleAccessibility
        self._expanded = expanded
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.expandableContent = expandableContent()
        self.subtitleContent = nil
        self.fixedContent = nil
    }
}

public extension SBBBubbleView where ExpandableContent == EmptyView {
    /**
     Returns a SBBBubbleView with custom content below the  icon and subtitle.
     
     - Parameters:
        - image: The Image to display on the top leading edge (typically a SBB Icon).
        - title: The Text to display as title.
        - titleAccessibility: The optional alternative text for the title's VoiceOver.
        - extendNavigationBarBackground: Flag indicating whether the BubbleView is used right below a NavigationBar and if it should extend the background of the NavigationBar.
        - subtitleContent: The custom View shown below the subtitle
        - fixedContent: The custom View shown below the icon and subtitle.
     */
    init(image: Image, title: Text, titleAccessibility: Text? = nil, extendNavigationBarBackground: Bool = true, @ViewBuilder subtitleContent: @escaping () -> SubtitleContent, @ViewBuilder fixedContent: @escaping () -> FixedContent) {
        self.image = image
        self.title = title
        self.titleAccessibility = titleAccessibility
        self.subtitle = nil
        self.subtitleAccessibility = nil
        self._expanded = .constant(false)
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.expandableContent = nil
        self.subtitleContent = subtitleContent()
        self.fixedContent = fixedContent()
    }
}

public extension SBBBubbleView where ExpandableContent == EmptyView, SubtitleContent == EmptyView {
    /**
     Returns a SBBBubbleView with custom content below the  icon and subtitle.
     
     - Parameters:
        - image: The Image to display on the top leading edge (typically a SBB Icon).
        - title: The Text to display as title.
        - titleAccessibility: The optional alternative text for the title's VoiceOver.
        - subtitle: The Text to display as subtitle.
        - subtitleAccessibility: The optional alternative text for the subtitle's VoiceOver.
        - expanded: Sets the collapsed/expanded state of the BubbleView.
        - extendNavigationBarBackground: Flag indicating whether the BubbleView is used right below a NavigationBar and if it should extend the background of the NavigationBar.
        - fixedContent: The custom View shown below the icon and subtitle.
     */
    init(image: Image, title: Text, titleAccessibility: Text? = nil, subtitle: Text? = nil, subtitleAccessibility: Text? = nil, extendNavigationBarBackground: Bool = true, @ViewBuilder fixedContent: @escaping () -> FixedContent) {
        self.image = image
        self.title = title
        self.titleAccessibility = titleAccessibility
        self.subtitle = subtitle
        self.subtitleAccessibility = subtitleAccessibility
        self._expanded = .constant(false)
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.expandableContent = nil
        self.subtitleContent = nil
        self.fixedContent = fixedContent()
    }
}

public extension SBBBubbleView where SubtitleContent == EmptyView {
    /**
     Returns a SBBBubbleView with collapsible content and custom content below the icon and subtitle.
     
     - Parameters:
        - image: The Image to display on the top leading edge (typically a SBB Icon).
        - title: The Text to display as title.
        - titleAccessibility: The optional alternative text for the title's VoiceOver.
        - subtitle: The Text to display as subtitle.
        - subtitleAccessibility: The optional alternative text for the subtitle's VoiceOver.
        - expanded: Sets the collapsed/expanded state of the BubbleView.
        - extendNavigationBarBackground: Flag indicating whether the BubbleView is used right below a NavigationBar and if it should extend the background of the NavigationBar.
        - expandableContent: The custom View which can be collapsed.
        - fixedContent: The custom View shown below the icon and subtitle.
     */
    init(image: Image, title: Text, titleAccessibility: Text? = nil, subtitle: Text? = nil, subtitleAccessibility: Text? = nil, expanded: Binding<Bool>, extendNavigationBarBackground: Bool = true, @ViewBuilder expandableContent: @escaping () -> ExpandableContent, @ViewBuilder fixedContent: @escaping () -> FixedContent) {
        self.image = image
        self.title = title
        self.titleAccessibility = titleAccessibility
        self.subtitle = subtitle
        self.subtitleAccessibility = subtitleAccessibility
        self._expanded = expanded
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.expandableContent = expandableContent()
        self.subtitleContent = nil
        self.fixedContent = fixedContent()
    }
}


/// A  View that is mainly used right underneath the Navigationbar. It displays an Image and a Title and optionally a subtitle and collapsible content.
public struct SBBBubbleView<ExpandableContent, SubtitleContent, FixedContent>: View where ExpandableContent: View, SubtitleContent: View, FixedContent: View {
    
    private let image: Image
    private let title: Text
    private let titleAccessibility: Text?
    private let subtitle: Text?
    private let subtitleAccessibility: Text?
    @Binding private var expanded: Bool
    private let extendNavigationBarBackground: Bool
    private let expandableContent: ExpandableContent?
    private let subtitleContent: SubtitleContent?
    private let fixedContent: FixedContent?
    
    @Environment(\.sizeCategory) var sizeCategory
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    public var body: some View {
        ZStack(alignment: .top) {
            if extendNavigationBarBackground {
                Rectangle()
                    .fill(Color.sbbColor(.red))
                    .frame(idealWidth: .infinity, minHeight: horizontalSizeClass == .compact ? 35 : 16, maxHeight: horizontalSizeClass == .compact ? 35 : 16)
                    .edgesIgnoringSafeArea(.horizontal)
            }
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(alignment: .top) {
                                if !SizeCategories.accessibility.contains(sizeCategory) {
                                    image
                                        .frame(width: 36, height: 36, alignment: .center)
                                        .accessibility(hidden: true)
                                }
                                HStack(alignment: .center) {
                                    VStack(alignment: .leading, spacing: 0) {
                                        title
                                            .sbbFont(.titleDefault)
                                            .frame(maxWidth: .infinity, minHeight: 36, alignment: .leading)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .accessibility(label: self.titleAccessibility ?? self.title)
                                        if let subtitle = subtitle {
                                            subtitle
                                                .sbbFont(.body)
                                                .fixedSize(horizontal: false, vertical: true)
                                                .accessibility(label: self.subtitleAccessibility ?? subtitle)
                                        }
                                        if let subtitleContent = subtitleContent {
                                            subtitleContent
                                                .sbbFont(.body)
                                        }
                                        if horizontalSizeClass == .regular, expanded, let expandableContent = expandableContent {
                                            expandableContent
                                                .sbbFont(.body)
                                        }
                                    }
                                        .accessibilityElement(children: .combine)
                                    if horizontalSizeClass == .regular, let fixedContent = fixedContent {
                                        fixedContent
                                    }
                                    Spacer()
                                    if (expandableContent != nil) {
                                        Group {
                                            Image(sbbName: "chevron-small-up", size: .small)
                                                .rotationEffect(.degrees(self.expanded ? 0 : 180))
                                        }
                                            .accessibility(hidden: true)
                                            .frame(width: 32, height: 32)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.sbbColor(.border)))
                                    }
                                }
                            }
                        }
                        if horizontalSizeClass == .compact, expanded, let expandableContent = expandableContent {
                            VStack(alignment: .leading, spacing: 0) {
                                SBBDivider()
                                expandableContent
                                    .sbbFont(.body)
                                    .padding(.top, 8)
                            }
                                .padding(.leading, SizeCategories.accessibility.contains(sizeCategory) ? 0 : 44)
                        }
                    }
                    .accessibilityElement(children: horizontalSizeClass == .compact ? .combine : .contain)
                        .accessibility(addTraits: .isHeader)
                        .accessibility(identifier: "bubbleView")
                        .accessibility(hint: ((self.expandableContent == nil) ? Text("") : self.expanded ? Text("collapse".localized) : Text("expand".localized)))
                        
                    if horizontalSizeClass == .compact, let fixedContent = fixedContent {
                        fixedContent
                            .padding(.top, 4)
                    }
                }
                    .padding(.leading, 16)
                    .padding(.trailing, horizontalSizeClass == .compact ? 16 : (expandableContent != nil) ? 16 : 0)
                    .padding(.vertical, horizontalSizeClass == .compact ? 16 : 8)
                    .background(Color.sbbColor(.tabViewBackground))
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.1), radius: 5)
                    .accentColor(.sbbColor(.textBlack))
                    .onTapGesture {
                        withAnimation{
                            self.expanded.toggle()
                        }
                    }
            }
                .sbbScreenPadding(.horizontal)
        }
    }
}

struct SBBBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach([UserInterfaceSizeClass.compact, UserInterfaceSizeClass.regular], id: \.self) { horizontalSizeClass in
                Group {
                    SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"))
                        .previewDisplayName("Title only")
                    SBBBubbleView(image: Image(sbbName: "station", size: .medium), title: Text("Biel / Bienne"), subtitle: Text("Gleis 2 und 3."), extendNavigationBarBackground: false)
                        .previewDisplayName("Subtitle, no extended NavigationBar background")
                    SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), expanded: .constant(true), expandableContent: {
                        Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
                    })
                        .previewDisplayName("Detail dark")
                        .environment(\.colorScheme, .dark)
                    SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), expanded: .constant(true), expandableContent: {
                        Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
                    })
                        .previewDisplayName("Accessibility Text Size (no icon)")
                        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                    SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("R2 nach La Chaux-de-Fonds-Grenier, Armes-Réunies"), expanded: .constant(true), expandableContent: {
                        Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
                        Text("ca. +12'")
                            .foregroundColor(.sbbColor(.red))
                            .font(.sbbTitleDefault)
                    })
                        .previewDisplayName("Long title, multiple views")
                    SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), fixedContent: {
                        SBBSegmentedPicker(selection: .constant(0), tags: [0, 1], content: {
                            Text("Wagen")
                            Text("Perlschnur")
                        })
                    })
                        .previewDisplayName("Fixed Content")
                    SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), expanded: .constant(true), expandableContent: {
                        Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
                    }, fixedContent: {
                        SBBSegmentedPicker(selection: .constant(0), tags: [0, 1], content: {
                            Text("Wagen")
                            Text("Perlschnur")
                        })
                    })
                        .previewDisplayName("Expandable & Fixed Content")
                    SBBBubbleView(image: Image(sbbName: "train", size: .medium), title: Text("IC6 nach Basel"), subtitleContent: {
                        Text("Wagen 3, 1. Klasse.\nBusiness-Zone, Ruhezone.\nNächster Halt: Olten um 17:03.")
                        Text("ca. +12'")
                            .foregroundColor(.sbbColor(.red))
                            .font(.sbbTitleDefault)
                    }, fixedContent: {
                        SBBSegmentedPicker(selection: .constant(0), tags: [0, 1], content: {
                            Text("Wagen")
                            Text("Perlschnur")
                        })
                    })
                        .previewDisplayName("Subtitle Content & Fixed Content")
                }
                    .environment(\.horizontalSizeClass, horizontalSizeClass)
            }
        }
            .previewLayout(.sizeThatFits)
    }
}
