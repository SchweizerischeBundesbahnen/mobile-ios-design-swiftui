# ESTA Design library for iOS & SwiftUI

This is a library that contains the visual design for the SBB iOS/SwiftUI Apps.

## Add the library to your project with Cocoapods

Run this command on the terminal:
```
pod init
```

Open the file pod and make sure you add the following pod
```
pod 'SBBMobileDesignSystemSwiftUI'
```

Run this command on the terminal:
```
pod install
```

## Initialize the Library in your app

Call the method setupSBBApperance() in the AppDelegate.
```
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        SBBAppearance.setupSBBAppearance()
        
        return true
    }
```

## Documentation

https://digital.sbb.ch/de/mobile contains a documentation of the SBB Design.

https://code.sbb.ch/projects/KD_ESTA/repos/esta-mobile-ios-design-swiftui/ contains the following documentation:
Framework API is generated in /docs on every build if Jazzy is installed.
Sample app SBBMobileDesignSystemSwiftUIDemo is included in Xcode project

In the next chapters you can see a quick resume of how to use the existing UI elements.


## Colors

SBBColor contains two types of colors:
1. The SBB Color palette (e.g. SBBColor.red). Those colors are the same for all themes (light or dark).
2. Semantic colors (e.g. SBBColor.textBlack). Those colors return the matching color for the current theme (light or dark). This means that you will get a different color for light theme than for dark theme.

You can use colors like so:

```
    SBBColor.red    // returns Color (not UIColor)
```

## Authors

* **Antoniadis Georgios**
* **Brunner Nicolas**


## License

SBB AG
