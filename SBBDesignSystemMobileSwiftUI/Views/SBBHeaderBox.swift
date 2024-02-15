//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2024.
//

import SwiftUI

public extension SBBHeaderBox where AdditionalContent == EmptyView {
    /**
     Returns a SBBHeaderBox.
     
     - Parameters:
        - content: The View to display in the Header.
        - extendNavigationBarBackground: Flag indicating whether the Header  is used right below a NavigationBar and if it should extend the background of the NavigationBar.
     */
    init(@ViewBuilder content: () -> Content, extendNavigationBarBackground: Bool = true) {
        self.content = content()
        self.additionalContent = nil
        self.extendNavigationBarBackground = extendNavigationBarBackground
    }
}

/**
 A  View that is mainly used right underneath the Navigationbar.
 
 ## Overview
 You create a SBBHeaderBox by providing a custom Content and optionnally a custom AdditionalContent. You can also specify wether you want to extend the red NavigationBar theme to flow under the upper part of the SBBHeaderBox:
 ```swift
 var body: some View {
     SBBHeader(content: HStack {
        Image(sbbIcon: .city_small)
         Text("Some title")
         }, additionalContent: HStack {
         Image(sbbIcon: .sign_exclamation_point_small)
         Text("Additional text or information")
         Spacer()
         Image(sbbIcon: .circle_information_small)
        }, extendNavigationBarBackground = false)
    }
 ```
 ![SBBHeader](SBBHeader)
 */
public struct SBBHeaderBox<Content: View, AdditionalContent: View>: View {
    
    private let content: Content
    private let additionalContent: AdditionalContent?
    private let extendNavigationBarBackground: Bool
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.colorScheme) var colorScheme
    
    /**
     Returns a SBBHeader with additional content
     
     - Parameters:
        - content: The View to display in the Header.
        - additionalContent: The View to display as addiitonal content.
        - extendNavigationBarBackground: Flag indicating whether the Header  is used right below a NavigationBar and if it should extend the background of the NavigationBar.
     */
    public init(@ViewBuilder content: @escaping () -> Content, @ViewBuilder additionalContent: @escaping () -> AdditionalContent, extendNavigationBarBackground: Bool = true) {
        self.content = content()
        self.additionalContent = additionalContent()
        self.extendNavigationBarBackground = extendNavigationBarBackground
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            if extendNavigationBarBackground {
                Rectangle()
                    .fill(Color.sbbColor(.primary))
                    .frame(idealWidth: .infinity, minHeight: horizontalSizeClass == .compact ? 35 : 16, maxHeight: horizontalSizeClass == .compact ? 35 : 16)
                    .edgesIgnoringSafeArea(.horizontal)
            }
            HStack {
                VStack(spacing: 0) {
                    HStack {
                        content
                            .frame(maxWidth: .infinity, minHeight: 24, alignment: .leading)
                            .padding(16)
                    }
                    .background(Color.sbbColor(.viewBackground))
                    .cornerRadius(16)
                    .shadow(color: Color.sbbColor(.tabshadow), radius: 5)
                    
                    if let additionalContent = additionalContent {
                        additionalContent
                            .frame(maxWidth: .infinity, minHeight: 20, alignment: .leading)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                    }
                    
                }
                .background(Color.sbbColor(colorScheme == .dark ? .midnight : .cloud))
                .cornerRadius(16)
                .shadow(color: Color.sbbColor(.tabshadow), radius: additionalContent == nil ? 8 : 0)
            }
            .sbbScreenPadding(.horizontal)
        }
    }
}

struct SBBHeader_Previews: PreviewProvider {
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
