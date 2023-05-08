//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct ChipDemo: View {
    
    @Binding var colorScheme: ColorScheme
    @State private var disabled = false
    @State private var internationalFilter = false
    @State private var trainFilter = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                HStack (spacing: 8) {
                    SBBChip(label: Text("International"), isSelected: $internationalFilter, numberOfItems: 2)

                    SBBChip(label: Text("Train"), isSelected: $trainFilter, numberOfItems: 2)
                    Spacer()
                }
                    .disabled(disabled)
                SBBCheckBox(isOn: $disabled, text: Text("Disabled"), showBottomLine: false)
                SBBFormGroup(title: "Demo Vehicle List") {
                    if !internationalFilter {
                        SBBListItem(label: Text("ICN"), leftImage: Image(sbbIcon: .train_profile_small), footnote: Text("National train"))
                    }
                    SBBListItem(label: Text("Giruno"), leftImage: Image(sbbIcon: .train_profile_small), footnote: Text("International train"))
                    if !trainFilter {
                        SBBListItem(label: Text("Basler Drämmli"), leftImage: Image(sbbIcon: .locomotive_small), footnote: Text("International Tram"))
                    }
                    if !trainFilter && !internationalFilter {
                        SBBListItem(label: Text("Berner Tram"), leftImage: Image(sbbIcon: .locomotive_small), footnote: Text("National Tram"))
                    }
                }
            }
                .sbbScreenPadding()
        }
        .navigationBarTitle("Chip")
        .sbbStyle()
        .colorScheme(colorScheme)
    }
}

struct ChipDemo_Previews: PreviewProvider {
    static var previews: some View {
        ChipDemo(colorScheme: .constant(.light))
        ChipDemo(colorScheme: .constant(.dark))
    }
}
