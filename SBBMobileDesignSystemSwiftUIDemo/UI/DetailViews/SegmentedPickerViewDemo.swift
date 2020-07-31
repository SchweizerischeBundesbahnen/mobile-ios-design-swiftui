//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct SegmentedPickerViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    @State private var selectedSegment1 = 0
    @State private var selectedSegment2: PickerOptions = .departures
    
    var body: some View {
        Group {
            VStack(spacing: 16) {
                Text("Simple Integer Picker")
                    .sbbFont(.header)
                SBBSegmentedPicker(selection: self.$selectedSegment1, tags: [0, 1, 2]) {
                    Text("Opt 1")
                    Text("Opt 2")
                    Text("Opt 3")
                }
                Text("Selected Segment: \(selectedSegment1)")
                    .sbbFont(.body)
                SBBDivider()
                Text("Enum Picker")
                    .sbbFont(.header)
                SBBSegmentedPicker(selection: self.$selectedSegment2, tags: [.departures, .platform]) {
                    Text("Departures")
                    Text("Platform")
                }
                Text("Selected Segment: .\(selectedSegment2.rawValue)")
                    .sbbFont(.body)
                Spacer()
            }
                .padding(16)
        }
            .navigationBarTitle("SegmentedPicker")
            .background(SBBColor.background.edgesIgnoringSafeArea(.bottom))
            .colorScheme(colorScheme)
    }
}

enum PickerOptions: String {
    case departures
    case platform
}

struct SegmentedPickerViewDemo_Previews: PreviewProvider {
    @State static var lightScheme: ColorScheme = .light
    @State static var darkScheme: ColorScheme = .dark
    
    static var previews: some View {
        Group {
            SegmentedPickerViewDemo(colorScheme: $lightScheme)
                .previewDisplayName("Light")
            SegmentedPickerViewDemo(colorScheme: $darkScheme)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
