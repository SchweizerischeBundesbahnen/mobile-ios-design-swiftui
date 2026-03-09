//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2024.
//

import SwiftUI

public extension SBBHeaderBox where AdditionalContent == EmptyView, CollapsibleContent == EmptyView, PageContent == EmptyView {
    /**
     Returns a SBBHeaderBox.
     
     - Parameters:
     - isLoading: Whether it is loading, shows a red line at the bottom, default false.
     - content: The View to display in the Header.
     - extendNavigationBarBackground: Flag indicating whether the Header  is used right below a NavigationBar and if it should extend the background of the NavigationBar.
     */
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, extendNavigationBarBackground: Bool = true) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = nil
        self.additionalContentBackgroundColor = nil
        self.collapsibleContent = nil
        self.collapseType = .swallowed
        self.pageContentWithFocus = nil
        self.pageContent = nil
        self.pageContentScrollable = false
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = nil
    }
}


public extension SBBHeaderBox where CollapsibleContent == EmptyView, PageContent == EmptyView {
    /**
     Returns a SBBHeaderBox.
     
     - Parameters:
     - isLoading: Whether it is loading, shows a red line at the bottom, default false.
     - content: The View to display in the Header.
     - additionalContent: The View to display as additional content.
     - additionalContentBackgroundColor: The background color of the additional content.
     - extendNavigationBarBackground: Flag indicating whether the Header is used right below a NavigationBar and if it should extend the background of the NavigationBar.
     */
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder additionalContent: () -> AdditionalContent, additionalContentBackgroundColor: Color? = nil, extendNavigationBarBackground: Bool = true) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = additionalContent()
        self.additionalContentBackgroundColor = additionalContentBackgroundColor
        self.collapsibleContent = nil
        self.collapseType = .swallowed
        self.pageContentWithFocus = nil
        self.pageContent = nil
        self.pageContentScrollable = false
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = nil
    }
}


public extension SBBHeaderBox where AdditionalContent == EmptyView, CollapsibleContent == EmptyView {
    /**
     Returns a SBBHeaderBox.
     
     - Parameters:
     - isLoading: Whether it is loading, shows a red line at the bottom, default false.
     - content: The View to display in the Header.
     - extendNavigationBarBackground: Flag indicating whether the Header is used right below a NavigationBar and if it should extend the background of the NavigationBar.
     - pageContentWithFocus: The View used as the content of the page with accessibility focus for the VoiceOver.
     - pageContentScrollable: Whether the page content is scrollable, default true.
     - refresh: Refresh function on swipe down if pageContentScrollable.
     */
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContentWithFocus: @escaping (AccessibilityFocusState<String?>.Binding, CGFloat) -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = nil
        self.additionalContentBackgroundColor = nil
        self.collapsibleContent = nil
        self.collapseType = .swallowed
        self.pageContentWithFocus = pageContentWithFocus
        self.pageContent = nil
        self.pageContentScrollable = pageContentScrollable
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = refresh
    }
    
    /**
     Returns a SBBHeaderBox.
     
     - Parameters:
     - isLoading: Whether it is loading, shows a red line at the bottom, default false.
     - content: The View to display in the Header.
     - extendNavigationBarBackground: Flag indicating whether the Header is used right below a NavigationBar and if it should extend the background of the NavigationBar.
     - pageContent: The View used as the content of the page
     - pageContentScrollable: Whether the page content is scrollable, default true.
     - refresh: Refresh function on swipe down if pageContentScrollable.
     */
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: () -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = nil
        self.additionalContentBackgroundColor = nil
        self.collapsibleContent = nil
        self.collapseType = .swallowed
        self.pageContentWithFocus = nil
        self.pageContent = pageContent()
        self.pageContentScrollable = pageContentScrollable
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = refresh
    }
}

