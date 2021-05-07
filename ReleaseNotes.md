# Release Notes SBBMobileDesignSystemSwiftUI für iOS & SwiftUI

## V0.3.2 - 07 May 2021

### Improvements
* Using new Swift 5.4 features: @ResultBuilder and optional casting in SwiftUI Views.

## V0.3.1 - 30 April 2021

### Improvements
* SBBCheckbox and SBBRadioButton are now animated.
* SBBCheckbox, SBBRadioButton, SBBTextField and SBBTextArea now display a separator bottom line by default since they are mostl used in a SBBFormGroup.
* Demo of SBBBubbleView: ScrollView now floats nicely under the BubbleView on scroll. Complemented README on how to use SBBBubbleView with a ScrollView. 

### Bugfix
* SBBBanner has correct color for dev and int environments.
* Correct padding for bottom line in active SBBTextArea.

## V0.3.0 - 09 March 2021

### Improvements
* Breaking change: Use of SwiftUI standard .navigationBarItems() ViewModifier instead of .navigationBarWithSBBIcon(). Reason: Ability to add a leading NavBar Item.
* .sbbEnvironmentBanner instead of parameter in .navigationBarItems().

## V0.2.8 - 02 March 2021

### Features
* New SBB KOM Icons

## V0.2.7 - 16 February 2021

### Improvements
* ModalViews can now be shown from any (child) view which does not cover the entire screen.
* Simplified usage of SBBToast

## V0.2.6 - 03 February 2021

### Improvements
* SBBOnboardingCardView has correct view alignment (title is aligned below image of flexible size)

## V0.2.5 - 02 February 2021

### Features
* Fixed background for .fullscreen SBBDialogue and devices with bottom safe area

## V0.2.4 - 28 January 2021

### Features
* SBBChip
* SBBDialogue
* SBBToast
* SBBProcessFlow
* SBBIconTextButtonStyle
* .modal ViewModifier to be used for SBBModalView (.sheet and .popup style)
* SBBMarker

### Improvements
* Padding of SBBSTertiaryButtonStyle is updated according to Sketch updates
* Disabled state colors of SBBSTertiaryButtonStyle is updated according to Sketch updates
* SBBIconButtonStyle now has optional border & negative style option (if displayed on colored background, e.g. NavigationBar)
* SBBSegmentedPicker now also features .red style (e.g. to be used below NavigationBar)
* New styles for SBBModalView: .full, .sheet and .popup

## V0.2.3 - 14 January 2021

### Features
* .rightSwipeButton(...) and .leftSwipeButton(...) view modifiers for SBBListItem now allow swippable action buttons.
* SBBRadioButton
* .sbbStyle(...) view modifier for Slider
* SBBLoadingIndicator

### Improvements
* SBBCheckBox is now completely grayed out when disabled
* SBBTextField can display an optional icon
* SBBTextField can display an optional error
* SBBTextField delete text button when editing

### Bugfix
* Correct dark mode color for disabled state in SBBTextField and SBBTextArea

## V0.2.2 - 11 December 2020

### Features
* .navigationBarWithSBBIcon() view modifier can now also display a banner (e.g. to highlight the app version like "TEST" or "DEV")

## V0.2.1 - 27 November 2020

### Bugfix
* Fix a voiceover bug with SBBTextField placeholder

## V0.2.0 - 09 November 2020

### Improvements
* Support for Swift package manager

## V0.1.27 - 04 November 2020

### Improvements
* Demo App redesign
* Demo App works better with Accessibility large font sizes
* SBBOnboardingCardView now displays Image nicely (without border) even while scaling

## V0.1.26 - 04 November 2020

### Improvements
* SBBTextField placeholder text has now the correct color

## V0.1.25 - 27 October 2020

### Bugfixes
* Font scaling with dynamic content sizes is now correct on iOS 14

### Improvements
* Improved layout of SBBOnboardingTitleView
* SBBBubbleView is treated as a header in VoiceOver

## V0.1.24 - 23 October 2020

### Improvements
* Improved layout of SBBOnboardingView

## V0.1.23 - 21 October 2020

### Improvements
* Improved french translations for SBBOnboarding

### Bugfixes
* SBBOnboardingCardView content is not clipped anymore if content of ScrollView is bigger than view (bug introduced with iOS 14)

## V0.1.22 - 19 October 2020

### Improvements
* Supports now SBB Fonts for UIFont
* Supports now SBB Colors for UIColor
* Breaking Change: Class SBBColor has been deleted. Please use the Color extension instead (Color.sbbColor(.red) instead of SBBColor.red )

## V0.1.21 - 07 October 2020

### Improvements
* SBBCheckBox now also supports custom content (and an optional image)
* SBBCheckBox VoiceOver frame is now also correct on iOS 14

## V0.1.20 - 18 September 2020

### Improvements
* Xcode 12 and iOS 14 support.

## V0.1.19 - 10 September 2020

### Improvements
* Added more accessibility identifiers to support XCUITests

## V0.1.18 - 1 September 2020

### Features
* UX Pictos library is embedded in MDS SwiftUI

## V0.1.17 - 28 August 2020

### Improvements
* Added accessibility identifiers to support XCUITests
* Fonts now support bold accessibility settings (LegibilityWeight)

## V0.1.16 - 14 August 2020

### Improvements
* Correct Positioning of SBB Icon in NavBar (and disabling button if no action passed)
* SBBListItem now hides image for all accessibility ContentSizes
* SBBModalView has now customizable title alignment
* SBBBubbleView now also accepts non-collapsible custom content

