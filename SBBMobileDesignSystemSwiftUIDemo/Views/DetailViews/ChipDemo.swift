//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

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
                SBBCheckBox(isOn: $disabled, label: "Disabled", showTextFieldLine: false)
                SBBFormGroup(title: "Demo Vehicle List") {
                    if !internationalFilter {
                        SBBListItem(label: Text("ICN"), image: Image(sbbName: "train-profile", size: .small), footnote: Text("National train"), type: .info)
                    }
                    SBBListItem(label: Text("Giruno"), image: Image(sbbName: "train-profile", size: .small), footnote: Text("International train"), type: .info)
                    if !trainFilter {
                        SBBListItem(label: Text("Basler Drämmli"), image: Image(sbbName: "locomotive", size: .small), footnote: Text("International Tram"), type: .info)
                    }
                    if !trainFilter && !internationalFilter {
                        SBBListItem(label: Text("Berner Tram"), image: Image(sbbName: "locomotive", size: .small), footnote: Text("National Tram"), type: .info)
                    }
                }
            }
                .padding(16)
        }
        .navigationBarTitle("Chip")
        .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.bottom))
        .colorScheme(colorScheme)
    }
}

struct ChipDemo_Previews: PreviewProvider {
    static var previews: some View {
        ChipDemo(colorScheme: .constant(.light))
        ChipDemo(colorScheme: .constant(.dark))
    }
}
