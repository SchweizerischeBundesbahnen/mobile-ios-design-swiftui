//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct ColorsView: View {
    
    @Binding var colorScheme: ColorScheme
    
    typealias ColorAndName = (color: Color, name: String)
    var colors: [ColorAndName] =
        [
            (.sbbColor(.red), "red"),
            (.sbbColor(.red125), "red125"),
            (.sbbColor(.red150), "red150"),
            (.sbbColor(.white), "white"),
            (.sbbColor(.milk), "milk"),
            (.sbbColor(.cloud), "cloud"),
            (.sbbColor(.silver), "silver"),
            (.sbbColor(.aluminium), "aluminium"),
            (.sbbColor(.platinum), "platinum"),
            (.sbbColor(.cement), "cement"),
            (.sbbColor(.graphite), "graphite"),
            (.sbbColor(.storm), "storm"),
            (.sbbColor(.smoke), "smoke"),
            (.sbbColor(.metal), "metal"),
            (.sbbColor(.granite), "granite"),
            (.sbbColor(.anthracite), "anthracite"),
            (.sbbColor(.iron), "iron"),
            (.sbbColor(.black), "black"),
            (.sbbColor(.blue), "blue"),
            (.sbbColor(.sky), "sky"),
            (.sbbColor(.night), "night"),
            (.sbbColor(.violet), "violet"),
            (.sbbColor(.autumn), "autumn"),
            (.sbbColor(.orange), "orange"),
            (.sbbColor(.peach), "peach"),
            (.sbbColor(.lemon), "lemon"),
            (.sbbColor(.green), "green")
        ]
    var semanticColors: [ColorAndName] =
        [
            (.sbbColor(.textBlack), "textBlack"),
            (.sbbColor(.textMetal), "textMetal"),
            (.sbbColor(.textWhite), "textWhite"),
            (.sbbColor(.textRed), "textRed"),
            (.sbbColor(.background), "background"),
            (.sbbColor(.buttonBackground), "buttonBackground"),
            (.sbbColor(.viewBackground), "viewBackground"),
            (.sbbColor(.divider), "dividers")
        ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                SBBFormGroup(title: "Colors") {
                    ForEach(colors, id: \.name) { element in
                        ColorRow(element: element, showBottomLine: element != colors.last!)
                    }
                }
                SBBFormGroup(title: "Semantic Colors") {
                    ForEach(semanticColors, id: \.name) { element in
                        ColorRow(element: element, showBottomLine: element != semanticColors.last!)
                    }
                }
            }
                .sbbScreenPadding()
        }
            .navigationBarTitle("Colors")
            .sbbStyle()
            .colorScheme(colorScheme)
    }
}

struct ColorRow: View {
    
    typealias ColorAndName = (color: Color, name: String)
    let element: ColorAndName
    let showBottomLine: Bool

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            HStack {
                ZStack(alignment: .bottomTrailing) {
                    Rectangle()
                        .foregroundColor(self.element.color)
                        .colorScheme(.light)
                    Text(".light")
                        .sbbFont(.legendSmall)
                }
                    .frame(width: 100, height: 24)
                ZStack(alignment: .bottomTrailing) {
                    Rectangle()
                        .foregroundColor(self.element.color)
                        .colorScheme(.dark)
                    Text(".dark")
                        .sbbFont(.legendSmall)
                }
                    .frame(width: 100, height: 24)
                Spacer()
                Text(self.element.name)
                    .sbbFont(.body)
            }
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
            if showBottomLine {
                SBBDivider()
            }
        }
            .background(Color.sbbColor(.viewBackground))
    }
}

struct ColorsView_Previews: PreviewProvider {
    @State static var lightScheme: ColorScheme = .light
    @State static var darkScheme: ColorScheme = .dark
    
    static var previews: some View {
        Group {
            ColorsView(colorScheme: $lightScheme)
                .previewDisplayName("Light")
            ColorsView(colorScheme: $darkScheme)
                .previewDisplayName("Dark")
        }
    }
}