## V0.1.15 - 13 August 2020

### Features
* ViewModifier to add a SBB Icon as a right NavigationBarItem (.navigationBarWithSBBIcon)

### Bugfixes
* Center alignment for multiline titles in SBBOnboardingCardView

## V0.1.14 - 06 August 2020

### Bugfixes
* Horizontal padding for ButtonStyles

## V0.1.13 - 06 August 2020

### Features
* All SBB Icons (KOM & FPL) are added in the Asset Catalog
* Image extension for usage of SBB Icons

### Bugfixes
* SBBOnboarding Start/EndView are now always showing the buttons (specially with larger SizeCategories)

## V0.1.12 - 05 August 2020

### Features
* SBBBubbleView and SBBInfoView hide image if current SizeCategory is one of the accessibility ones
* New Helper SizeCategories

## V0.1.11 - 05 August 2020

### Bugfixes
* SBBOnboarding all texts are now localized
* SBBOnboarding ignoring SBB Icon in voiceover
* Correct ContentShape for Cards with initial offset

## V0.1.10 - 28 July 2020

### Features
* SBBSTertiaryButtonStyle & SBBIconButtonStyle (large & small)
* SBBOnboardingView
* SBBPaginationView
* SBBModalView
* Renaming of the old SBBInfoView to SBBInfoViewCollapsible
* New SBBInfoView
* CornerRadius View Extension
* SBBBubbleView can now also hide the NavigationBar background extension if it needs to be displayed not on top of the view

## V0.1.9 - 27 July 2020

### Bugfixes
* SBBBubbleView icon is vertically centered when title has multiple lines.

## V0.1.8 - 6 July 2020

### Bugfixes
* SBBFormGroup is now also redrawn when using a SBBCheckBox inside with an ObservableObject model.

## V0.1.7 - 18 June 2020

### Features
* SBBSecondaryButtonStyle

## V0.1.6 - 27 May 2020

### Features
* SBBFormGroup now shows a SBBDivider by default between Views.
* SBBListItem
* Toggle now has SBB-specific background color (red)

## V0.1.5 - 18 May 2020

### Bugfixes
* "Segmentation Fault: 11" Archive Build Error using Cocoapod is fixed

## V0.1.4 - 15 May 2020

### Features
* SBBBubbleView now accept Text instead of String as their parameters and a ViewBuilder for its Detail (e.g. so you can customize the font color)
* SBBInfoView now accept Text instead of String as their parameters (e.g. so you can customize the font color)
* Font Extension featuring all SBBFonts

### Bugfixes
* SBBBubbleView and SBBInfoView now support multiline for all their Text Views

## V0.1.3 - 08 May 2020

### Bugfixes
* Demo App now also works on iPad

## V0.1.2 - 08 May 2020

### Bugfixes
* Fix design of SBBCheckBox (icons & line bellow)
* Fix design of SBBTextField (line bellow with editing status)
* Fix design of SBBTextArea (line bellow with editing status)
* Fix a bug in demo app with segmented picker for color scheme

## V0.1.1 - 07 May 2020

### Features
* First internal distribution using Testflight

## V0.0.17 - 5 May 2020

### Bugfixes
* Fix padding on SBBCheckBox
* Fix padding and spacing for SBBGroupForm
* Fix SBBTextField layout when using big dynamic types

## V0.0.16 - 23 Apr 2020

### Bugfixes
* Localization of placeholder in SBBTextArea
* Placeholder color for SBBTextField and SBBTextArea
* Remove padding above title in SBBFormGroup

## V0.0.15 - 17 Apr 2020

### Features
* SBBCheckBox
* SBBTextField
* SBBTextArea
* SBBFormGroup
* SBBPrimaryButtonStyle

### Bugfixes
* Display SBBBubbleView title on multiple line when text is too long and/or too big
* Fix ArrayBuilder of SBBSegmentedPicker

## V0.0.14 - 15 Apr 2020

### Features
* SBBInfoView
* SBBBubbleView with new arrow styling (featuring a circular border around the arrow) and animated toggle.
* SBBSegmentedPicker has now border around selected segment in dark mode.
* New semantic SBBColor .border.
* New semantic SBBColor .tabViewBackground replaces .controlBackground.
* New official SBBColors .charcoal and .shadow.

### Bugfixes
* Updated background colors of SBBBubbleView and SBBSegmentedPicker

## V0.0.13 - 31 Mar 2020

### Bugfixes
* With iOS 13.4 Apple has fixed NavigationBar tint bug and changed the way it works. So we use appearance to customize it.

## V0.0.12 - 24 Mar 2020

### Bugfixes
* SBBSegmentedPicker shadow only on inner element

## V0.0.11 - 10 Mar 2020

### Bugfixes
* SBBBubbleView reloading voiceover on title change

## V0.0.10 - 05 Mar 2020

### Features
* SBBBubbleView with shadows

### Bugfixes
* SBBDivider leading to app crash (due to .infinity width) fixed

## V0.0.9 - 24 Feb 2020

### Features
* SBBSegmentedPicker
* SBBDivider
* new semantic SBBColor .controlBackground
* new SBBFont .tableHeader

### Bugfixes
* SBBBubbleView background red now reflects the opacity from the SBBNavigationBar (to be removed once the opacity can be set to false on the NavBar)
* SBBBubbleView voiceover now only reads the hint, if the view is expandable (i.e. has a detail text)

## V0.0.5 - 14 Feb 2020

### Features
* SBBColors (including semantic colors)
* SBBFonts
* BubbleView
* NavigationBar

### Bugfixes
