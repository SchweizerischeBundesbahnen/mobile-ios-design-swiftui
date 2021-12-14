# ESTA library: Design System Mobile for iOS & SwiftUI

This is a library that contains the visual design for the SBB iOS/SwiftUI Apps.

## Minimum supported iOS Version
* iOS 14.0

## Add the library to your project with Cocoapods

Run this command on the terminal:
```
pod init
```

Add the SBB pod repository on top of file in addition with the existing source instruction:
```
source 'https://github.com/CocoaPods/Specs.git'
source 'ssh://git@code.sbb.ch:7999/kd_cp/sbbcocoapods.git'
```

Open the file pod and make sure you add the following pod
```
pod 'SBBMobileDesignSystemSwiftUI'
```

Run this command on the terminal:
```
pod install
```

## Add the library to your project with Swift package manager

Add in Xcode this package:
```
For HTTPS: https://code.sbb.ch/scm/kd_esta_mobile/esta-mobile-ios-design-swiftui.git
For SSH: ssh://git@codessh.sbb.ch:7999/kd_esta_mobile/esta-mobile-ios-design-swiftui.git
```

## Documentation
The main documentation (DocC) on how to use SBB DSM SwiftUI can be created directly from the project in XCode by selecting "Product" -> "Build Documentation".

* [SBB Design System Mobile documentation](https://digital.sbb.ch/de/design-system-mobile-new "Design System Mobile documentation") (new version since 2021) 
* [AppBakery libraries](https://sbb.sharepoint.com/sites/app-bakery/SitePages/Mobile-Libraries.aspx "AppBakery liraries")
* [Sketch](https://www.sketch.com/s/53b0a518-8d44-42a7-a712-bc211dbb7d78 "Sketch library")
* [Figma](https://www.figma.com/file/56woOj0p1qEOrZiTzi4mJ7/SBB-Mobile-Library-%28draft%29 "Figma library")
* DocC documentation can be created in XCode by selecting "Product" -> "Build Documentation".
* Sample app SBBMobileDesignSystemSwiftUIDemo is included in Xcode project

## Authors

* **Antoniadis Georgios**
* **Brunner Nicolas**
* **Vessaz François**


## License

SBB AG
