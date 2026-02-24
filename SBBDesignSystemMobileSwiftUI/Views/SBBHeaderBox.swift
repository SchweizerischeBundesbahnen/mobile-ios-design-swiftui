//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2024.
//

import SwiftUI

@available(iOS 15.0, *)
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
        self.collapsedFromTop = true
        self.pageContentWithFocus = nil
        self.pageContent = nil
        self.pageContentScrollable = false
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = nil
    }
}

@available(iOS 15.0, *)
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
        self.collapsedFromTop = true
        self.pageContentWithFocus = nil
        self.pageContent = nil
        self.pageContentScrollable = false
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = nil
    }
}

@available(iOS 15.0, *)
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
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: @escaping (AccessibilityFocusState<String?>.Binding) -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = nil
        self.additionalContentBackgroundColor = nil
        self.collapsibleContent = nil
        self.collapsedFromTop = true
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
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: @escaping () -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = nil
        self.additionalContentBackgroundColor = nil
        self.collapsibleContent = nil
        self.collapsedFromTop = true
        self.pageContentWithFocus = nil
        self.pageContent = pageContent()
        self.pageContentScrollable = pageContentScrollable
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = refresh
    }
}

@available(iOS 15.0, *)
public extension SBBHeaderBox where AdditionalContent == EmptyView {
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
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder collapsibleContent: () -> CollapsibleContent, collapsedFromTop: Bool = true,extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: @escaping () -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = nil
        self.additionalContentBackgroundColor = nil
        self.collapsibleContent = collapsibleContent()
        self.collapsedFromTop = collapsedFromTop
        self.pageContentWithFocus = nil
        self.pageContent = pageContent()
        self.pageContentScrollable = pageContentScrollable
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.refresh = refresh
    }
}

@available(iOS 15.0, *)
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
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder additionalContent: () -> AdditionalContent, additionalContentBackgroundColor: Color? = nil, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: @escaping (AccessibilityFocusState<String?>.Binding) -> PageContent, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = additionalContent()
        self.additionalContentBackgroundColor = additionalContentBackgroundColor
        self.collapsibleContent = nil
        self.collapsedFromTop = true
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
@available(iOS 15.0, *)
public struct SBBHeaderBox<Content: View, AdditionalContent: View, CollapsibleContent: View, PageContent: View>: View {
    
    private let content: Content
    private let additionalContent: AdditionalContent?
    private let additionalContentBackgroundColor: Color?
    private let collapsibleContent: CollapsibleContent?
    private let collapsedFromTop: Bool
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
    @State private var additionalContentHeight: CGFloat = .zero
    @State private var offsetX: CGFloat = 0
    
    @State private var isCurrentlyRefreshing: Bool = false
    @AccessibilityFocusState private var currentFocus: String?
    
    /**
     Returns a SBBHeader with additional content
     
     - Parameters:
        - isLoading: Whether it is loading, shows a red line at the bottom, default false.
        - content: The View to display in the Header.
        - collapsibleContent: The View to display in the Header, that can be collapsed.
        - additionalContent: The View to display as additional content.
        - additionalContentBackgroundColor: The background color of the additional content.
        - extendNavigationBarBackground: Flag indicating whether the Header  is used right below a NavigationBar and if it should extend the background of the NavigationBar.
        - pageContentWithFocus: The View used as the content of the page with accessibility focus for the VoiceOver.
        - pageContentScrollable: Whether the page content is scrollable, default true.
        - refresh: Refresh function on swipe down.
     */
    public init(isLoading: Bool = false, @ViewBuilder content: @escaping () -> Content, @ViewBuilder collapsibleContent: @escaping () -> CollapsibleContent, collapsedFromTop: Bool = true, @ViewBuilder additionalContent: @escaping () -> AdditionalContent, additionalContentBackgroundColor: Color? = nil, extendNavigationBarBackground: Bool = true, pageContent: ((AccessibilityFocusState<String?>.Binding) -> PageContent)?, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.content = content()
        self.additionalContent = additionalContent()
        self.additionalContentBackgroundColor = additionalContentBackgroundColor
        self.collapsibleContent = collapsibleContent()
        self.collapsedFromTop = collapsedFromTop
        self.pageContentWithFocus = pageContent
        self.pageContent = nil
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.pageContentScrollable = pageContentScrollable
        self.isLoading = isLoading
        self.refresh = refresh
    }
    
