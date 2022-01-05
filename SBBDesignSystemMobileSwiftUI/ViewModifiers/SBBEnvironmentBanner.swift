//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public extension View {
    
    /**
     Displays a environment banner on the top trailing edge of a View to highlight the current app environment.
     
     ## Overview
     You can add an Environment banner to any View by using the .sbbEnvironmentBanner() ViewModifier:
     ```swift
     var body: some View {
         NavigationView {
             YourView()
                 .navigationBarTitleDisplayMode(.inline)
                 .navigationBarTitle("Title")
                 .sbbStyle
         }
            .sbbEnvironmentBanner(.dev)
     }
     ```
     ![SBBEnvironmentBannerDev](SBBEnvironmentBannerDev)
     
     - Parameters:
        - banner: The optional SBBEnvironmentBanner to display.
     */
    func sbbEnvironmentBanner(_ banner: SBBEnvironmentBanner) -> some View {
        return ZStack(alignment: .topTrailing) {
            self
            if banner != .none {
                EnvironmentBannerView(text: banner.text, textColor: banner.textColor, backgroundColor: banner.backgroundColor)
            }
        }
    }
    
    /**
     Displays a custom environment banner on the top trailing edge of a View to highlight the current app environment.
     
     - Parameters:
        - text: The Text displayed in the banner.
        - textColor: The foreground Color of the Text displayed in the banner.
        - backgroundColor: The background Color of the banner.
     */
    func sbbEnvironmentBanner(_ text: Text, textColor: Color = Color.sbbColor(.black), backgroundColor: Color = Color.sbbColor(.lemon)) -> some View {
        return ZStack(alignment: .topTrailing) {
            self
            EnvironmentBannerView(text: text, textColor: textColor, backgroundColor: backgroundColor)
        }
    }
}

/// SBBEnvironmentBanner styles.
public enum SBBEnvironmentBanner: CaseIterable {
    /// Style for Prod environments (no banner)
    case none
    /// Style for Test environments
    case test
    /// Style for Development environments
    case dev
    /// Style for Integration environments
    case int
    /// Style for ProofOfConcept environments
    case poc
    
    var text: Text {
        switch self {
        case .none:
            return Text("")
        case .test:
            return Text("test")
        case .dev:
            return Text("dev")
        case .int:
            return Text("int")
        case .poc:
            return Text("poc")
        }
    }

    var textColor: Color {
        switch self {
        case .none:
            return Color.clear
        case .dev:
            return Color.sbbColor(.black)
        case .test, .int, .poc:
            return Color.sbbColor(.white)
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .none:
            return Color.clear
        case .test:
            return Color.sbbColor(.night)
        case .dev:
            return Color.sbbColor(.lemon)
        case .int:
            return Color.sbbColor(.black)
        case .poc:
            return Color.sbbColor(.violet)
        }
    }
}

struct EnvironmentBannerView: View {
    
    let text: Text
    let textColor: Color
    let backgroundColor: Color
    
    var body: some View {
        text
            .frame(width: 300, height: 18, alignment: .center)
            .background(backgroundColor)
            .rotationEffect(.init(degrees: 45))
            .position(x: 44, y: 16)
            .sbbFont(.legendSmall)
            .foregroundColor(textColor)
            .clipped()
            .frame(width: 60, height: 44)
            .accessibility(hidden: true)
    }
}
