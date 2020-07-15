# Release Notes SBBMobileDesignSystemSwiftUI für iOS & SwiftUI

## V0.1.9 - 17 July 2020

### Features
* SBBSTertiaryLargeButtonStyle and SBBSTertiarySmallButtonStyle (without specific design for disabled state, is still missing in Sketch template)
* SBBOnboardingView
* SBBPaginationView

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
