//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

/*
 SBBAppereance has the responsibility of setting up the SBB Styleguide SDK and to load all necessary pieces (Fonts, ...).
 Call the method setupSBBAppereance in the AppDelegate.
 */

import Foundation
import UIKit

/// This class must be used to initialize the SDK in the App start (in the method didFinishLaunchingWithOptions of the AppDelegate)
public class SBBAppearance {
    
    /**
     This method must be called to initialize SBBMobileDesignSystem in the App. It loads SBB specific fonts and sets up the Navigation Bar in SBB style (only DisplayMode .inline is supported). Typically it is called in didFinishLaunchingWithOptionsu of the AppDelegate.
     */
    public class func setupSBBAppearance() {
        setupSBBFonts()
        setupSBBNavigationBar()
    }
    
    private class func setupSBBFonts() {
        SBBFontLoader.loadFonts()
    }
    
    private class func setupSBBNavigationBar() {
        let newAppearance = UINavigationBarAppearance()
        newAppearance.configureWithOpaqueBackground()
        newAppearance.backgroundColor = UIColor(named: "Red", in: SBBBundle.getBundle(), compatibleWith: nil)
        newAppearance.shadowColor = .clear
        newAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "textWhite", in: SBBBundle.getBundle(), compatibleWith: nil)!,
                                             NSAttributedString.Key.font : UIFont(name: "SBBWeb-Light", size: 22)!]
        UINavigationBar.appearance().standardAppearance = newAppearance
        UINavigationBar.appearance().tintColor = UIColor(named: "textWhite", in: SBBBundle.getBundle(), compatibleWith: nil)
    }
}

