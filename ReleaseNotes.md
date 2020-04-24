# Release Notes SBBMobileDesignSystemSwiftUI für iOS & SwiftUI

## V0.0.16 - 23 Apr 2020

### Bugfixes
* Localization of placeholder in SBBTextArea
* Placeholder color for SBBTextField and SBBTextArea

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
