# Release Notes SBBDesignSystemMobileSwiftUI for iOS & SwiftUI

## v1.2.0 - 3 May 2024
### Features
* New components:
  * SBBFooterBox to display a footer
  * SBBHeaderBox to display a footer

### Improvements
* New icons
* SBBModalView: added the option to hide the cancel button.
  
### Bugfix
* SBBNotification and SBBPromotionBox: elements are now correctly read by VoiceOver.

## v1.1.3 - 2 February 2024
### Improvements
* SBBNotification: icon can be hidden

## v1.1.2 - 30 January 2024
### Improvements
* SBBNotification: a retry button is added

## v1.1.1 - 04 January 2024
### Improvements
* SBBNotification: can also stay open (close button not present).
### Deprecations
* Renaming of the typographie names according to the revised DSM (e.g. xlarge instead of SBBHeader). Old typographie names are deprecated and will be removed in a future version.

## v1.1.0 - 03 October 2023
### Features
* New components:
  * SBBUpDnCounterView to display an up and down counter
  * SBBMessage to display a message with an illustration
  * SBBPromotionBox to display a promotion box
  * SBBDatePicker to display a date picker
  * SBBStatus to display a status (alert, warning, success or info)
  * SBBNotification to display a status notification (alert, warning, success or info)
* SBBTabView: a badge can be added to the tab bar icon
* New color .redDark is added

### Improvements
* SBBTabView: accessibility area for a tab is bigger
* SBBOnboardingView: accessibility is improved (e.g. text completely visible with all font sizes)
* SBBMessage: accessibility label for 'retry' button is added
* SBBIcons updated

### Deprecations
* Initializing an SBB List Item with `init(label: String, image: Image)` or `init(label: String, type: SBBListItemType)` is deprecated and will be removed in a future version. `image` is replaced with `leftImage` and the right image (decided by SBBListItemType) can now be customized using `rightImage`.

## v1.0.5 - 24 April 2023

### Bugfix
* SBBTabbar now keeps the Navigation persistence when switching Tab. Before it always jumped back to Root View.


## v1.0.4 - 05 April 2023

### Improvements
* SBBSegmentedPicker update according to the updated design template


## v1.0.3 - 21 March 2023

### Improvements
* re-import the newest SBB Icons / SBB Pictos
* All SBB Icons / SBB Pictos are now present inside the "SBBIconName.swift" enum. You can create an SBB Image with the `init(sbbIcon: SBBIcon)` initializer 

### Deprecations
* Initializing an SBB Image with `init(sbbName: String)` or `init(sbbName: String, size: SBBIconSize)` is deprecated and will be removed in a future version

### Breaking changes
* Attention: certain icons have been renamed. Please check your code whether the used icon-string exists. Better: migrate to the new `init(sbbIcon: SBBIcon)` initializer 


## V1.0.2 - 08 March 2023

### Features
* Some SBBTextfields improvements: Boxed available. Clear button can be disabled. Bottom line optional even in edit mode.

## V1.0.1 - 25 January 2022

### Features
* SBBTabView to display a tab bar at the bottom of the page.

## V1.0.0 - 05 January 2022

### Features
* SBB DSM is now publicly available in Github as OpenSource

## V0.6.0 - 23 November 2021

### Improvements
* Updated all elements according to newest Figma version. 
* SBBRadioButton and SBBCheckbox now reflect theming (color) changes.
* Breaking change: Renaming of init parameters of SBBRadioButton and SBBCheckbox according to newest Figma version. 
* Breaking change: SBBRadioButton and SBBCheckbox now feature an optional subtitle instead of customizable content.
* Breaking change: Renaming of SBBInfoViewCollapsible to SBBAccordion.
* Breaking change: Renaming of SBBModalViewStyle from .sheet to .bottom.

## V0.5.2 - 12 November 2021

### Improvements
* Demo App can now switch color theme while running

## V0.5.2 - 02 November 2021

### Improvements
* SBBColor .modalBackground is not public

## V0.5.1 - 01 November 2021

### Improvements
* showBackButton in SBBModalView is not a Binding anymore

## V0.5.0 - 21 October 2021

### Features
* You can now set your own (color) theme

### Improvements
* Background Color of SBBModalView and SBBDialogue in fullscreen mode is now distinct from normal background color.
* Removed iOS 13 support (now requires iOS 14 or above) and simplified code.
* Simplified usage of SBBModalView (no need to inject a SBBModalViewModel and use a .sbbModalContainer ViewModifier anymore).

### Bugfix
* NavigationBar background color fix for iOS 15 when installing directly over XCode.
* Double SBB Icon in NavigationBar when setting new trailing Icon is now fixed.

## V0.4.10 - 14 October 2021

### Improvements
* SBBBubbleView can now optionally display custom content instead of a subtitle.
* SBBOnboardingView now has improved handling of non-active cards with safe areas.

## V0.4.9 - 06 October 2021

### Improvements
* Reduced top-offset (8pt) for OnboardingCards hidden behind current card.

## V0.4.8 - 08 September 2021

### features
* New ViewModifier sbbScreenPadding() which applies SBB specific padding to a Screen

### Improvements
* Update Demo App with the new padding

## V0.4.7 - 06 August 2021

### Improvements
* Final illustrations for Demo App Onboarding

## V0.4.6 - 05 August 2021

### Bugfix
* SBBBubbleView: VoiceOver fix for SBBBubbleView in .regular SizeClass with fixed content (is now read separately)

## V0.4.5 - 04 August 2021

### Improvements
* SBBOnboardingTitleView now features an optional subtitle

## V0.4.4 - 29 July 2021

### Improvements
* New SBB Icons were added

## V0.4.3 - 28 July 2021

### Features
* Added SBBRadioButtonGroup (and modified SBBRadioButton)

### Improvements
* SBBCheckBox and SBBRadioButton is now tappable on it's entire width

### Bugfix
* Bottomline for SBBRadioButton is now displayed by default.

## V0.4.2 - 15 July 2021

### Improvements
* Linelimit of 1 for SBBSegmentedPicker and SBBButtons.

## V0.4.1 - 15 July 2021

### Features
* SBBPrimaryButtonStyle now also supports floating buttons not stretching the entire view (using sizeToFit: true as init parameter).

### Improvements
* New Styling for ListItem Footnote

## V0.4.0 - 16 June 2021

### Features
* sbbStyle() View Modifier that applies basic view styling.

### Improvements
* Support for landscape mode / larger content sizes.
* Demo App: Quick selection for contentSizeCategory.

## V0.3.3 - 04 June 2021

### Improvements
* Demo App now showcases an Onboarding.
* Demo App: Improved ColorsView, documentation links on MainView, renaming to DMS.
* ReadMe: Added documentation links.
* Markup documentation for all elements.

## V0.3.2 - 21 May 2021

### Features
* SBBBanner now also supports "poc" environment.

### Improvements
* Using new Swift 5.4 features: @ResultBuilder and optional casting in SwiftUI Views.
* Increased hit area for .leftSwipeButton and .rightSwipeButton ViewModifiers for SBBListItem.
* SBBListItem now shows a separator line on the bottom as default.

### Bugfix
* .sbbModalContainer() ViewModifier does not block TouchEvents for underlying UIKit Views anymore.

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
* UX Pictos library is embedded in DSM SwiftUI

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
