//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2024.
//

import SwiftUI

public extension SBBHeaderBox where AdditionalContent == EmptyView, CollapsibleContent == EmptyView, NonCollapsibleContent == EmptyView, PageContent == EmptyView {
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
        self.collapsedFromTop = true
        self.nonCollapsibleContent = nil
        self.pageContentWithFocus = nil
        self.pageContent = nil
        self.pageContentScrollable = false
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = nil
    }
}


public extension SBBHeaderBox where CollapsibleContent == EmptyView, NonCollapsibleContent == EmptyView, PageContent == EmptyView {
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
        self.collapsedFromTop = true
        self.nonCollapsibleContent = nil
        self.pageContentWithFocus = nil
        self.pageContent = nil
        self.pageContentScrollable = false
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = nil
    }
}


public extension SBBHeaderBox where AdditionalContent == EmptyView, CollapsibleContent == EmptyView, NonCollapsibleContent == EmptyView {
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
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: @escaping (AccessibilityFocusState<String?>.Binding) -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = nil
        self.additionalContentBackgroundColor = nil
        self.collapsibleContent = nil
        self.collapsedFromTop = true
        self.nonCollapsibleContent = nil
        self.pageContentWithFocus = pageContent
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
        self.collapsedFromTop = true
        self.nonCollapsibleContent = nil
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
        - collapsedFromTop: If true, the collapsibleContent will scroll up and disappear under the content. Otherwise, it will stay put, but disappear as the box becomes smaller.
        - nonCollapsibleContent: The View to display below the collapsible content.
        - extendNavigationBarBackground: Flag indicating whether the Header is used right below a NavigationBar and if it should extend the background of the NavigationBar.
        - pageContentWithFocus: The View used as the content of the page with accessibility focus for the VoiceOver.
        - pageContentScrollable: Whether the page content is scrollable, default true.
        - refresh: Refresh function on swipe down if pageContentScrollable.
     */
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder collapsibleContent: () -> CollapsibleContent, collapsedFromTop: Bool = true, @ViewBuilder nonCollapsibleContent: () -> NonCollapsibleContent, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: @escaping (AccessibilityFocusState<String?>.Binding) -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)?) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = nil
        self.additionalContentBackgroundColor = nil
        self.collapsibleContent = collapsibleContent()
        self.collapsedFromTop = collapsedFromTop
        self.nonCollapsibleContent = nonCollapsibleContent()
        self.pageContentWithFocus = pageContent
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
        - collapsedFromTop: If true, the collapsibleContent will scroll up and disappear under the content. Otherwise, it will stay put, but disappear as the box becomes smaller.
        - nonCollapsibleContent: The View to display below the collapsible content.
        - extendNavigationBarBackground: Flag indicating whether the Header is used right below a NavigationBar and if it should extend the background of the NavigationBar.
        - pageContent: The View used as the content of the page
        - pageContentScrollable: Whether the page content is scrollable, default true.
        - refresh: Refresh function on swipe down if pageContentScrollable.
     */
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder collapsibleContent: () -> CollapsibleContent, collapsedFromTop: Bool = true, @ViewBuilder nonCollapsibleContent: () -> NonCollapsibleContent, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: () -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = nil
        self.additionalContentBackgroundColor = nil
        self.collapsibleContent = collapsibleContent()
        self.collapsedFromTop = collapsedFromTop
        self.nonCollapsibleContent = nonCollapsibleContent()
        self.pageContentWithFocus = nil
        self.pageContent = pageContent()
        self.pageContentScrollable = pageContentScrollable
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = refresh
    }
}