public extension SBBHeaderBox where AdditionalContent == EmptyView {
    /**
     Returns a SBBHeaderBox.
     
     - Parameters:
     - isLoading: Whether it is loading, shows a red line at the bottom, default false.
     - content: The View to display in the Header.
     - collapsibleContent: The View to display as collapsible content.
     - collapseType: Either it slides up, or get swallowed from the bottom.
     - extendNavigationBarBackground: Flag indicating whether the Header is used right below a NavigationBar and if it should extend the background of the NavigationBar.
     - pageContentWithFocus: The View used as the content of the page with accessibility focus for the VoiceOver.
     - pageContentScrollable: Whether the page content is scrollable, default true.
     - refresh: Refresh function on swipe down if pageContentScrollable.
     */
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder collapsibleContent: () -> CollapsibleContent, collapseType: CollapseType = .swallowed, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContentWithFocus: @escaping (AccessibilityFocusState<String?>.Binding, CGFloat) -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)?) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = nil
        self.additionalContentBackgroundColor = nil
        self.collapsibleContent = collapsibleContent()
        self.collapseType = collapseType
        self.pageContentWithFocus = pageContentWithFocus
        self.pageContent = nil
        self.pageContentScrollable = pageContentScrollable
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = refresh
    }
    
    /**
     Returns a SBBHeaderBox.
     
     - Parameters:
     - isLoading: Whether it is loading, shows a red line at the bottom, default false.
     - content: The View to display in the Header.
     - collapsibleContent: The View to display as collapsible content.
     - collapseType: Either it slides up, or get swallowed from the bottom.
     - extendNavigationBarBackground: Flag indicating whether the Header is used right below a NavigationBar and if it should extend the background of the NavigationBar.
     - pageContent: The View used as the content of the page
     - pageContentScrollable: Whether the page content is scrollable, default true.
     - refresh: Refresh function on swipe down if pageContentScrollable.
     */
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder collapsibleContent: () -> CollapsibleContent, collapseType: CollapseType = .swallowed, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: () -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = nil
        self.additionalContentBackgroundColor = nil
        self.collapsibleContent = collapsibleContent()
        self.collapseType = collapseType
        self.pageContentWithFocus = nil
        self.pageContent = pageContent()
        self.pageContentScrollable = pageContentScrollable
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = refresh
    }
    
    /**
     Returns a SBBHeaderBox.
     
     - Parameters:
     - isLoading: Whether it is loading, shows a red line at the bottom, default false.
     - collapsedContent: The View to display when the Header is collapsed.
     - extendedContent: The View to display when the Header is extended.
     - extendNavigationBarBackground: Flag indicating whether the Header is used right below a NavigationBar and if it should extend the background of the NavigationBar.
     - pageContentWithFocus: The View used as the content of the page with accessibility focus for the VoiceOver.
     - pageContentScrollable: Whether the page content is scrollable, default true.
     - refresh: Refresh function on swipe down if pageContentScrollable.
     */
    init(isLoading: Bool = false, @ViewBuilder collapsedContent: () -> Content, @ViewBuilder extendedContent: () -> CollapsibleContent, mergeAccessibilityLabel: Text? = nil, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContentWithFocus: @escaping (AccessibilityFocusState<String?>.Binding, CGFloat) -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)?) {
        self.isLoading = isLoading
        self.content = collapsedContent()
        self.additionalContent = nil
        self.additionalContentBackgroundColor = nil
        self.collapsibleContent = extendedContent()
        self.mergeCollapse = true
        self.mergeAccessibilityLabel = mergeAccessibilityLabel
        self.pageContentWithFocus = pageContentWithFocus
        self.pageContent = nil
        self.pageContentScrollable = pageContentScrollable
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = refresh
    }
    
    /**
     Returns a SBBHeaderBox.
     
     - Parameters:
     - isLoading: Whether it is loading, shows a red line at the bottom, default false.
     - collapsedContent: The View to display when the Header is collapsed.
     - extendedContent: The View to display when the Header is extended.
     - collapseType: Either it slides up, or get swallowed from the bottom.
     - extendNavigationBarBackground: Flag indicating whether the Header is used right below a NavigationBar and if it should extend the background of the NavigationBar.
     - pageContent: The View used as the content of the page
     - pageContentScrollable: Whether the page content is scrollable, default true.
     - refresh: Refresh function on swipe down if pageContentScrollable.
     */
    init(isLoading: Bool = false, @ViewBuilder collapsedContent: () -> Content, @ViewBuilder extendedContent: () -> CollapsibleContent, mergeAccessibilityLabel: Text? = nil, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: () -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.isLoading = isLoading
        self.content = collapsedContent()
        self.additionalContent = nil
        self.additionalContentBackgroundColor = nil
        self.collapsibleContent = extendedContent()
        self.mergeAccessibilityLabel = mergeAccessibilityLabel
        self.mergeCollapse = true
        self.pageContentWithFocus = nil
        self.pageContent = pageContent()
        self.pageContentScrollable = pageContentScrollable
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = refresh
    }
}

