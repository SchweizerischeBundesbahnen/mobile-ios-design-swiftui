//
//  SBBFontsBundle.swift
//  MobileDesignSystemSDK
//
//  Created by Terence Alberti on 05.11.20.
//  Copyright © 2020 SBB. All rights reserved.
//

import Foundation

internal struct SBBBundle {
    
    // there are three cases:
    // this lib is imported with cocoapods: then we load the Fonts and Assets from the Framework Bundle
    // this lib is imported manually: then we load the Fonts and Assets from the Main Bundle
    // this lib is imported with swift package manager: then we load from Package Bundle (from file SBBFontsBundleSPM.swift)
    internal static func getBundle() -> Bundle? {
        let frameworkBundle = Bundle(for: SBBAppearance.self)
        let mainBundle = Bundle.main
        
        if (mainBundle.bundlePath == frameworkBundle.bundlePath) {
            // The Fonts are in the Main Bundle
            return Bundle.main
        } else {
            // The Fonts are in the Framework Bundle
            if let bundlePath = frameworkBundle.resourcePath {
                if let resourceBundle = Bundle(path: bundlePath) {
                    return resourceBundle
                }
            }
        }
        return nil  // error
    }
    
}
