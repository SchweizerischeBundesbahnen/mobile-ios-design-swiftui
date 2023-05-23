//
//  Copyright © 2023 SBB. All rights reserved.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct UpDnCounterDemoView: View {
    
    @Binding var colorScheme: ColorScheme
    
    let image = Image(sbbIcon: .station_small)
    let footnote = Text("This is a footnote.")
    
    @State var counter = 0
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                SBBFormGroup(title: "UpDnCounter variations") {
                    SBBUpDnCounterView(label: Text("Label"), value: $counter)
                    SBBUpDnCounterView(leftIcon: Image(sbbIcon: .train_tracks_small), label: Text("Label and Icon"), value: $counter)
                    SBBUpDnCounterView(label: Text("Label and subtext"), subtext: Text("This is a subtext for you"), value: $counter)
                    SBBUpDnCounterView(leftIcon: Image(sbbIcon: .train_tracks_small), label: Text("Label and Icon and subtext"), subtext: Text("This is a subtext for you"), value: $counter, showBottomLine: true)
                    SBBUpDnCounterView(label: Text("Manual increment/decrement"), displayValue: counter) {
                        counter = counter + 1
                    } decrementAction: {
                        counter = counter - 1
                    }
                    SBBUpDnCounterView(leftIcon: Image(sbbIcon: .train_tracks_small), label: Text("Label and Icon, range 0...10"), value: $counter, range: 0...10, showBottomLine: false)

                }
                Spacer()
            }
                .sbbScreenPadding()
        }
            .navigationBarTitle("UpDnCounter")
            .sbbStyle()
            .colorScheme(colorScheme)
    }
}

struct UpDnCounterDemoView_Previews: PreviewProvider {
    
    @State static var lightScheme: ColorScheme = .light
    @State static var darkScheme: ColorScheme = .dark
    
    static var previews: some View {
        VStack {
            UpDnCounterDemoView(colorScheme: $lightScheme)
                .previewDisplayName("Light")
            UpDnCounterDemoView(colorScheme: $darkScheme)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
