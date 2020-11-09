//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import UIKit

class SBBFontLoader {
    // there are two cases:
    // this lib is imported with cocoapods: then we load the Fonts from the Framework Bundle
    // this lis is imported manually: then we load the Fonts from the Main Bundle
    internal class func loadFonts() {
        if !registerFonts(withBundle: SBBBundle.getBundle()) {
            print("error while registering the fonts")
        }
    }
    
    private class func registerFonts(withBundle bundle: Bundle) -> Bool {
           var success = true
           success = success && UIFont.registerFont(bundle: bundle, fontName: "sbbweb-bold-reduce", fontExtension: "ttf")
           success = success && UIFont.registerFont(bundle: bundle, fontName: "sbbweb-condensed-bold-reduce", fontExtension: "ttf")
           success = success && UIFont.registerFont(bundle: bundle, fontName: "sbbweb-condensed-heavy-reduce", fontExtension: "ttf")
           success = success && UIFont.registerFont(bundle: bundle, fontName: "sbbweb-italic-reduce", fontExtension: "ttf")
           success = success && UIFont.registerFont(bundle: bundle, fontName: "sbbweb-light-reduce", fontExtension: "ttf")
           success = success && UIFont.registerFont(bundle: bundle, fontName: "sbbweb-roman-reduce", fontExtension: "ttf")
           success = success && UIFont.registerFont(bundle: bundle, fontName: "sbbweb-thin-reduce", fontExtension: "ttf")
           success = success && UIFont.registerFont(bundle: bundle, fontName: "sbbweb-ultralight-reduce", fontExtension: "ttf")
           return success
       }
    
    private class func sbbFont(name:String, size:CGFloat) -> UIFont {
        if let sbbwebromanFont = UIFont(name: name, size: size) {
            return sbbwebromanFont
        } else {
            print("WARNING: SBB Font \"\(name)\" not found, using SystemFont as default")
            print("The following fonts are currently installed:")
            for familyFontName in UIFont.familyNames {
                print("FamilyFontName: \(familyFontName)")
                if (familyFontName == "SBB Web") {
                    for fontName in UIFont.fontNames(forFamilyName: "SBB Web") {
                        print("SBBWeb: \(fontName)")
                    }
                }
            }
            return UIFont.systemFont(ofSize:size)
        }
    }
}

extension UIFont {
    static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) -> Bool {
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension) else {
            fatalError("Couldn't find font \(fontName)")
        }
        
        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            fatalError("Couldn't load data from the font \(fontName)")
        }
        
        guard let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }
        
        var error: Unmanaged<CFError>?
        let success = CTFontManagerRegisterGraphicsFont(font, &error)
        guard success else {
            print("Error registering font: maybe it was already registered.")
            return false
        }
        
        return true
    }
}

