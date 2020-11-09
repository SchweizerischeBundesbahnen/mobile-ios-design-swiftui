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

## Add the library to your project with Swift package manager

Add in Xcode this package:
```
For HTTPS: https://code.sbb.ch/scm/kd_esta_mobile/esta-mobile-ios-design-swiftui.git
For SSH: ssh://git@codessh.sbb.ch:7999/kd_esta_mobile/esta-mobile-ios-design-swiftui.git
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

Initializing the Library in your app will setup all NavigationBars (& StatusBars) in the SBB style.
If you want the SBB Icon as a right NavigationBarItem (recommended) you will need to add the .navigationBarWithSBBIcon ViewModifier.

```
    NavigationView {
        Group {
            ContentView()
        }
            .navigationBarTitle("SBB MDS SwiftUI", displayMode: .inline)    // SBB Design only supports .inline for the time being
            .navigationBarWithSBBIcon()     // Display SBB Icon as a right NavigationBarItem
            .navigationBarWithSBBIcon(onTouchAction: {  // Display SBB Icon as a right NavigationBarItem with custom action
                // your action here
            })
    }
```

## Colors

The Color / UIColor class has been extended to support SBB Color. They contains two types of colors:
1. The SBB Color palette (e.g. Color.sbbColor(.red) ). Those colors are the same for all themes (light or dark).
2. Semantic colors (e.g. Color.sbbColor(.textBlack) ). Those colors return the matching color for the current theme (light or dark). This means that you will get a different color for light theme than for dark theme.

You can use colors like so:

```
    Color.sbbColor(.red)    // returns Color
    UIColor.sbbColor(.red)  // returns UIColor, for UIViewRepresentable or UIViewControllerRepresentable
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

### Using UIFont in UIKit

Sometimes it it necessary to create a UIViewRepresentable or UIViewControllerRepresentable. Inside these you can use SBB Fonts with UIFont as follows:

```
    headerWhiteLabel.font = .sbbHeader
    headerWhiteLabel.textColor = .sbbColor(.textWhite)
```

## Icons

There are 3 different types of SBB Icons: FPL icons are only available in one size and have a fixed color. KOM icons are available in up to three sizes and inherit the foreground color. Pictograms are only available in one size.

```
    Image(sbbName: "product-ir-40")                 // FPL icons
    Image(sbbName: "station", size: .small)         // KOM icons (note that not all icons are available in all sizes)
    Image(sbbName: "Zug_r")                         // Pictograms
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

SBBBubbleView is a view that is mainly used right underneath the SBBNavigationBar. You need to set its image and title. Optional parameters are its subtitle, titleAccessibility, subtitleAccessibility, fixed content as a ViewBuilder (shown at the bottom of the BubbleView), collapsed state and collapsible content as a Viewbuilder defining what will be shown in the expandable part (use the Accessibility parameters to modify the voiceover Texts). You can pass as many Views inside the ViewBuilders as you want and they will be stacked vertically by default. You can also use SBBBubbleView anywhere in your View, in that case you need to set the extendNavigationBarBackground parameter to false to hide the red top background.

If your BubbleView contains no detail (and is not expandable), you can use it like so:
```    
    var body: some View {
        VStack {
            // The SBBBubbleView always needs to be the first element inside a VStack (to position it right below the SBBNavigationBar)
            SBBBubbleView(image: Image("sample"), title: Text("Your title"))    
            // other elements below SBBBubbleView
        }
    }
```

If you want your BubbleView to be expandable, you can use it like so:
```
    @State var expanded = true
    
    var body: some View {
        VStack {
            // The SBBBubbleView always needs to be the first element inside a VStack (to position it right below the SBBNavigationBar)
            SBBBubbleView(image: Image("sample"), title: Text("Your title"), detail: [Text("Your longer text")], expanded: $expanded, expandedContent: {   
                Text("Your longer text")    // you can add whatever Views you want inside ViewBuilder for the Detail part of BubbleView
            })
            // other elements below SBBBubbleView
        }
    }
