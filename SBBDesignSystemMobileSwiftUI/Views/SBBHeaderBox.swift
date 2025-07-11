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
        self.pageContent = nil
        self.pageContentScrollable = false
        self.extendNavigationBarBackground = extendNavigationBarBackground
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
        - extendNavigationBarBackground: Flag indicating whether the Header  is used right below a NavigationBar and if it should extend the background of the NavigationBar.
     */
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder additionalContent: () -> AdditionalContent, additionalContentBackgroundColor: Color? = nil, extendNavigationBarBackground: Bool = true) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = additionalContent()
        self.additionalContentBackgroundColor = additionalContentBackgroundColor
        self.collapsibleContent = nil
        self.pageContent = nil
        self.pageContentScrollable = false
        self.extendNavigationBarBackground = extendNavigationBarBackground
    }
}

public extension SBBHeaderBox where AdditionalContent == EmptyView, CollapsibleContent == EmptyView {
    /**
     Returns a SBBHeaderBox.
     
     - Parameters:
        - isLoading: Whether it is loading, shows a red line at the bottom, default false.
        - content: The View to display in the Header.
        - extendNavigationBarBackground: Flag indicating whether the Header  is used right below a NavigationBar and if it should extend the background of the NavigationBar.
        - pageContent: The View used as the content of the page
        - pageContentScrollable: Whether the page content is scrollable, default true.
     */
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: @escaping () -> PageContent, pageContentScrollable: Bool = true) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = nil
        self.additionalContentBackgroundColor = nil
        self.collapsibleContent = nil
        self.pageContent = pageContent()
        self.pageContentScrollable = pageContentScrollable
        self.extendNavigationBarBackground = extendNavigationBarBackground
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
        - extendNavigationBarBackground: Flag indicating whether the Header  is used right below a NavigationBar and if it should extend the background of the NavigationBar.
        - pageContent: The View used as the content of the page
        - pageContentScrollable: Whether the page content is scrollable, default true.
     */
    init(isLoading: Bool = false, @ViewBuilder content: () -> Content, @ViewBuilder additionalContent: () -> AdditionalContent, additionalContentBackgroundColor: Color? = nil, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: @escaping () -> PageContent, pageContentScrollable: Bool = true) {
        self.isLoading = isLoading
        self.content = content()
        self.additionalContent = additionalContent()
        self.additionalContentBackgroundColor = additionalContentBackgroundColor
        self.collapsibleContent = nil
        self.pageContent = pageContent()
        self.pageContentScrollable = pageContentScrollable
        self.extendNavigationBarBackground = extendNavigationBarBackground
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
    private let pageContent: PageContent?
    private let pageContentScrollable: Bool
    private let extendNavigationBarBackground: Bool
    private let isLoading: Bool
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.colorScheme) var colorScheme
    
    @State private var contentHeight: CGFloat = .zero
    @State private var collapsibleContentHeight: CGFloat = .zero
    @State private var additionalContentHeight: CGFloat = .zero
    @State private var offsetX: CGFloat = 0
    
    /**
     Returns a SBBHeader with additional content
     
     - Parameters:
        - isLoading: Whether it is loading, shows a red line at the bottom, default false.
        - content: The View to display in the Header.
        - collapsibleContent: The View to display in the Header, that can be collapsed.
        - additionalContent: The View to display as additional content.
        - additionalContentBackgroundColor: The background color of the additional content.
        - extendNavigationBarBackground: Flag indicating whether the Header  is used right below a NavigationBar and if it should extend the background of the NavigationBar.
        - pageContent: The View used as the content of the page
        - pageContentScrollable: Whether the page content is scrollable, default true.
     */
    init(isLoading: Bool = false, @ViewBuilder content: @escaping () -> Content, @ViewBuilder collapsibleContent: @escaping () -> CollapsibleContent, @ViewBuilder additionalContent: @escaping () -> AdditionalContent, additionalContentBackgroundColor: Color? = nil, extendNavigationBarBackground: Bool = true, @ViewBuilder pageContent: @escaping () -> PageContent, pageContentScrollable: Bool = true) {
        self.content = content()
        self.additionalContent = additionalContent()
        self.additionalContentBackgroundColor = additionalContentBackgroundColor
        self.collapsibleContent = collapsibleContent()
        self.pageContent = pageContent()
        self.extendNavigationBarBackground = extendNavigationBarBackground
        self.pageContentScrollable = pageContentScrollable
        self.isLoading = isLoading
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
        content
            .frame(maxWidth: .infinity, minHeight: 24, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .background(Color.sbbColor(.viewBackground))
            .cornerRadius(16, corners: [.topLeft, .topRight])
            .viewHeight($contentHeight)
            .sbbScreenPadding(.horizontal)
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            if let collapsibleContent {
                GeometryReader { parentGeometry in
                    ScrollView {
                        ScrollViewReader { proxy in
                            VStack(spacing: 0) {
                                Spacer()
                                    .frame(height: contentHeight)
                                
                                ZStack(alignment: .top) {
                                    CollapsibleView(minYParent: parentGeometry.frame(in: .global).minY + contentHeight, collapsibleContent: collapsibleContent, collapsibleContentHeight: $collapsibleContentHeight)
                                        .zIndex(2)
                                    
                                    if let additionalContent {
                                        AdditionalView(topPadding: collapsibleContentHeight, minYParent: parentGeometry.frame(in: .global).minY + contentHeight - collapsibleContentHeight + 16, additionalContent: additionalContent, backgroundColor: additionalContentBackgroundColor, additionalContentHeight: $additionalContentHeight)
                                            .zIndex(1)
                                    }
                                    
                                    if let pageContent {
                                        VStack(spacing: 0) {
                                            Spacer()
                                                .frame(height: collapsibleContentHeight + (additionalContent != nil ? additionalContentHeight : 0))
                                            pageContent
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                backgroundView
                contentView
                    .viewHeight($contentHeight)
            } else {
                if let pageContent {
                    if pageContentScrollable {
                        ScrollView {
                            Spacer()
                                .frame(height: contentHeight + (additionalContent != nil ? additionalContentHeight : 0))
                            pageContent
                        }
                    } else {
                        VStack(spacing: 0) {
                            Spacer()
                                .frame(height: contentHeight + (additionalContent != nil ? additionalContentHeight : 0))
                            pageContent
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
    
    var body: some View {
        HStack {
            GeometryReader { geometry in
                Group {
                    if let collapsibleContent = collapsibleContent {
                        collapsibleContent
                    } else {
                        Text("") // Keep the collapsible view anyway, as it is the bottom of the bubble view (in particular for background of additional content in corner radius)
                    }
                }
                .padding(16)
                .viewHeight($collapsibleContentHeight)
                .frame(maxWidth: .infinity, minHeight: collapsibleContentHeight, alignment: .leading)
                .background(Color.sbbColor(.viewBackground))
                .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
                .shadow(color: Color.sbbColor(.tabshadow), radius: 8)
                .offset(y: dynamicOffset(sticking: geometry, to: minYParent))
                .sbbScreenPadding(.horizontal)
            }
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

struct SBBHeaderBox_Previews: PreviewProvider {
    static var previews: some View {
        Group {
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

