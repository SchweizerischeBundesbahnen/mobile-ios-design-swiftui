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
    }
    
    private class func setupSBBFonts(){
        SBBFontLoader.loadFonts()
    }
}