public extension SBBHeaderBox where CollapsibleContent == EmptyView {
    /**
     Returns a SBBHeaderBox.
     
     - Parameters:
     - isLoading: Whether it is loading, shows a red line at the bottom, default false.
     - content: The View to display in the Header.
     - additionalContent: The View to display as additional content.
     - additionalContentBackgroundColor: The background color of the additional content.
     - extendNavigationBarBackground: Flag indicating whether the Header is used right below a NavigationBar and if it should extend the background of the NavigationBar.
     - pageContentWithFocus: The View used as the content of the page with accessibility focus for the VoiceOver.
     - pageContentScrollable: Whether the page content is scrollable, default true.
     - refresh: Refresh function on swipe down if pageContentScrollable.
     */
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder additionalContent: () -> AdditionalContent, additionalContentBackgroundColor: Color? = nil, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContentWithFocus: @escaping (AccessibilityFocusState<String?>.Binding, CGFloat) -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = additionalContent()
        self.additionalContentBackgroundColor = additionalContentBackgroundColor
        self.collapsibleContent = nil
        self.collapseType = .swallowed
        self.pageContent = nil
        self.pageContentWithFocus = pageContentWithFocus
        self.pageContentScrollable = pageContentScrollable
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = refresh
    }
    
    /**
     Returns a SBBHeaderBox.
     
     - Parameters:
     - isLoading: Whether it is loading, shows a red line at the bottom, default false.
     - content: The View to display in the Header.
     - additionalContent: The View to display as additional content.
     - additionalContentBackgroundColor: The background color of the additional content.
     - extendNavigationBarBackground: Flag indicating whether the Header is used right below a NavigationBar and if it should extend the background of the NavigationBar.
     - pageContent: The View used as the content of the page
     - pageContentScrollable: Whether the page content is scrollable, default true.
     - refresh: Refresh function on swipe down if pageContentScrollable.
     */
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder additionalContent: () -> AdditionalContent, additionalContentBackgroundColor: Color? = nil, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: @escaping () -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = additionalContent()
        self.additionalContentBackgroundColor = additionalContentBackgroundColor
        self.collapsibleContent = nil
        self.collapseType = .swallowed
        self.pageContent = pageContent()
        self.pageContentWithFocus = nil
        self.pageContentScrollable = pageContentScrollable
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = refresh
    }
}

/**
 A  View that is mainly used right underneath the Navigationbar.
 
 ## Overview
 You create a SBBHeaderBox by providing a custom Content and optionally a custom AdditionalContent. You can also specify wether you want to extend the red NavigationBar theme to flow under the upper part of the SBBHeaderBox:
 ```swift
 var body: some View {
 SBBHeaderBox(content: {
 HStack {
 Image(sbbIcon: .city_small)
 Text("Some title")
 }
 }, additionalContent: {
 HStack {
 Image(sbbIcon: .sign_exclamation_point_small)
 Text("Additional text or information")
 Spacer()
 Image(sbbIcon: .circle_information_small)
 }
 }, extendNavigationBarBackground = false)
 }
 ```
 ![SBBHeaderBox](SBBHeaderBox)
 */

public struct SBBHeaderBox<Content: View, AdditionalContent: View, CollapsibleContent: View, PageContent: View>: View {
    
