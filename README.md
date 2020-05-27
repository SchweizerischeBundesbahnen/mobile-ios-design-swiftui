# ESTA Design library for iOS & SwiftUI

This is a library that contains the visual design for the SBB iOS/SwiftUI Apps.

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

There are 2 ways in which you can use SBB Fonts

### Using .font() View Modifier

Using the .font() View Modifier, you can select all available SBB Fonts. However this does not apply SBB specific LineSpacing. If you want SBB specific LineSpacing, use the .sbbFont() View Modifier instead. You can also create your own Fonts based on the available SBB Font Styles by specifying a size of your choice. 

You can use .font() like so:

```
    Text("SBB Body\(longText)")
        .font(.sbbBody)                             // default usage
        .font(.sbbLight(size: 12))                  // or create own font based on available SBB Font Styles
        .foregroundColor(SBBColor.textBlack)        // you need to set the color manually - there are 4 options for semantic text colors: .textBlack, .textMetal, .textRed, .textWhite
```

### Using .sbbFont() View Modifier

Using the .sbbFont() View Modifier, SBB specific LineSpacing is also applied.
SBBFonts are scaling dynamically (except in Preview - current SwiftUI/XCode bug). 

You can use .sbbFont() like so:

```
    Text("SBB Body\(longText)")
        .sbbFont(.body)
        .foregroundColor(SBBColor.textBlack)        // you need to set the color manually - there are 4 options for semantic text colors: .textBlack, .textMetal, .textRed, .textWhite
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

SBBBubbleView is a view that can only be used underneath the SBBNavigationBar. You need to set its image and title. Optional parameters are its subtitle, titleAccessibility, subtitleAccessibility and content as a Viewbuilder defining what will be shown in the expandable part (use the Accessibility parameters to modify the voiceover Texts). You can pass as many Views inside the ViewBuilder as you want and they will be stacked vertically by default.

If you want your BubbleView to be expandable, you can use it like so:

```
    @State var expanded = true
    
    var body: some View {
        VStack {
            // The SBBBubbleView always needs to be the first element inside a VStack (to position it right below the SBBNavigationBar)
            SBBBubbleView(image: Image("sample"), title: Text("Your title"), detail: [Text("Your longer text")], expanded: $expanded) {   
                Text("Your longer text")    // you can add whatever Views you want inside ViewBuilder for the Detail part of BubbleView
            }
            // other elements below SBBBubbleView
        }
    }
```
If your BubbleView contains no detail (and is not expandable), you can use it like so:

```    
    var body: some View {
        VStack {
            // The SBBBubbleView always needs to be the first element inside a VStack (to position it right below the SBBNavigationBar)
            SBBBubbleView(image: Image("sample"), title: Text("Your title"), expanded: .constant(false))    
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
        SBBInfoView(title: Text("Your title"), detail: Text("Your longer text"), expanded: $expanded)
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

## SBBCheckBox

SBBCheckBox is a SBB-styled SwiftUI Toggle.

```
    @State private var isOn = true
    
    var body: some View {
        VStack {
            SBBCheckBox(isOn: $isOn)
            SBBCheckBox(isOn: $isOn, label: "Label")
        }
    }
```

## SBBTextField

SBBTextField is a SBB-styled SwiftUI TextField with floating label.

```
    @State private var text = ""
    
    var body: some View {
        VStack {
            SBBTextField(text: $text)
            SBBTextField(text: $text, label: "Placeholder")
        }
    }
```

## SBBTextArea

SBBTextArea is a SwiftUI equivalent of UITextView with SBB style.

```
    @State private var text = ""
    
    var body: some View {
        VStack {
            SBBTextArea(text: $text)
            SBBTextArea(text: $text, label: "Placeholder")
        }
    }
```

## SBBFormGroup

SBBFormGroup is a SBB-styled section of a form. It takes from 1 to 10 elements with an optional header.

```    
    var body: some View {
        VStack {
            SBBFormGroup(title: "Header") {
                Text("Row 1")
                Text("Row 2")
                Text("Row 3")
            }
            SBBFormGroup {
                Text("Row 1")
                Text("Row 2")
                Text("Row 3")
            }
        }
    }
```

## SBBListItem

SBBListItem is usually used inside a SBBFormGroup and in combination with NavigationLink. You need to set its label. Optional parameters are its labelAccessibility, image, footnote, footnoteAccessibility and its type (SBBListItemType which is by default .normal).

```    
    var body: some View {
        VStack {
            SBBFormGroup(title: "Label only") {
                NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: { 
                    SBBListItem(label: Text("Label")) 
                })
            }
            SBBFormGroup(title: "All parameters set") {
                NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: { 
                SBBListItem(label: Text("Label"), labelAccessibility: Text("Voiceover for label"), image: Image("my_image_name"), footnote: Text("FootNote"), footnoteAccessibility: Text("Voiceover for footnote"), type: .info)
                })
            }
        }
    }
```

## SBBPrimaryButtonStyle

SwiftUI ButtonStyle implementation of SBB primary button. 

```    
    var body: some View {
        Button(action: myAction) {
            Text("My Button")
        }
        .buttonStyle(SBBPrimaryButtonStyle())
    }
```

## Toggle

The standard SwiftUI toggle can be used. It will by default feature the SBB specific background color (red). 

## Authors

* **Antoniadis Georgios**
* **Brunner Nicolas**
* **Vessaz François**


## License

SBB AG
