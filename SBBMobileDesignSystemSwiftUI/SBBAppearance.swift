//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import Foundation
import UIKit
import SwiftUI

/// SBBAppearance must be used to initialize the SDK in the App start (in the method didFinishLaunchingWithOptions of the AppDelegate). It will set up fonts, colors and navigation bar appearance.
public class SBBAppearance {
    
    /**
     This method must be called to initialize SBBMobileDesignSystem in the App. It loads SBB specific fonts and sets up the Navigation Bar in SBB style (only DisplayMode .inline is supported). Typically it is called in didFinishLaunchingWithOptions of the AppDelegate.
     
     - Parameters:
        - theme: Sets the ``SBBTheme`` (color) for all UI elements.
     */
    public class func setupSBBAppearance(theme: SBBTheme = SBBTheme()) {
        setupColors(theme: theme)
        setupSBBFonts()
        setupSBBNavigationBar(color: theme.primaryColor)
    }
    
    private class func setupColors(theme: SBBTheme) {
        Color.sbbPrimary = theme.primaryColor
        Color.sbbSecondary = theme.secondaryColor
    }
    
    private class func setupSBBFonts() {
        SBBFontLoader.loadFonts()
    }
    
    private class func setupSBBNavigationBar(color: Color) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(color)
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "textWhite", in: SBBBundle.getBundle(), compatibleWith: nil)!,
                                             NSAttributedString.Key.font : UIFont(name: "SBBWeb-Light", size: 22)!]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = UIColor(named: "textWhite", in: SBBBundle.getBundle(), compatibleWith: nil)
        UINavigationBar.appearance().isTranslucent = false
    }
}

/// SBBTheme customizes the look and feel of SBB DSM and let's you configure it to your needs. To configure SBB DSM with your own theme, pass your custom SBBTheme when calling ``SBBAppearance/setupSBBAppearance(theme:)``  inside AppDelegate.
public struct SBBTheme {
    
    /// The primary color used for many UI elements (e.g. NavigationBar background, ``SBBPrimaryButtonStyle``)
    public let primaryColor: Color
    
    /// The secondary color used for pressed states/backgrounds of some UI elements (e.g. ``SBBPrimaryButtonStyle`` in pressed state).
    public let secondaryColor: Color
    
    /**
     Returns a ``SBBTheme`` which you can then pass when calling setupSBBAppearance(theme: SBBTheme)  inside AppDelegate to customize the look and feel of SBB DSM.
     
     - Parameters:
        - primaryColor: The primary color used for many UI elements (e.g. NavigationBar background, ``SBBPrimaryButtonStyle``)
        - secondaryColor: The secondary color used for pressed states/backgrounds of some UI elements (e.g. ``SBBPrimaryButtonStyle`` in pressed state). Typically the secondary Color should be slightly darker than the primary Color.
     */
    public init(primaryColor: Color = .sbbColor(.red), secondaryColor: Color = .sbbColor(.red150)) {
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
}