    private let content: Content
    private let additionalContent: AdditionalContent?
    private let additionalContentBackgroundColor: Color?
    private let collapsibleContent: CollapsibleContent?
    private var collapseType: CollapseType = .swallowed
    private var mergeCollapse: Bool = false
    private var mergeAccessibilityLabel: Text?
    private let pageContentWithFocus: ((AccessibilityFocusState<String?>.Binding, CGFloat) -> PageContent)?
    private let pageContent: PageContent?
    private let pageContentScrollable: Bool
    private let extendNavigationBarBackground: Bool
    private let isLoading: Bool
    private let refresh: (() async -> Void)?
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.colorScheme) var colorScheme
    
    @State private var headerHeight: CGFloat = .zero
    @State private var offsetX: CGFloat = 0
    
    @State private var scrolled: CGFloat = 0
    @State private var collapsibleSnap: CollapsibleSnap?
    
    @State private var isCurrentlyRefreshing: Bool = false
    @AccessibilityFocusState private var currentFocus: String?
    
    
    /**
     Returns a SBBHeaderBox.
     
     - Parameters:
     - isLoading: Whether it is loading, shows a red line at the bottom, default false.
     - content: The View to display in the Header.
     - collapsibleContent: The View to display as collapsible content.
     - collapseType: Either it slides up, or get swallowed from the bottom.
     - additionalContent: The View to display as additional content.
     - additionalContentBackgroundColor: The background color of the additional content.
     - extendNavigationBarBackground: Flag indicating whether the Header is used right below a NavigationBar and if it should extend the background of the NavigationBar.
     - pageContentWithFocus: The View used as the content of the page with accessibility focus for the VoiceOver.
     - pageContentScrollable: Whether the page content is scrollable, default true.
     - refresh: Refresh function on swipe down if pageContentScrollable.
     */
    public init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder collapsibleContent: () -> CollapsibleContent, collapseType: CollapseType = .swallowed, @ViewBuilder additionalContent: @escaping () -> AdditionalContent, additionalContentBackgroundColor: Color? = nil, extendNavigationBarBackground: Bool = true, pageContentWithFocus: ((AccessibilityFocusState<String?>.Binding, CGFloat) -> PageContent)?, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.content = content()
        self.additionalContent = additionalContent()
        self.additionalContentBackgroundColor = additionalContentBackgroundColor
        self.collapsibleContent = collapsibleContent()
        self.collapseType = collapseType
        self.pageContentWithFocus = pageContentWithFocus
        self.pageContent = nil
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.pageContentScrollable = pageContentScrollable
        self.isLoading = isLoading
        self.refresh = refresh
    }
    
    
    /**
     Returns a SBBHeaderBox.
     
     - Parameters:
     - isLoading: Whether it is loading, shows a red line at the bottom, default false.
     - content: The View to display in the Header.
     - collapsibleContent: The View to display as collapsible content.
     - collapseType: Either it slides up, or get swallowed from the bottom.
     - additionalContent: The View to display as additional content.
     - additionalContentBackgroundColor: The background color of the additional content.
     - extendNavigationBarBackground: Flag indicating whether the Header is used right below a NavigationBar and if it should extend the background of the NavigationBar.
     - pageContent: The View used as the content of the page
     - pageContentScrollable: Whether the page content is scrollable, default true.
     - refresh: Refresh function on swipe down if pageContentScrollable.
     */
    public init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder collapsibleContent: () -> CollapsibleContent, collapseType: CollapseType = .swallowed, @ViewBuilder additionalContent: () -> AdditionalContent, additionalContentBackgroundColor: Color? = nil, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: @escaping () -> PageContent?, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.content = content()
        self.additionalContent = additionalContent()
        self.additionalContentBackgroundColor = additionalContentBackgroundColor
        self.collapsibleContent = collapsibleContent()
        self.collapseType = collapseType
        self.pageContentWithFocus = nil
        self.pageContent = pageContent()
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.pageContentScrollable = pageContentScrollable
        self.isLoading = isLoading
        self.refresh = refresh
    }
    
    /**
     Returns a SBBHeaderBox.
     
     - Parameters:
     - isLoading: Whether it is loading, shows a red line at the bottom, default false.
     - collapsedContent: The View to display when the Header is collapsed.
     - extendedContent: The View to display when the Header is extended.
     - additionalContent: The View to display as additional content.
     - additionalContentBackgroundColor: The background color of the additional content.
     - extendNavigationBarBackground: Flag indicating whether the Header is used right below a NavigationBar and if it should extend the background of the NavigationBar.
     - pageContentWithFocus: The View used as the content of the page with accessibility focus for the VoiceOver.
     - pageContentScrollable: Whether the page content is scrollable, default true.
     - refresh: Refresh function on swipe down if pageContentScrollable.
     */
    public init(isLoading: Bool = false, @ViewBuilder collapsedContent: () -> Content, @ViewBuilder extendedContent: () -> CollapsibleContent, mergeAccessibilityLabel: Text? = nil, @ViewBuilder additionalContent: @escaping () -> AdditionalContent, additionalContentBackgroundColor: Color? = nil, extendNavigationBarBackground: Bool = true, pageContentWithFocus: ((AccessibilityFocusState<String?>.Binding, CGFloat) -> PageContent)?, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.content = collapsedContent()
        self.additionalContent = additionalContent()
        self.additionalContentBackgroundColor = additionalContentBackgroundColor
        self.collapsibleContent = extendedContent()
        self.mergeCollapse = true
        self.mergeAccessibilityLabel = mergeAccessibilityLabel
        self.pageContentWithFocus = pageContentWithFocus
        self.pageContent = nil
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.pageContentScrollable = pageContentScrollable
        self.isLoading = isLoading
        self.refresh = refresh
    }
    
    /**
     Returns a SBBHeaderBox.
     
     - Parameters:
     - isLoading: Whether it is loading, shows a red line at the bottom, default false.
     - collapsedContent: The View to display when the Header is collapsed.
     - extendedContent: The View to display when the Header is extended.
     - additionalContent: The View to display as additional content.
     - additionalContentBackgroundColor: The background color of the additional content.
     - extendNavigationBarBackground: Flag indicating whether the Header is used right below a NavigationBar and if it should extend the background of the NavigationBar.
     - pageContent: The View used as the content of the page
     - pageContentScrollable: Whether the page content is scrollable, default true.
     - refresh: Refresh function on swipe down if pageContentScrollable.
     */
    public init(isLoading: Bool = false, @ViewBuilder collapsedContent: () -> Content, @ViewBuilder extendedContent: () -> CollapsibleContent, mergeAccessibilityLabel: Text? = nil, @ViewBuilder additionalContent: () -> AdditionalContent, additionalContentBackgroundColor: Color? = nil, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: @escaping () -> PageContent?, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.content = collapsedContent()
        self.additionalContent = additionalContent()
        self.additionalContentBackgroundColor = additionalContentBackgroundColor
        self.collapsibleContent = extendedContent()
        self.mergeCollapse = true
        self.mergeAccessibilityLabel = mergeAccessibilityLabel
        self.pageContentWithFocus = nil
        self.pageContent = pageContent()
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.pageContentScrollable = pageContentScrollable
        self.isLoading = isLoading
        self.refresh = refresh
    }
    
    @ViewBuilder
    private var backgroundView: some View {
        if extendNavigationBarBackground {
            Rectangle()
                .fill(Color.sbbColor(.primary))
                .frame(idealWidth: .infinity, minHeight: horizontalSizeClass == .compact ? 35 : 16, maxHeight: horizontalSizeClass == .compact ? 35 : 16)
                .edgesIgnoringSafeArea(.horizontal)
        }
    }
    
    @ViewBuilder var loadingView: some View {
        if isLoading {
            GeometryReader { geometry in
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.clear, Color.sbbColor(.primary)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: 64, height: 2)
                    .offset(x: offsetX, y: geometry.size.height / 2)
                    .onAppear {
                        offsetX = 0
                        withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                            self.offsetX = geometry.size.width
                        }
                    }
            }
            .frame(height: 2)
            .accessibilityHidden(true)
        }
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            if pageContent != nil || pageContentWithFocus != nil {
                GeometryReader { parentGeometry in
                    if pageContentScrollable || collapsibleContent != nil {
                        ScrollView(showsIndicators: false) {
                                ScrollViewReader { proxy in
                                    VStack(spacing: 0) {
                                        Spacer()
                                            .frame(height: headerHeight)
                                            .animation(.easeInOut, value: headerHeight)
                                        
                                        if pageContent != nil || pageContentWithFocus != nil {
                                            LazyVStack(spacing: 0) {
                                                if isCurrentlyRefreshing, refresh != nil {
                                                    SBBLoadingIndicator(size: .small)
                                                        .padding(.bottom, 8)
                                                }
                                                
                                                if let pageContentWithFocus {
                                                    pageContentWithFocus($currentFocus, parentGeometry.frame(in: .global).minY + headerHeight)
                                                } else if let pageContent {
                                                    pageContent
                                                }
                                            }
                                        }
                                    }
                                    .onChange(of: currentFocus) { _ in
                                        if let focus = currentFocus {
                                            proxy.scrollTo(focus, anchor: UnitPoint(x: 1.0, y: 0.7))
                                        }
                                    }
                            }
                        }
                        .coordinateSpace(name: "PageContentScrollView")
                    } else {
                        VStack(spacing: 0) {
                            Spacer()
                                .frame(height: headerHeight)
                            
                            if let pageContentWithFocus {
                                pageContentWithFocus($currentFocus, parentGeometry.frame(in: .global).minY + headerHeight)
                            } else if let pageContent {
                                pageContent
                            }
                        }
                    }
                }
            }
            
            backgroundView
            
            VStack(spacing: 0) {
                ZStack(alignment: .bottom) {
                    VStack(spacing: 0) {
                        if mergeCollapse, let collapsibleContent {
                            if let mergeAccessibilityLabel {
                                MergeView(scrolled: $scrolled, collapsibleSnap: $collapsibleSnap, collapsedContent: content, extendedContent: collapsibleContent)
                                    .accessibilityElement(children: .combine)
                                    .accessibilityLabel(mergeAccessibilityLabel)
                                    .accessibilityFocused($currentFocus, equals: "HeaderView")
                            } else {
                                MergeView(scrolled: $scrolled, collapsibleSnap: $collapsibleSnap, collapsedContent: content, extendedContent: collapsibleContent)
                                    .accessibilityElement(children: .combine)
                                    .accessibilityFocused($currentFocus, equals: "HeaderView")
                            }
                            
                        } else {
                            content
                                .frame(maxWidth: .infinity, minHeight: 24, alignment: .leading)
                                .padding(.bottom, collapsibleContent != nil ? 16 : 0)
                                .accessibilityElement(children: .contain)
                                .accessibilityFocused($currentFocus, equals: "HeaderView")
                            
                            if let collapsibleContent {
                                CollapsibleView(scrolled: $scrolled, collapsibleSnap: $collapsibleSnap, collapsibleContent: collapsibleContent, collapseType: collapseType)
                                    .accessibilityElement(children: .contain)
                                    .accessibilityFocused($currentFocus, equals: "HeaderView")
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, collapsibleContent == nil ? 16 : 0)
                    
                    loadingView
                }
                .background(Color.sbbColor(.viewBackground))
                .cornerRadius(16)
                .shadow(color: Color.sbbColor(.tabshadow), radius: 5)
                
                if let additionalContent = additionalContent {
                    additionalContent
                        .frame(maxWidth: .infinity, minHeight: 20, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .accessibilityElement(children: .combine)
                        .accessibilityFocused($currentFocus, equals: "HeaderView")
                }
            }
            .background(additionalContentBackgroundColor != nil ? additionalContentBackgroundColor! : Color.sbbColor(colorScheme == .dark ? .midnight : .cloud))
            .cornerRadius(16)
            .shadow(color: Color.sbbColor(.tabshadow), radius: additionalContent == nil ? 8 : 0)
            .sbbScreenPadding(.horizontal)
            .viewHeight($headerHeight)
            .onChange(of: currentFocus) { _ in
                if currentFocus == "HeaderView" {
                    collapsibleSnap = .open
                } else {
                    collapsibleSnap = .close
                }
            }
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .named("PageContentScrollView"))
                .onChanged { value in
                    scrolled = value.translation.height
                }
                .onEnded { value in
                    let residual = value.predictedEndTranslation.height - value.translation.height
                    collapsibleSnap = residual > 0 ? .open : residual < 0 ? .close : .closest
                }
        )
        .refreshable {
            self.isCurrentlyRefreshing = true
            await refresh?()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.isCurrentlyRefreshing = false
            }
        }
    }
}

