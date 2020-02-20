//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct SegmentedPickerViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    @State private var selectedSegment = 0
    
    var body: some View {
        Group {
            VStack {
                Picker(selection: self.$selectedSegment, label: EmptyView()) {
                    Text("Segment 1").tag(0)
                    Text("Segment 2").tag(1)
                }
                    .pickerStyle(SegmentedPickerStyle())
                Text("Selected Segment: \(selectedSegment)")
                    .sbbFont(.body)
                Spacer()
                SegmentedPicker(selection: self.$selectedSegment) {
                    Text("Segment 1")
                    Text("Segment 2")
                }
            }
                .padding(16)
        }
            .navigationBarTitle("BubbleView")
            .background(SBBColor.background)
            .colorScheme(colorScheme)
    }
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
