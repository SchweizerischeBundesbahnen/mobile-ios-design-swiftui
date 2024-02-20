//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2024.
//

import SwiftUI

/**
 A  View that is used to display a footer.
 
 ## Overview
 You create a SBBFooterBox by providing a custom Content. You can also specify the footer is used with a tab bar or not
 ```swift
 var body: some View {
    SBBFooterBox(content: {
            VStack(alignment: .leading) {
                Text("Title")
                Text("This is some information.")
            }
        }, hasTabBar = false)
    }
 ```
 ![SBBFooterBox](SBBFooterBox)
 */
public struct SBBFooterBox<Content: View>: View {
    
    private let content: Content
    private let hasTabBar: Bool
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    public init(@ViewBuilder content: @escaping () -> Content, hasTabBar: Bool = true) {
        self.content = content()
        self.hasTabBar = hasTabBar
    }
    
    public var body: some View {
        HStack {
            content
                .frame(maxWidth: .infinity, minHeight: 24, alignment: .leading)
                .padding(16)
                .padding(.bottom, hasTabBar ? horizontalSizeClass == .compact && verticalSizeClass == .regular ? 75 + 36 : 38 + 24 : 24)
        }
        .background(Color.sbbColor(.modalBackground))
        .cornerRadius(16, corners: [.topLeft, .topRight])
        .shadow(color: Color.sbbColor(.tabshadow), radius: 5)
    }
}


struct SBBFooterBox_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBFooterBox(content: {
                Rectangle()
                    .foregroundColor(.purple)
                    .frame(height: 24)
            }, hasTabBar: true)
            .previewDisplayName("With tab bar padding")
            SBBFooterBox(content: {
                Rectangle()
                    .foregroundColor(.purple)
                    .frame(height: 24)
            }, hasTabBar: false)
            .previewDisplayName("Without tab bar padding")
        }
    }
}