    /**
     Returns a SBBHeader with additional content
     
     - Parameters:
        - isLoading: Whether it is loading, shows a red line at the bottom, default false.
        - content: The View to display in the Header.
        - collapsibleContent: The View to display in the Header, that can be collapsed.
        - collapsedFromTop: If true, the collapsibleContent will scroll up and disappear under the content. Otherwise, it will stay put, but disappear as the box becomes smaller.
        - additionalContent: The View to display as additional content.
        - additionalContentBackgroundColor: The background color of the additional content.
        - extendNavigationBarBackground: Flag indicating whether the Header  is used right below a NavigationBar and if it should extend the background of the NavigationBar.
        - pageContent: The View used as the content of the page
        - pageContentScrollable: Whether the page content is scrollable, default true.
        - refresh: Refresh function on swipe down.
     */
    public init(isLoading: Bool = false, @ViewBuilder content: @escaping () -> Content, @ViewBuilder collapsibleContent: @escaping () -> CollapsibleContent, collapsedFromTop: Bool = true, @ViewBuilder additionalContent: @escaping () -> AdditionalContent, additionalContentBackgroundColor: Color? = nil, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: @escaping () -> PageContent?, pageContentScrollable: Bool = true, refresh: (() async -> Void)? = nil) {
        self.content = content()
        self.additionalContent = additionalContent()
        self.additionalContentBackgroundColor = additionalContentBackgroundColor
        self.collapsibleContent = collapsibleContent()
        self.collapsedFromTop = collapsedFromTop
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
                                        CollapsibleView(minYParent: parentGeometry.frame(in: .global).minY + contentHeight, collapsibleContent: collapsibleContent, collapsibleContentHeight: $collapsibleContentHeight, isLoading: isLoading)
                                            .accessibilityFocused($currentFocus, equals: "collapsibleView")
                                            .zIndex(2)
                                    } else {
                                        FixedCollapsibleView(minYParent: parentGeometry.frame(in: .global).minY + contentHeight, collapsibleContent: collapsibleContent, collapsibleContentHeight: $collapsibleContentHeight, isLoading: isLoading)
                                            .accessibilityFocused($currentFocus, equals: "collapsibleView")
                                            .zIndex(2)
                                    }
                                    
                                    if let additionalContent {
                                        AdditionalView(topPadding: collapsibleContentHeight, minYParent: parentGeometry.frame(in: .global).minY + contentHeight - collapsibleContentHeight + 16, additionalContent: additionalContent, backgroundColor: additionalContentBackgroundColor, additionalContentHeight: $additionalContentHeight)
                                            .accessibilityFocused($currentFocus, equals: "additionalView")
                                            .zIndex(1)
                                    }
                                    
                                    if pageContent != nil || pageContentWithFocus != nil {
                                        VStack(spacing: 0) {
                                            Spacer()
                                                .frame(height: collapsibleContentHeight + (additionalContent != nil ? additionalContentHeight : 0))
                                            
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
    
    // Calculates the dynamic offset for sticking a view (inside a ScrollView) between the minYParent and maxYParent
    private func dynamicOffset(sticking geometry: GeometryProxy, to minParent: CGFloat) -> CGFloat {
        let minY = geometry.frame(in: .global).minY
        // The collapsible view should be underneath the content, but with the 16 bottom sticking out.
        let minYParent = minParent + contentHeight - collapsibleContentHeight + 16
        let maxYParent = minParent + contentHeight + (collapsibleContent == nil ? -collapsibleContentHeight + 16 : 0)
        let limitTop = minY < minYParent ? minYParent - minY : nil
        let limitBottom = minY > maxYParent ? maxYParent - minY : nil
        return limitTop ?? limitBottom ?? 0
    }
}

struct CollapsibleView<CollapsibleContent: View>: View {
    let minYParent: CGFloat
    let collapsibleContent: CollapsibleContent?
    
    @Binding var collapsibleContentHeight: CGFloat
    var isLoading: Bool
    
    @State private var offsetX: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                if let collapsibleContent = collapsibleContent {
                    collapsibleContent
                        .padding(16)
                        .opacity(1 - collapseProgress(in: geometry))
                } else {
                    Text("") // Keep the collapsible view anyway, as it is the bottom of the bubble view (in particular for background of additional content in corner radius)
                        .padding(16)
                }
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
            .viewHeight($collapsibleContentHeight)
            .frame(maxWidth: .infinity, minHeight: collapsibleContentHeight, alignment: .leading)
            .background(Color.sbbColor(.viewBackground))
            .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
            .shadow(color: Color.sbbColor(.tabshadow), radius: 8)
            .offset(y: dynamicOffset(sticking: geometry, to: minYParent))
            .sbbScreenPadding(.horizontal)
        }
    }
    
    // Calculates the dynamic offset for sticking a view (inside a ScrollView) between the minYParent and maxYParent
    private func dynamicOffset(sticking geometry: GeometryProxy, to minParent: CGFloat) -> CGFloat {
        let minY = geometry.frame(in: .global).minY
        // The collapsible view should be underneath the content, but with the 16 bottom sticking out.
        let minYParent = minParent - collapsibleContentHeight + 16
        let maxYParent = minParent
        let limitTop = minY < minYParent ? minYParent - minY : nil
        let limitBottom = minY > maxYParent ? maxYParent - minY : nil
        return limitTop ?? limitBottom ?? 0
    }
    