```

If you want your BubbleView to have non collabsible custom content, you can use it like so:
```
    @State var expanded = true
    
    var body: some View {
        VStack {
            // The SBBBubbleView always needs to be the first element inside a VStack (to position it right below the SBBNavigationBar)
            SBBBubbleView(image: Image("sample"), title: Text("Your title"), detail: [Text("Your longer text")], fixedContent: {   
                Text("Your longer text")    // you can add whatever Views you want inside ViewBuilder for the bottom part of BubbleView
            })
            // other elements below SBBBubbleView
        }
    }
```

## SBBInfoView

SBBInfoView is an expandable view with an image and a text. It is usually displayed as the upmost View to provide some information about the current screen.

You can use the SBBInfoView it like so:

```
    @State var expanded = true
    
    var body: some View {
    SBBInfoView(image: Image("Your Image"), text: Text("Your title"))
    }
```


## SBBInfoViewCollapsible

SBBInfoViewCollapsible is an expandable view with a title and a text to be used for showing general information. You need to set its title. Optional parameters are its detail, titleAccessibility,  and detailAccessibility (use the Accessibility parameters to modify the voiceover Texts).

You can use the SBBInfoView it like so:

```
    @State var expanded = true
    
    var body: some View {
        SBBInfoViewCollapsible(title: Text("Your title"), detail: Text("Your longer text"), expanded: $expanded)
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

SBBCheckBox is a SBB-styled SwiftUI Toggle. You can use it by passing Text and optionally Image as init parameters. Alternatively you can also pass your custom View(s) as content. By default, SBBCheckBox shows a separator line at its bottom since it will mostly be used inside SBBFormGroup. However you can also optionally hide the separator line.

```
    @State private var isOn = true
    @State private var disabled = true
    
    var body: some View {
        VStack {
            SBBCheckBox(isOn: $isOn, label: Text("Label"))
            SBBCheckBox(isOn: $isOn, image: Image("your image"), label: Text("Label"))  // with additional image
                .disabled(disabled)
            SBBCheckBox(isOn: $isOn) {                                                  // with custom content
                // Your custom content
            }
            SBBCheckBox(isOn: $isOn, label: Text("Label"), showTextFieldLine: false)    // hiding the separator line
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

## SBBPaginationView

SBBPaginationView is used in a pagination context to give the user a quick overview on how many pages are available and which one is currently displayed.

```    
    @State var currentPageIndex: Int = 0
    var pages: [View]
    
    var body: some View {
        SBBPaginationView(currentPageIndex: $currentPageIndex, numberOfPages: pages.count)
    }
```

## SBBOnboardingView

SBBOnboardingView is used to present basic app functionality to your users on the first  app launch. It consists of a StartView, multiple CardViews and an EndView. You can specify StartView and EndView content using StartViewModel and EndViewModel. You can pass up to 6 Views which will be displayed as cards. In a normal setting, you will use SBBOnboardingCardView for the cards, however you can use any custom view you wish if desired.

```   
    let startViewModel = SBBOnboardingTitleViewModel(image: Image("Your Image"), title: Text("Your Title"))
    let endViewModel = SBBOnboardingTitleViewModel(image: Image("Your Image"), title: Text("Your Title"))
    
    @State var onboardingState: SBBOnboardingState = .hidden    // You will typically persist this state to UserDefaults
    @State private var currentOnboardingCardIndex: Int = 0

    var body: some View {
        Group {
            if onboardingViewModel.state == .hidden {
                // your ContentView here (NavigationView goes also here, if you want to use it)
            } else {
            SBBOnboardingView(state: $onboardingState, currentCardIndex: $currentOnboardingCardIndex, startViewModel: startViewModel, endViewModel: endViewModel) {
                    // add SBBOnboardingCardViews here
                    SBBOnboardingCardView(image: Image("Your Image"), title: Text("Card 1"), text: Text("Text Card 1"))
                    SBBOnboardingCardView(image: Image("Your Image"), title: Text("Card 2"), text: Text("Text Card 2"))
                }
            }
        }
    }
```

This also possible with a shortand init when having just one `SBBOnboardingCardView`.

```   
    let startViewModel = SBBOnboardingTitleViewModel(image: Image("Your Image"), title: Text("Your Title"))
    let endViewModel = SBBOnboardingTitleViewModel(image: Image("Your Image"), title: Text("Your Title"))
    
    @State var onboardingState: SBBOnboardingState = .hidden    // You will typically persist this state to UserDefaults

    var body: some View {
        Group {
            if onboardingViewModel.state == .hidden {
                // your ContentView here (NavigationView goes also here, if you want to use it)
            } else {
            SBBOnboardingView(state: $onboardingState, startViewModel: startViewModel, endViewModel: endViewModel) {
                    SBBOnboardingCardView(image: Image("Your Image"), title: Text("Only card"), text: Text("Text Card"))
                }
            }
        }
    }
```

### SBBOnboardingTitleView

SBBOnboardingTitleView is used for the start and end view of SBBOnboardingView. You can specify an image and a text to display.

```   
    SBBOnboardingTitleView(image: Image("Your Image"), title: Text("Willkommen bei Ihrer SBB App"))
```

### SBBOnboardingCardView

SBBOnboardingCardView is usually passed in the ViewBuilder of SBBOnboardingView. In a normal setting you specify an image, title and text. However you can also add whatever custom view you want using its ViewBuilder. You can also pass an action which will be executed once the user swipes to the next card (e.g. to ask for certain app permissions).

```   
    SBBOnboardingCardView(image: Image("Your Image"), title: Text("Your Title"), text: Text("Your Text"))
    SBBOnboardingCardView(image: Image("Your Image"), title: Text("Your Title"), text: Text("Your Text"), actionOnCardDisappear:{
        // your action here
    })
    SBBOnboardingCardView(image: Image("Your Image"), title: Text("Your Title"), text: Text("Your Text")) {
        // Your custom View here
    }
    SBBOnboardingCardView {
        // Your custom View here
    }
```


## SBBModalView

SBBModalView is used to display a View above another View, typically using .sheet. If you want a back button in your ModalView header, set the showBackButton parameter to true and pass an action for the actionOnBackButtonTouched parameter.

```    
    @State var showingModalView = false
    
    var body: some View {
        Button(action: {
            self.showingModalView = true
        }) {
            Text("Click Me")
        }
            .sheet(isPresented: $showingModalView, content: {
                SBBModalView(title: Text("Your title"), isPresented: self.$showingModalView) {
                    YourContentView()
                }
            })
    }
```

## SBBButtonStyle

SwiftUI ButtonStyle implementations of SBB primary / secondary / tertiary (large & small) / icon (large & small) buttons. 

```    
    var body: some View {
        Button(action: myAction) {
            Text("Your Button")
        }
            .buttonStyle(SBBPrimaryButtonStyle())
            //.buttonStyle(SBBSecondaryButtonStyle())
            //.buttonStyle(SBBTertiaryButtonStyle(size: .small))   // .large is default
        
        Button(action: myAction) {
            Image("Your image")
                .resizable  // resizable needs to be set if your Image is not 24x24 (same for .large & .small)
        }
            .buttonStyle(SBBIconButtonStyle(size: .small))   // .large is default
    }
```

## Toggle

The standard SwiftUI toggle can be used. It will by default feature the SBB specific background color (red). 

## CornerRadius

CornerRadius is a View Extension which allows to add a corner radius to specific corners only.

```    
    YourView()
        .cornerRadius(16, corners: .bottomRight)
```

## ResizeToContentSizeCategory

ResizeToContentSizeCategory is an Image Extension which allows to the image to dynamically resize according to the current ContentSizeCategory.

```    
    Image("Your Image")
        .resizeToContentSizeCategory(originalHeight: 36)
```

## Authors

* **Antoniadis Georgios**
* **Brunner Nicolas**
* **Vessaz François**


## License

SBB AG
