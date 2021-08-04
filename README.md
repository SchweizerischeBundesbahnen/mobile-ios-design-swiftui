# ESTA library: Design System Mobile for iOS & SwiftUI

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

Markup : * Markup :  [SBB Design System Mobile documentation](https://digital.sbb.ch/de/design-system-mobile-new "Design System Mobile documentation") (new version since 2021) 
Markup : * Markup :  [AppBakery libraries](https://sbb.sharepoint.com/sites/app-bakery/SitePages/Mobile-Libraries.aspx "AppBakery liraries")
Markup : * Markup :  [Sketch](https://www.sketch.com/s/53b0a518-8d44-42a7-a712-bc211dbb7d78 "Sketch library")
Markup : * Markup :  [Figma](https://www.figma.com/file/56woOj0p1qEOrZiTzi4mJ7/SBB-Mobile-Library-%28draft%29 "Figma library")

Markup :  [https://code.sbb.ch/projects/KD_ESTA_MOBILE/repos/esta-mobile-ios-design-swiftui/](https://code.sbb.ch/projects/KD_ESTA_MOBILE/repos/esta-mobile-ios-design-swiftui/ "https://code.sbb.ch/projects/KD_ESTA_MOBILE/repos/esta-mobile-ios-design-swiftui/") contains the following documentation:
Framework API is generated in /docs on every build if Jazzy is installed.
Sample app SBBMobileDesignSystemSwiftUIDemo is included in Xcode project

In the next chapters you can see a quick resume of how to use the existing UI elements.

## SBBStyle

Applies SBB styling to any View. You typically apply the sbbStyle() View modifier to the umpost View in the hierarchy. It applies a specific background color, adds a SBBNavigationBarSBBIcon as trailing Navigation Bar Item and sets a default Font.

```    
    YourView()
        .sbbStyle()
```

## NavigationBar

Initializing the Library in your app will setup all NavigationBars (& StatusBars) in the SBB style.
If you want the SBB Icon as a trailing NavigationBarItem (recommended) you will need to add a SBBNavigationBarSBBIcon using the standard SwiftUI .navigationBarItems(trailing:) ViewModifier.

```
    NavigationView {
        Group {
            ContentView()
        }
            .navigationBarTitle("SBB DSM SwiftUI", displayMode: .inline)    // SBB Design only supports .inline for the time being
            .navigationBarItems(trailing: SBBNavigationBarSBBIcon())     // Display SBB Icon as a trailing NavigationBarItem
            .navigationBarItems(trailing: SBBNavigationBarSBBIcon(onTouchAction: { // Display SBB Icon as a trailing NavigationBarItem with custom action
                // your action here
            }))
            .sbbEnvironmentBanner(.dev) // Display a banner above the SBB Icon (e.g. to highlight the environment).
    }
```

## SBBEnvironmentBanner

The .sbbEnvironmentBanner ViewModifier can be used to display a banner over the NavigationBar to highlight the current environment (none (= prod), dev, test, int). You can also style your own Banner.

```
    NavigationView {
        // Your content
    }
        .sbbEnvironmentBanner(.dev) // default banner styles
        .sbbEnvironmentBanner(Text("Custom"), textColor: Color.sbbColor(.black), backgroundColor: Color.sbbColor(.lemon))   // create your own banner style
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

If the view under your BubbleView is a ScrollView, you need to make sure that the View will scroll nicely under your BubbleView. To do so, use a ZStack and padding-top on the first element inside the ScrollView:
```    
    @State var bubbleViewHeight: CGFloat = 0

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    // your ScrollView content here
                }
                    .padding(.top, 16 + bubbleViewHeight)
            }
            SBBBubbleView(image: Image("sample"), title: Text("Your title"))    
                .overlay(
                    GeometryReader { geometry in
                        Color.clear.onAppear {
                            self.bubbleViewHeight = geometry.size.height
                        }
                    }
                )
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

SBBSegmentedPicker is the SBB-Implementation of the standard SwiftUI Picker with SegmentedPickerStyle. You need to set its current selection and all its unique tags (of type Hashable). Optionally you can set it's style to .red, if you plan to use it as a NavigationBar extension.

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
            SBBCheckBox(isOn: $isOn, label: Text("Label"), showBottomLine: false)    // hiding the separator line
        }
    }
```

## SBBRadioButtonGroup

SBBRadioButtonGroup can be used when the user needs to select one of multiple options. The number of tags must be the same number as the number of SBBRadioButtons.

```
    enum TrainCompany: CaseIterable {
        case SBB
        case SNCF
    }
    
    @State private var selectedTrainCompany: TrainCompany = .SBB
    
    var body: some View {
        SBBRadioButtonGroup(title: "Your title", selection: $selectedTrainCompany, tags: TrainCompany.allCases) {
            SBBRadioButton(label: "SBB")
            SBBRadioButton(image: Image(sbbName: "train", size: .small), label: "SNCF")
        }
    }
```

## SBBRadioButton

SBBRadioButton is typically used inside a SBBRadioButtonGroup. However, you can also create your own view with SBBRadioButtons. You can use it by passing Text and optionally Image as init parameters. Alternatively you can also pass your custom View(s) as content. By default, SBBRadioButton shows a separator line at its bottom. However you can also optionally hide the separator line. Use the .isSelected(Bool) ViewModifier to set its selected state.

```
    @State private var radioButton1IsSelected = true
    @State private var radioButton2IsSelected = false
    
    var body: some View {
        VStack {
            SBBRadioButton(label: Text("Label"))
                .isSelected(radioButton1IsSelected)
                .highPriorityGesture(
                    TapGesture().onEnded {
                        withAnimation {
                            radioButton1IsSelected = true
                            radioButton2IsSelected = false
                        }
                    }
                )
            SBBRadioButton() {
                // Your custom content
            }
                .isSelected(radioButton2IsSelected)
                .highPriorityGesture(
                    TapGesture().onEnded {
                        withAnimation {
                            radioButton1IsSelected = false
                            radioButton2IsSelected = true
                        }
                    }
                )
        }
    }
```

## SBBTextField

SBBTextField is a SBB-styled SwiftUI TextField with floating label. It optionally features a placeholder label and an icon. By default, SBBTextField shows a separator line at its bottom since it will mostly be used inside SBBFormGroup. However you can also optionally hide the separator line.

```
    @State private var text = ""
    
    var body: some View {
        VStack {
            SBBTextField(text: $text)
            SBBTextField(text: $text, label: "Placeholder")
            SBBTextField(text: $text, icon: Image(sbbName: "route-circle-start", size: .small))
            SBBTextField(text: $text, showBottomLine: false)    // hiding the separator line
        }
    }
```

## SBBTextArea

SBBTextArea is a SwiftUI equivalent of UITextView with SBB style. By default, SBBTextArea shows a separator line at its bottom since it will mostly be used inside SBBFormGroup. However you can also optionally hide the separator line.

```
    @State private var text = ""
    
    var body: some View {
        VStack {
            SBBTextArea(text: $text)
            SBBTextArea(text: $text, showBottomLine: false)    // hiding the separator line
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

SBBListItem is usually used inside a SBBFormGroup and in combination with NavigationLink. You need to set its label. Optional parameters are its labelAccessibility, image, footnote, footnoteAccessibility and its type (SBBListItemType which is by default .normal). By default, SBBListItem shows a separator line at its bottom since it will mostly be used inside SBBFormGroup. However you can also optionally hide the separator line.

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
To display swipe action buttons, use the designated view modifiers`.
```    
    SBBListItem(label: Text("Label"))
        .rightSwipeButton(label: Text("Right Action"), action: {
            // your code here
        })
        .leftSwipeButton(label: Text("Left Action"), action: {
            // your code here
        })
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

## SBBLoadingIndicator

SBBLoadingIndicator is used to display a loading state. It has two different sizes and 3 different styles (colours).

```    
    SBBLoadingIndicator()   // default size is .normal, default style is .red
    SBBLoadingIndicator(size: .small, style: .grey)
```

## SBBChip

SBBChip is used to provide quick filters to a list. It has a selected/not selected state and displays the number of items the filter applies to if not selected.

```    
    @State var filterIsActive: Bool = false

    var body: some View {
        SBBChip(label: Text("Trains only"), isSelected: $filterIsActive, numberOfItems: 2)
            .disabled(true) // optionally: disable user interaction
    }
    
```

## SBBMapMarker

SBBMapMarker can be used to display content on a map. There are 3 available styles: .red, .blue and .black. Use .blue style for pictograms.

```    
    SBBMapMarker(icon: Image(sbbName: "Zug_r"), style: .blue)
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

SBBOnboardingTitleView is used for the start and end view of SBBOnboardingView. You can specify an image, a title and an optional subtitle to display.

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
SBBModalView is used to display a View above another View, typically using the .sheet() or sbbModal() ViewModifier. There are three different styles available: .full (to be used inside .sheet() ViewModifier), .popup and .sheet (to be used inside .sbbModal() ViewModifier). If you want a back button in your ModalView header, set the showBackButton parameter to true and pass an action for the actionOnBackButtonTouched parameter. To use SBBModalView, you need to create a SBBModalViewModel which nees to be added as EnvironmentObject in your SceneDelegate (and to new Views pushed using NavigationLink). You also need to add the .sbbModalContainer() ViewModifier to your upmost ContentView (you can also add it as an overlay to a specific view, if modals will only be shown from this specific view and the view covers the entire screen).

1. Inside SceneDelegate: Create a SBBModalViewModel and add it as EnvironmentObject to the MainView:
```    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        ...
        
        let modalViewModel = SBBModalViewModel()
        
        // Create the SwiftUI view that provides the window contents.
        var contentView = AnyView(MainView()
            .environmentObject(modalViewModel)
            
        ...
    }
```

2. Inside your MainView (root view): apply the .sbbModalContainer() ViewModifier:
```    
    var body: some View {
        NavigationView {
            Group {
                ...
            }
                .sbbModalContainer()
        }
    }
```

3. Use .sbbModal() to show a custom ModalView or a SBBModalView:
```    
    @State var showingModalView = false
    
    var body: some View {
        Button(action: {
            self.showingModalView = true
        }) {
            Text("Click Me")
        }
            .sheet(isPresented: $showingModalView) {    // to be used for .full style
                SBBModalView(title: Text("Your title"), style: .full, isPresented: self.$showingModalView) {
                    YourContentView()
                }
            }
            .sbbModal(isPresented: $showingModalView) {    // to be used for .popup or .sheet style
                SBBModalView(title: Text("Your title"), style: .popup, isPresented: self.$showingModalView) {
                    YourContentView()
                }
            }
    }
```

## SBBDialogue

SBBDialogue is used to interact with the user to either prompt a reaction from his side (e.g. choose an action) or to inform him about an error. It has 3 different presentation-style options: fullscreen (by using the .modal() ViewModifier), inline or list.

```    
    @State var showingDialogue = false
    
    var body: some View {
        VStack {
            Button(action: {
                self.showingDialogue = true
            }) {
                Text("Click Me")
            }
            
            // error case with retry-button
            SBBDialogue(title: Text("title"), label: Text("label"), errorCode: Text("404"), style: .fullscreen, imageStyle: .sad) {
                Button(action: { retry() }) {
                    Image(sbbName: "arrows-circle", size: .small)
                }
                    .buttonStyle(SBBIconButtonStyle())
            }
        }
            .sbbModal(isPresented: $showingModalView) {    // to be used for .fullscreen style, check the SBBModalView documentation on how to use the .sbbModal ViewModifier
                // choose an action
                SBBDialogue(title: Text("title"), label: Text("label"), style: .fullscreen) {
                    Button(action: { option2Action() }) {
                        Text("Option 2")
                    }
                        .buttonStyle(SBBSecondaryButtonStyle())
                    Button(action: { option1Action() }) {
                        Text("Option 1")
                    }
                        .buttonStyle(SBBSecondaryButtonStyle())
                    Button(action: { primaryAction() }) {
                        Text("Primary action")
                    }
                        .buttonStyle(SBBPrimaryButtonStyle())
                }
            }
    }
```

## SBBToast

SBBToast provides simple feedback about an operation in a small popup. SBBToasts automatically disappear after a timeout. To use SBBToast, you need to create a SBBToastService which then can be used inside of your ViewModels or  Views to trigger toast messages. You also need to add the SBBToastContainerView as an overlay to your MainView (you can also add it as an overlay to a specific view, if toasts will only be shown from this specific view).

1. Inside SceneDelegate: Create a SBBToastService and add it as EnvironmentObject to the MainView:
```    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        ...
        
        let toastService = SBBToastService()
        
        // Create the SwiftUI view that provides the window contents.
        var contentView = AnyView(MainView()
            .environmentObject(toastService)
            
        ...
    }
```

2. Inside your MainView (root view): apply the sbbToastContainer() ViewModifier:
```    
    var body: some View {
        NavigationView {
            Group {
                ...
            }
                .sbbToastContainer()
        }
    }
```

3. Use showToast() to trigger a toast notification from your current view or from a ViewModel:
```    
    @EnvironmentObject var toastService: SBBToastService

    var body: some View {
        Button(action: {
            toastService.showToast(SBBToast(label: Text("Hello Toast")))
        }) {
            Text("Show Toast")
        }
    }
```

## SBBProcessFlow

SBBProcessFlow is used to display the current process state (e.g. in a checkout process). Images are used to describe the single steps (typically in size .small, however you can use any size since the images will get resized if needed). You can add as many steps/images as you like, but need to make sure, there's enough space (width) for them to be displayed correctly.

```    
var currentStepIndex = 0

var body: some View {
    SBBProcessFlow(currentStepIndex: currentStepIndex, images: [Image(sbbName: "image-1", size: .small), Image(sbbName: "image-2", size: .small)])
}
```

## SBBButtonStyle

SwiftUI ButtonStyle implementations of SBB primary / secondary / tertiary (large & small) / icon (large & small, normal & negative (to be used on colored backgrounds, e.g. NavBar), border & no border) / iconText buttons. 

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
            
        Button(action: myAction) {
            VStack(alignment: .center, spacing: 4, content: {   // alignment and spacing need to be set exactly like this
                Image(sbbName: "station", size: .large)
                Text("Station")
            })
        }
            .buttonStyle(SBBIconTextButtonStyle())
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

## Slider

To apply sbb styling to the normal SwiftUI Slider, apply the .sbbStyle() ViewModifier.

```    
    Slider(value: $value, in: 0.0...100.0, step: 1.0)
        .sbbStyle() // without images
        .sbbStyle(imageLeft: Image(sbbName: "walk-slow", size: .small), imageRight: Image(sbbName: "walk-fast", size: .small))  // with images on the left and right side of the slider
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
