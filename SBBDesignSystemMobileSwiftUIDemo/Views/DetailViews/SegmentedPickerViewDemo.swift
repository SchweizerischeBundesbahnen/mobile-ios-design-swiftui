//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct SegmentedPickerViewDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    @State private var selectedSegment1 = 0
    @State private var selectedSegment2: PickerOptions = .departures
    
    var body: some View {
        VStack(spacing: 0) {
            SBBSegmentedPicker(selection: self.$selectedSegment1, tags: [0, 1, 2], style: .primaryColor) {
                Text("Opt 1")
                Text("Opt 2")
                Text("Opt 3")
            }
                .padding(8)
                .background(Color.sbbColor(.primary).edgesIgnoringSafeArea(.horizontal))
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    
                    Text("Simple Integer Picker")
                        .sbbFont(.xlarge_light)
                    SBBSegmentedPicker(selection: self.$selectedSegment1, tags: [0, 1, 2]) {
                        Text("Opt 1")
                        Text("Opt 2")
                        Text("Opt 3")
                    }
                    Text("Selected Segment: \(selectedSegment1)")
                        .sbbFont(.medium_light)
                    SBBDivider()
                    Text("Enum Picker")
                        .sbbFont(.xlarge_light)
                    SBBSegmentedPicker(selection: self.$selectedSegment2, tags: [.departures, .platform]) {
                        Text("Departures")
                        Text("Platform")
                    }
                    SBBSegmentedPicker(selection: self.$selectedSegment2, tags: [.departures, .platform]) {
                        Image(sbbIcon: .timetable_small)
                        Image(sbbIcon: .platform_display_small)
                    }
                    SBBSegmentedPicker(selection: self.$selectedSegment2, tags: [.departures, .platform]) {
                        HStack {
                            Image(sbbIcon: .timetable_small)
                            Text("Departures")
                        }
                        HStack {
                            Image(sbbIcon: .platform_display_small)
                            Text("Platform")
                        }
                    }
                    Text("Selected Segment: .\(selectedSegment2.rawValue)")
                        .sbbFont(.medium_light)
                    Spacer()
                }
                    .sbbScreenPadding()
            }
        }
            .navigationBarTitle("SegmentedPicker")
            .sbbStyle()
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
