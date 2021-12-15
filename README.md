# Framework: Design System Mobile for iOS & SwiftUI

This framework contains SBB (Swiss Federal Railways) UI elements for iOS SwiftUI Apps. It allows an easy integration of SBB theming to your app (or a custom color theming of your choice). All elements are optimized for dynamic TextSizes, VoiceOver, light & dark mode as well as for different SizeClasses.

![SBB Design System Mobile in use](/SBBMobileDesignSystemSwiftUI/Documentation.docc/Resources/SBBDSM_Devices.png)

## Minimum supported iOS Version
* iOS 14.0

## Add the library to your project with Swift package manager

Add the following package to your XCode project:
```
For HTTPS: https://code.sbb.ch/scm/kd_esta_mobile/esta-mobile-ios-design-swiftui.git
For SSH: ssh://git@codessh.sbb.ch:7999/kd_esta_mobile/esta-mobile-ios-design-swiftui.git
```

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

## How to use
The main documentation (DocC) on how to use SBB DSM SwiftUI can be created directly from the project in XCode by selecting "Product" -> "Build Documentation".

### Documentation
* DocC documentation can be created in XCode by selecting "Product" -> "Build Documentation".
* Sample app SBBMobileDesignSystemSwiftUIDemo is included in Xcode project.

### SBB internal documentation
A the moment, the following documents are only available to persons internal to SBB:
* [SBB Design System Mobile documentation](https://digital.sbb.ch/de/design-system-mobile-new "Design System Mobile documentation") (new version since 2021) 
* [AppBakery libraries](https://sbb.sharepoint.com/sites/app-bakery/SitePages/Mobile-Libraries.aspx "AppBakery liraries")
* [Figma](https://www.figma.com/file/56woOj0p1qEOrZiTzi4mJ7/SBB-Mobile-Library-%28draft%29 "Figma library")

## Getting help
If you need help, you can reach out to us by e-mail: [mobile@sbb.ch](mailto:mobile@sbb.ch?subject=[GitHub]%20MDS%20SwiftUI)

## Getting involved
Generally speaking, we are welcoming contributions improving existing UI elements or fixing certain bugs. We will also consider contributions introducing new design elements, but might reject them, if they do not reflect our vision of SBB Design System.

General instructions on _how_ to contribute can be found under [CONTRIBUTING](CONTRIBUTING.md).

## Authors

* **Antoniadis Georgios**
* **Brunner Nicolas**
* **Vessaz François**


## Open source licensing info

This Software is developed by SBB (Swiss Federal Railways) and made publicly available under the MIT Open Source license: [License](License.md).
