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
    
    public class func setupSBBAppearance() {
        setupSBBFonts()
        setupSBBNavigationBar()
        
        if #available(iOS 14, *) {
            // use SwitchToggleStyle introduced with iOS 14.0
        } else {
            setupSBBToggle()
        }
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
    
    @available(iOS, obsoleted: 14)
    private class func setupSBBToggle() {
        UISwitch.appearance().onTintColor = UIColor(named: "Red", in: SBBBundle.getBundle(), compatibleWith: nil)
    }
}