    private func collapseProgress(in geometry: GeometryProxy) -> CGFloat {
        let minY = geometry.frame(in: .global).minY
        let minStickY = minYParent - collapsibleContentHeight
        let maxStickY = minYParent
        
        let totalRange = max(1, maxStickY - minStickY)
        let clampedY = min(max(minY, minStickY), maxStickY)
        return (maxStickY - clampedY) / totalRange
    }
}

struct FixedCollapsibleView<CollapsibleContent: View>: View {
    let minYParent: CGFloat
    let collapsibleContent: CollapsibleContent?
    
    @Binding var collapsibleContentHeight: CGFloat
    var isLoading: Bool
    
    @State private var offsetX: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer(minLength: computeTopSpacing(sticking: geometry, to: minYParent))
                ZStack(alignment: .bottom) {
                    Group {
                        if let collapsibleContent = collapsibleContent {
                            collapsibleContent
                                .padding(16)
                                .opacity(1 - collapseProgress(in: geometry))
                        } else {
                            Text("")
                                .padding(16)
                        }
                    }
                    
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
                .fixedSize(horizontal: false, vertical: true)
                .viewHeight($collapsibleContentHeight)
                .frame(maxWidth: .infinity)
                .frame(height: visibleHeight(in: geometry), alignment: .top)
                .clipped()
                .background(Color.sbbColor(.viewBackground))
                .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
                .shadow(color: Color.sbbColor(.tabshadow), radius: 8)
                .sbbScreenPadding(.horizontal)
                .offset(y: dynamicOffset(sticking: geometry, to: minYParent))
                
                Spacer()
            }
        }
        .frame(height: collapsibleContentHeight > 0 ? collapsibleContentHeight : nil)
    }
    
    // Calculates the dynamic offset for sticking a view (inside a ScrollView) to minParent.
    private func dynamicOffset(sticking geometry: GeometryProxy, to minParent: CGFloat) -> CGFloat {
        let minY = geometry.frame(in: .global).minY
        let limitBottom = minY > minParent ? minParent - minY : nil
        return limitBottom ?? 0
    }
    
    private func computeTopSpacing(sticking geometry: GeometryProxy, to minParent: CGFloat) -> CGFloat {
        let minY = geometry.frame(in: .global).minY
        return max(0, minParent - minY)
    }
    
    // Calculates the visible height of the collapsible view.
    private func visibleHeight(in geometry: GeometryProxy) -> CGFloat {
        let full = max(1, collapsibleContentHeight)
        let progress = collapseProgress(in: geometry)
        // Always keep 16 sticking out - corner radius.
        let visible = max(16, full * (1 - progress))
        return visible
    }
    
    private func collapseProgress(in geometry: GeometryProxy) -> CGFloat {
        let currentMinY = geometry.frame(in: .global).minY
        let minStickY = minYParent - collapsibleContentHeight
        let maxStickY = minYParent
        let totalRange = max(1, maxStickY - minStickY)
        let clamped = min(max(currentMinY, minStickY), maxStickY)
        return (maxStickY - clamped) / totalRange
    }
}

struct AdditionalView<AdditionalContent: View>: View {
    let topPadding: CGFloat
    let minYParent: CGFloat
    let additionalContent: AdditionalContent
    let backgroundColor: Color?
    @Binding var additionalContentHeight: CGFloat
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: topPadding)
                additionalContent
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .viewHeight($additionalContentHeight)
                    .frame(maxWidth: .infinity, minHeight: additionalContentHeight, alignment: .leading)
            }
            .background(backgroundColor != nil ? backgroundColor! : Color.sbbColor(colorScheme == .dark ? .midnight : .cloud))
            .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
            .offset(y: dynamicOffset(sticking: geometry, to: minYParent))
            .sbbScreenPadding(.horizontal)
            .shadow(color: Color.sbbColor(.tabshadow), radius: 5)
        }
    }
    
    // Calculates the dynamic offset for sticking a view (inside a ScrollView) between the minYParent and maxYParent
    private func dynamicOffset(sticking geometry: GeometryProxy, to minParent: CGFloat) -> CGFloat {
        let minY = geometry.frame(in: .global).minY
        let minYParent = minParent
        let maxYParent = minParent + topPadding
        let limitTop = minY < minYParent ? minYParent - minY : nil
        let limitBottom = minY > maxYParent ? maxYParent - minY : nil
        return limitTop ?? limitBottom ?? 0
    }
}

@available(iOS 15.0, *)
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