public extension SBBHeaderBox where AdditionalContent == EmptyView, NonCollapsibleContent == EmptyView {
    /**
     Returns a SBBHeaderBox.
     
     - Parameters:
        - isLoading: Whether it is loading, shows a red line at the bottom, default false.
        - content: The View to display in the Header.
        - collapsibleContent: The View to display as collapsible content.
        - collapsedFromTop: If true, the collapsibleContent will scroll up and disappear under the content. Otherwise, it will stay put, but disappear as the box becomes smaller.
        - extendNavigationBarBackground: Flag indicating whether the Header is used right below a NavigationBar and if it should extend the background of the NavigationBar.
        - pageContentWithFocus: The View used as the content of the page with accessibility focus for the VoiceOver.
        - pageContentScrollable: Whether the page content is scrollable, default true.
        - refresh: Refresh function on swipe down if pageContentScrollable.
     */
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder collapsibleContent: () -> CollapsibleContent, collapsedFromTop: Bool = true, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: @escaping (AccessibilityFocusState<String?>.Binding) -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)?) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = nil
        self.additionalContentBackgroundColor = nil
        self.collapsibleContent = collapsibleContent()
        self.collapsedFromTop = collapsedFromTop
        self.nonCollapsibleContent = nil
        self.pageContentWithFocus = pageContent
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
        - collapsedFromTop: If true, the collapsibleContent will scroll up and disappear under the content. Otherwise, it will stay put, but disappear as the box becomes smaller.
        - extendNavigationBarBackground: Flag indicating whether the Header is used right below a NavigationBar and if it should extend the background of the NavigationBar.
        - pageContent: The View used as the content of the page
        - pageContentScrollable: Whether the page content is scrollable, default true.
        - refresh: Refresh function on swipe down if pageContentScrollable.
     */
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder collapsibleContent: () -> CollapsibleContent, collapsedFromTop: Bool = true, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: () -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = nil
        self.additionalContentBackgroundColor = nil
        self.collapsibleContent = collapsibleContent()
        self.collapsedFromTop = collapsedFromTop
        self.nonCollapsibleContent = nil
        self.pageContentWithFocus = nil
        self.pageContent = pageContent()
        self.pageContentScrollable = pageContentScrollable
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = refresh
    }
}

public extension SBBHeaderBox where CollapsibleContent == EmptyView, NonCollapsibleContent == EmptyView {
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
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder additionalContent: () -> AdditionalContent, additionalContentBackgroundColor: Color? = nil, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: @escaping (AccessibilityFocusState<String?>.Binding) -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = additionalContent()
        self.additionalContentBackgroundColor = additionalContentBackgroundColor
        self.collapsibleContent = nil
        self.collapsedFromTop = true
        self.nonCollapsibleContent = nil
        self.pageContent = nil
        self.pageContentWithFocus = pageContent
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
        self.collapsedFromTop = true
        self.nonCollapsibleContent = nil
        self.pageContent = pageContent()
        self.pageContentWithFocus = nil
        self.pageContentScrollable = pageContentScrollable
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = refresh
    }
}


public extension SBBHeaderBox where NonCollapsibleContent == EmptyView {
    /**
     Returns a SBBHeaderBox.
     
     - Parameters:
        - isLoading: Whether it is loading, shows a red line at the bottom, default false.
        - content: The View to display in the Header.
        - collapsibleContent: The View to display in the Header, that can be collapsed.
        - collapsedFromTop: If true, the collapsibleContent will scroll up and disappear under the content. Otherwise, it will stay put, but disappear as the box becomes smaller.
        - additionalContent: The View to display as additional content.
        - additionalContentBackgroundColor: The background color of the additional content.
        - extendNavigationBarBackground: Flag indicating whether the Header is used right below a NavigationBar and if it should extend the background of the NavigationBar.
        - pageContentWithFocus: The View used as the content of the page with accessibility focus for the VoiceOver.
        - pageContentScrollable: Whether the page content is scrollable, default true.
        - refresh: Refresh function on swipe down if pageContentScrollable.
     */
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder collapsibleContent: () -> CollapsibleContent, collapsedFromTop: Bool = true, @ViewBuilder additionalContent: () -> AdditionalContent, additionalContentBackgroundColor: Color? = nil, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: @escaping (AccessibilityFocusState<String?>.Binding) -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = additionalContent()
        self.additionalContentBackgroundColor = additionalContentBackgroundColor
        self.collapsibleContent = collapsibleContent()
        self.collapsedFromTop = collapsedFromTop
        self.nonCollapsibleContent = nil
        self.pageContent = nil
        self.pageContentWithFocus = pageContent
        self.pageContentScrollable = pageContentScrollable
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = refresh
    }
    
    /**
     Returns a SBBHeaderBox.
     
     - Parameters:
        - isLoading: Whether it is loading, shows a red line at the bottom, default false.
        - content: The View to display in the Header.
        - collapsibleContent: The View to display in the Header, that can be collapsed.
        - collapsedFromTop: If true, the collapsibleContent will scroll up and disappear under the content. Otherwise, it will stay put, but disappear as the box becomes smaller.
        - additionalContent: The View to display as additional content.
        - additionalContentBackgroundColor: The background color of the additional content.
        - extendNavigationBarBackground: Flag indicating whether the Header is used right below a NavigationBar and if it should extend the background of the NavigationBar.
        - pageContent: The View used as the content of the page
        - pageContentScrollable: Whether the page content is scrollable, default true.
        - refresh: Refresh function on swipe down if pageContentScrollable.
     */
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder collapsibleContent: () -> CollapsibleContent, collapsedFromTop: Bool = true, @ViewBuilder additionalContent: () -> AdditionalContent, additionalContentBackgroundColor: Color? = nil, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: @escaping () -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = additionalContent()
        self.additionalContentBackgroundColor = additionalContentBackgroundColor
        self.collapsibleContent = collapsibleContent()
        self.collapsedFromTop = collapsedFromTop
        self.nonCollapsibleContent = nil
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

