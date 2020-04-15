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

https://code.sbb.ch/projects/KD_ESTA_MOBILE/repos/esta-mobile-ios-design-swiftui/ contains the following documentation:
Framework API is generated in /docs on every build if Jazzy is installed.
Sample app SBBMobileDesignSystemSwiftUIDemo is included in Xcode project

In the next chapters you can see a quick resume of how to use the existing UI elements.

## NavigationBar

To setup the NavigationBar (& StatusBar) in the SBB style, you need to apply the SBBNavigationBar() modifier to its first child:
```
    NavigationView {
        Group {
            ContentView()
        }
            .modifier(SBBNavigationBar())                                   // you need to add this
            .navigationBarTitle("SBB MDS SwiftUI", displayMode: .inline)    // SBB Design only supports .inline for the time being
    }
```

## Colors

SBBColor contains two types of colors:
1. The SBB Color palette (e.g. SBBColor.red). Those colors are the same for all themes (light or dark).
2. Semantic colors (e.g. SBBColor.textBlack). Those colors return the matching color for the current theme (light or dark). This means that you will get a different color for light theme than for dark theme.

You can use colors like so:

```
    SBBColor.red    // returns Color (not UIColor)
```

## Fonts

SBBFonts are scaling dynamically (except in Preview - current SwiftUI/XCode bug). You can overwrite font size and lineSpacing if desired.

You can use colors like so:

```
    Text("SBB Body\(longText)")
        .sbbFont(.body)                             // default usage
        .sbbFont(.body, size: 25, lineSpacing: 6)   // overwriting font size and lineSpacing
        .foregroundColor(SBBColor.textBlack)        // you need to set the color manually - there are 4 options for semantic text colors: .textBlack, .textMetal, .textRed, .textWihte
```
## SBBDivider

SBBDivider replaces the standard Swiftui Divider.

You can use it like so:

```    
    var body: some View {
        SBBDivider()
    }
```

## SBBBubbleView

SBBBubbleView is a view that can only be used underneath the SBBNavigationBar. You need to set its image and title. Optional parameters are its subtitle, detail, titleAccessibility, subtitleAccessibility and detailAccessibility (use the Accessibility parameters to modify the voiceover Texts).

If you want your BubbleView to be expandable, you can use it like so:

```
    @State var expanded = true
    
    var body: some View {
        VStack {
            SBBBubbleView(image: Image("sample"), title: "Your title", detail: "Your longer text", expanded: $expanded)    // The SBBBubbleView always needs to be the first element inside a VStack (to position it right below the SBBNavigationBar)
            // other elements below SBBBubbleView
        }
    }
```
If your BubbleView contains no detail (and is not expandable), you can use it like so:

```    
    var body: some View {
        VStack {
        SBBBubbleView(image: Image("sample"), title: "Your title", expanded: .constant(false))    // The SBBBubbleView always needs to be the first element inside a VStack (to position it right below the SBBNavigationBar)
            // other elements below SBBBubbleView
        }
    }
```

## SBBInfoView

SBBInfoView is an expandable view with a title and a text to be used for showing general information. You need to set its title. Optional parameters are its detail, titleAccessibility,  and detailAccessibility (use the Accessibility parameters to modify the voiceover Texts).

You can use the SBBInfoView it like so:

```
    @State var expanded = true
    
    var body: some View {
        SBBInfoView(title: "Your title", detail: "Your longer text", expanded: $expanded)
    }
```

## SBBSegmentedPicker

SBBSegmentedPicker is the SBB-Implementation of the standard SwiftUI Picker with SegmentedPickerStyle. You need to set its current selection and all its unique tags (of type Hashable).

You can use the SBBSegmentedPicker like so:
```
   enum PickerOptions: String {
        case departures
        case platform
    }
```

```
    @State private var selectedSegment2: PickerOptions = .departures
    
    var body: some View {
        SBBSegmentedPicker(selection: self.$selectedSegment2, tags: [.departures, .platform]) {
            Text("Departures")
            Text("Platform")
        }
    }
```


## Authors

* **Antoniadis Georgios**
* **Brunner Nicolas**


## License

SBB AG
