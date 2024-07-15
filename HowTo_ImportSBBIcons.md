# Importing SBB Icons into the Design Library

## Introduction

This library offers all icons you can find in the official https://digital.sbb.ch/de/brand_elemente site.

There are three different types of icons:
* SBB-Icons: https://digital.sbb.ch/de/foundation/assets/icons/
* SBB-Timetable-Icons: https://digital.sbb.ch/de/foundation/assets/fpl/
* SBB-Pictograms: https://digital.sbb.ch/de/foundation/assets/pictos/

In general, SBB-Icons are present in three different sizes (small, medium, large), meanwhile SBB-Timetable-Icons and SBB-Pictograms have each only one size. Also, you are allowed to change the colour of some of the above icons, and some of them not. In general you can say, that only the SBB-Icons can change their color. There is a list indicating what icons can change it.

## Importing SBB Icons

### SBB-Icons and SBB-Timetable-Icons:
* Download the repo at: https://github.com/sbb-design-systems/sbb-icons/
* change folder name `icons` to `SBB Icons`
* Replace the content of the file `Resources/SBBIconsIndex.json` with the content of the source file `index.json`. Then remove the `index.json`
* Remove old `SBB Icons` of the Assets.xcassets
* Move the newly downloaded and renamed `SBB Icons` folder into the Assets.xcassets
* Select every icon in the Assets and change from "Individual Scales" to "Single Scale"
* Select every icon in the Assets and enable "Preserve Vector Data"
* Select every icon in the Assets and change "Render As" to "Template Image"


Note that the `Resources/SBBIconsIndex.json` indicate, whether the icon is able to change color or not.

### SBB-Pictograms:
* Download the repo at: https://github.com/sbb-design-systems/picto-library/
* change folder name `pictos` to `SBB Pictos`
* Remove old `SBB Pictos` of the Assets.xcassets
* Move the newly downloaded and renamed `SBB Pictos` folder into the Assets.xcassets
* Select every icon in the Assets and change from "Individual Scales" to "Single Scale"
* Select every icon in the Assets and enable "Preserve Vector Data"

Building the Lib should now invoke the `generate_enum_file.swift` script, which generates the `Resources/SBBIconName.swift` file containing an enum with all the icons of the Assets.xcassets.