public struct SBBHeaderBox<Content: View, AdditionalContent: View, CollapsibleContent: View, NonCollapsibleContent: View, PageContent: View>: View {
    
    private let content: Content
    private let additionalContent: AdditionalContent?
    private let additionalContentBackgroundColor: Color?
    private let collapsibleContent: CollapsibleContent?
    private let collapsedFromTop: Bool
    private let nonCollapsibleContent: NonCollapsibleContent?
    private let pageContentWithFocus: ((AccessibilityFocusState<String?>.Binding) -> PageContent)?
    private let pageContent: PageContent?
    private let pageContentScrollable: Bool
    private let extendNavigationBarBackground: Bool
    private let isLoading: Bool
    private let refresh: (() async -> Void)?
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.colorScheme) var colorScheme
    
    @State private var contentHeight: CGFloat = .zero
    @State private var collapsibleContentHeight: CGFloat = .zero
    @State private var nonCollapsibleContentHeight: CGFloat = .zero
    @State private var additionalContentHeight: CGFloat = .zero
    @State private var offsetX: CGFloat = 0
    
    @State private var isCurrentlyRefreshing: Bool = false
    @AccessibilityFocusState private var currentFocus: String?
    
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder collapsibleContent: () -> CollapsibleContent, collapsedFromTop: Bool = true, @ViewBuilder nonCollapsibleContent: () -> NonCollapsibleContent, @ViewBuilder additionalContent: @escaping () -> AdditionalContent, additionalContentBackgroundColor: Color? = nil, extendNavigationBarBackground: Bool = true, pageContent: ((AccessibilityFocusState<String?>.Binding) -> PageContent)?, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.content = content()
        self.additionalContent = additionalContent()
        self.additionalContentBackgroundColor = additionalContentBackgroundColor
        self.collapsibleContent = collapsibleContent()
        self.nonCollapsibleContent = nonCollapsibleContent()
        self.collapsedFromTop = collapsedFromTop
        self.pageContentWithFocus = pageContent
        self.pageContent = nil
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.pageContentScrollable = pageContentScrollable
        self.isLoading = isLoading
        self.refresh = refresh
    }
    
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder collapsibleContent: () -> CollapsibleContent, collapsedFromTop: Bool = true, @ViewBuilder nonCollapsibleContent: () -> NonCollapsibleContent, @ViewBuilder additionalContent: () -> AdditionalContent, additionalContentBackgroundColor: Color? = nil, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: @escaping () -> PageContent?, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.content = content()
        self.additionalContent = additionalContent()
        self.additionalContentBackgroundColor = additionalContentBackgroundColor
        self.collapsibleContent = collapsibleContent()
        self.collapsedFromTop = collapsedFromTop
        self.nonCollapsibleContent = nonCollapsibleContent()
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
    
    private var contentView: some View {
        ZStack(alignment: .bottom) {
            content
                .frame(maxWidth: .infinity, minHeight: 24, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .background(Color.sbbColor(.viewBackground))
                .cornerRadius(16, corners: [.topLeft, .topRight])
                .viewHeight($contentHeight)
                .sbbScreenPadding(.horizontal)
        }
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            if let collapsibleContent {
                GeometryReader { parentGeometry in
                    ScrollView(showsIndicators: false) {
                        ScrollViewReader { proxy in
                            LazyVStack(spacing: 0) {
                                Spacer()
                                    .frame(height: contentHeight)
                                
                                ZStack(alignment: .top) {
                                    if collapsedFromTop {
                                        CollapsibleView(minYParent: parentGeometry.frame(in: .global).minY + contentHeight, collapsibleContent: collapsibleContent, nonCollapsibleContent: nonCollapsibleContent, collapsibleContentHeight: $collapsibleContentHeight, nonCollapsibleContentHeight: $nonCollapsibleContentHeight, isLoading: isLoading)
                                            .accessibilityFocused($currentFocus, equals: "collapsibleView")
                                            .zIndex(2)
                                    } else {
                                        FixedCollapsibleView(minYParent: parentGeometry.frame(in: .global).minY + contentHeight, collapsibleContent: collapsibleContent, nonCollapsibleContent: nonCollapsibleContent, collapsibleContentHeight: $collapsibleContentHeight, nonCollapsibleContentHeight: $nonCollapsibleContentHeight, isLoading: isLoading)
                                            .accessibilityFocused($currentFocus, equals: "collapsibleView")
                                            .zIndex(2)
                                    }
                                    
                                    if let additionalContent {
                                        AdditionalView(topPadding: collapsibleContentHeight + nonCollapsibleContentHeight + 16, minYParent: parentGeometry.frame(in: .global).minY + contentHeight - collapsibleContentHeight - nonCollapsibleContentHeight, additionalContent: additionalContent, backgroundColor: additionalContentBackgroundColor, additionalContentHeight: $additionalContentHeight)
                                            .accessibilityFocused($currentFocus, equals: "additionalView")
                                            .zIndex(1)
                                    }
                                    
                                    if pageContent != nil || pageContentWithFocus != nil {
                                        VStack(spacing: 0) {
                                            Spacer()
                                                .frame(height: collapsibleContentHeight + nonCollapsibleContentHeight + 16 + additionalContentHeight)
                                            
                                            Color.clear
                                                .frame(height: 0)
                                                .id("collapsibleView")
                                            Color.clear
                                                .frame(height: 0)
                                                .id("additionalView")
                                            
                                            if isCurrentlyRefreshing, refresh != nil {
                                                SBBLoadingIndicator(size: .small)
                                                    .padding(.bottom, 8)
                                            }
                                            
                                            if let pageContentWithFocus {
                                                pageContentWithFocus($currentFocus)
                                            } else if let pageContent {
                                                pageContent
                                            }
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
                    .refreshable {
                        self.isCurrentlyRefreshing = true
                        await refresh?()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.isCurrentlyRefreshing = false
                        }
                    }
                }
                
                backgroundView
                contentView
                    .viewHeight($contentHeight)
            } else {
                if pageContent != nil || pageContentWithFocus != nil {
                    if pageContentScrollable {
                        ScrollView(showsIndicators: false) {
                            Spacer()
                                .frame(height: contentHeight + (additionalContent != nil ? additionalContentHeight : 0))
                            if isCurrentlyRefreshing, refresh != nil {
                                SBBLoadingIndicator(size: .small)
                                    .padding(.bottom, 8)
                            }
                            if let pageContentWithFocus {
                                pageContentWithFocus($currentFocus)
                            } else if let pageContent {
                                pageContent
                            }
                        }
                        .refreshable {
                            self.isCurrentlyRefreshing = true
                            await refresh?()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                self.isCurrentlyRefreshing = false
                            }
                        }
                    } else {
                        VStack(spacing: 0) {
                            Spacer()
                                .frame(height: contentHeight + (additionalContent != nil ? additionalContentHeight : 0))
                            if let pageContentWithFocus {
                                pageContentWithFocus($currentFocus)
                            } else if let pageContent {
                                pageContent
                            }
                        }
                    }
                }
                
                backgroundView
                
                VStack(spacing: 0) {
                    ZStack(alignment: .bottom) {
                        content
                            .frame(maxWidth: .infinity, minHeight: 24, alignment: .leading)
                            .padding(16)
                        
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
                    .background(Color.sbbColor(.viewBackground))
                    .cornerRadius(16)
                    .shadow(color: Color.sbbColor(.tabshadow), radius: 5)
                    .viewHeight($contentHeight)
                    
                    if let additionalContent = additionalContent {
                        additionalContent
                            .frame(maxWidth: .infinity, minHeight: 20, alignment: .leading)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .viewHeight($additionalContentHeight)
                    }
                }
                .background(additionalContentBackgroundColor != nil ? additionalContentBackgroundColor! : Color.sbbColor(colorScheme == .dark ? .midnight : .cloud))
                .cornerRadius(16)
                .shadow(color: Color.sbbColor(.tabshadow), radius: additionalContent == nil ? 8 : 0)
                .sbbScreenPadding(.horizontal)
            }
        }
    }
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
            }, collapsedFromTop: true, pageContent: {
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