public enum CollapseType {
    /// Get 'swallowed' by the box, from the bottom. Content always visible.
    case swallowed
    /// Slides up below the Content (which is always visible)
    case slidesUp
}


struct SBBHeaderBox_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBHeaderBox(content: {
                Rectangle()
                    .foregroundColor(.purple)
                    .frame(height: 24)
            }, collapsibleContent: {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                    .multilineTextAlignment(.leading)
                    .minimumScaleFactor(0.1)
                    .fixedSize(horizontal: false, vertical: true)
            }, collapseType: .swallowed, pageContent: {
                EmptyView()
            })
            SBBHeaderBox(content: {
                Rectangle()
                    .foregroundColor(.purple)
                    .frame(height: 24)
            }, additionalContent: {
                HStack {
                    Image(sbbIcon: .sign_exclamation_point_small)
                    Text("Additional text or information")
                    Spacer()
                    Image(sbbIcon: .circle_information_small)
                }
            }, extendNavigationBarBackground: true)
            .previewDisplayName("With extended background")
            SBBHeaderBox(content: {
                Rectangle()
                    .foregroundColor(.purple)
                    .frame(height: 24)
            }, additionalContent: {
                HStack {
                    Image(sbbIcon: .sign_exclamation_point_small)
                    Text("Additional text or information")
                    Spacer()
                    Image(sbbIcon: .circle_information_small)
                }
            }, extendNavigationBarBackground: false)
            .previewDisplayName("Without extended background")
            SBBHeaderBox(content: {
                Rectangle()
                    .foregroundColor(.purple)
                    .frame(height: 24)
            }, extendNavigationBarBackground: true)
            .previewDisplayName("Without additional info, with extended background")
            SBBHeaderBox(content: {
                Rectangle()
                    .foregroundColor(.purple)
                    .frame(height: 24)
            }, extendNavigationBarBackground: false)
            .previewDisplayName("Without additional info, without extended background")
        }
        .previewLayout(.sizeThatFits)
    }
}

