# ``SBBMobileDesignSystemSwiftUI``

Easily integrate SBB Look & Feel into your SwiftUI app.

## Overview

This framework allows you to easily create a SwiftUI user interface for your app according to the SBB Design System Mobile. Its views are optimzied for light/dark mode, accessibility (VoiceOver and Display & Text Size) and different Size Classes (regular and compact). You can also customize it to your own color-theming to change the primary color according to your needs.

![Devices showing SBB DSM SwiftUI in use.](SBBDSM_Devices.png)

Note that this frameworks contains many ViewModifiers in form of View Extensions. Unfortunately Swift DocC does not yet support documentation of extensions to types outside a package. You'll need to check the source code for the documentation of those. Here's a complete list of all ViewModifiers in form of View Extensions included in this framework:
* View.sbbStyle(): Applies SBB styling to a View.
* View.sbbScreenPadding(): Applies SBB specific padding to a View (typically a View covering the entire screen).
* View.sbbEnvironmentBanner(banner: ``SBBEnvironmentBanner``): Applies a banner (typically to a NavigationBar) indicating the app's environment.
* Color.sbbColor(name: ``SBBColorName``): Returns the specified SBB color.
* Image(sbbName: String, size: ``SBBIconSize``): Returns the specifed SBB icon.
* Slider.sbbStyle(imageLeft: Image, imageRight: Image): Applies SBB styling to a Slider.

## Topics

### First steps

- <doc:GettingStarted>

### Views

- ``SBBAccordion``
- ``SBBBubbleView``
- ``SBBCheckBox``
- ``SBBChip``
- ``SBBDialogue``
- ``SBBDivider``
- ``SBBFormGroup``
- ``SBBInfoView``
- ``SBBListItem``
- ``SBBLoadingIndicator``
- ``SBBMapMarker``
- ``SBBModalView``
- ``SBBNavigationBarSBBIcon``
- ``SBBOnboardingView``
- ``SBBPaginationView``
- ``SBBProcessFlow``
- ``SBBRadioButton``
- ``SBBRadioButtonGroup``
- ``SBBSegmentedPicker``
- ``SBBTextArea``
- ``SBBTextField``
- ``SBBToast``

### ViewModifiers

- ``SBBPrimaryButtonStyle``
- ``SBBSecondaryButtonStyle``
- ``SBBTertiaryButtonStyle``
- ``SBBIconButtonStyle``
- ``SBBIconTextButtonStyle``
- ``SBBSwitchStyle``
- ``SBBListItem/rightSwipeButton(label:action:)``
- ``SBBListItem/leftSwipeButton(label:action:)``

### Additional Documentation

* [AppBakery libraries](https://www.sbb.sharepoint.com/sites/app-bakery/SitePages/Mobile-Libraries.aspx)
* [Figma](https://www.figma.com/file/56woOj0p1qEOrZiTzi4mJ7/SBB-Mobile-Library-%28draft%29)

