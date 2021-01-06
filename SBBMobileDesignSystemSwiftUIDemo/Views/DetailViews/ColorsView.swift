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
        Group {
            List {
                Section(header: Text("Colors")) {
                    ForEach(colors, id: \.name) { element in
                        ColorRow(element: element)
                    }
                }
                Section(header: Text("Semantic Colors")) {
                    ForEach(semanticColors, id: \.name) { element in
                        ColorRow(element: element)
                    }
                }
            }
        }
            .navigationBarTitle("Colors")
            .colorScheme(colorScheme)
    }
}

struct ColorRow: View {
    
    typealias ColorAndName = (color: Color, name: String)
    let element: ColorAndName
    
    var body: some View {
        GeometryReader { metrics in
            HStack {
                ZStack(alignment: .bottomTrailing) {
                    Rectangle()
                        .frame(width: 100, height: metrics.size.height, alignment: .leading)
                        .foregroundColor(self.element.color)
                        .colorScheme(.light)
                    Text(".light")
                        .font(.footnote)
                }
                ZStack(alignment: .bottomTrailing) {
                    Rectangle()
                        .frame(width: 100, height: metrics.size.height, alignment: .leading)
                        .foregroundColor(self.element.color)
                        .colorScheme(.dark)
                    Text(".dark")
                        .font(.footnote)
                }
                Spacer()
                Text(self.element.name)
            }
        }
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
