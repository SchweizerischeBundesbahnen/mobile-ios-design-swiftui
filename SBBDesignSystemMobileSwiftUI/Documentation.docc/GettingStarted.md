# Getting Started

Add SBB DSM SwiftUI to your app and alter its appearance according to the SBB Design System Mobile.

## Overview

This tutorial will guide you step-by-step through the process of integrating SBB DSM SwiftUI to your app.

After adding the SBB DSM SwiftUI framework in your app you need to follow the following steps:
1. Initialize the libary in your app.
2. Apply the .sbbStyle() ViewModifier to your ParentView.
3. Build your UI using SBBViews and SBBViewModifiers.

![Architecture overview of SBB DSM SwiftUI.](SBBDSM_Architecture_Overview.png)

### Add the library to your project

Start by adding the SBBDesignSystemMobileSwiftUI package to your project using Swift Package Manager.

For HTTPS:
```
https://code.sbb.ch/scm/kd_esta_mobile/esta-mobile-ios-design-swiftui.git
```

For SSH:
```
ssh://git@codessh.sbb.ch:7999/kd_esta_mobile/esta-mobile-ios-design-swiftui.git
```

### Initialize the Library in your app

Call the setupSBBApperance() in the AppDelegate:

```swift
import SBBDesignSystemMobileSwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        SBBAppearance.setupSBBAppearance()
        return true
    }
}
```

Alternatively, if you want to use your own color theme:
```swift
SBBAppearance.setupSBBAppearance(theme: SBBTheme(primaryColor: .blue, secondaryColor: .darkBlue))
```

### Apply the .sbbStyle() ViewModifier to your ParentView.

Applies SBB styling to your view. You typically apply the sbbStyle() View modifier to the upmost View in the hierarchy.

```swift
import SBBDesignSystemMobileSwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Group {
                YourView()  // create your own UI
            }
            .sbbStyle()
            .sbbScreenPadding()
            .navigationBarTitle("Your title", displayMode: .inline)
        }
    }
}
```

### Build your UI using SBBViews and SBBViewModifiers.

Start building your UI using the provided Views and ViewModifiers, e.g.:

```swift
@State var expanded = true

VStack {
    SBBAccordion(title: Text("Your title"), detail: Text("blabla"), expanded: $expanded)
    Button(action: yourAction) {
        Text("Your Button")
    }
        .buttonStyle(SBBPrimaryButtonStyle())
}
```
