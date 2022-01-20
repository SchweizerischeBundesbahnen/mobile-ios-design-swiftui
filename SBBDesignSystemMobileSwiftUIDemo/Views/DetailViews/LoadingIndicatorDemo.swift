//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct LoadingIndicatorDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                SBBFormGroup(title: "size: .normal, style: .primary") {
                    HStack {
                        Spacer()
                        SBBLoadingIndicator()
                        Spacer()
                    }
                }
                SBBFormGroup(title: "size: .normal, style: .grey") {
                    HStack {
                        Spacer()
                        SBBLoadingIndicator(style: .grey)
                        Spacer()
                    }
                }
                SBBFormGroup(title: "size: .normal, style: .white") {
                    HStack {
                        Spacer()
                        SBBLoadingIndicator(style: .primaryBackground)
                        Spacer()
                    }
                        .background(Color.sbbColor(.primary))
                }
                SBBFormGroup(title: "size: .small, style: .primary") {
                    HStack {
                        Spacer()
                        SBBLoadingIndicator(size: .small)
                        Spacer()
                    }
                }
                SBBFormGroup(title: "size: .small, style: .grey") {
                    HStack {
                        Spacer()
                        SBBLoadingIndicator(size: .small, style: .grey)
                        Spacer()
                    }
                }
                SBBFormGroup(title: "size: .small, style: .white") {
                    HStack {
                        Spacer()
                        SBBLoadingIndicator(size: .small, style: .primaryBackground)
                        Spacer()
                    }
                        .background(Color.sbbColor(.primary))
                }
            }
                .sbbScreenPadding()
        }
        .navigationBarTitle("LoadingIndicator")
        .sbbStyle()
        .colorScheme(colorScheme)
    }
}

// Note: You need to run the Preview (by pressing play) to be able to see the LoadingIndicator
struct LoadingIndicatorDemo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoadingIndicatorDemo(colorScheme: .constant(.light))
            LoadingIndicatorDemo(colorScheme: .constant(.dark))
        }
    }
}
