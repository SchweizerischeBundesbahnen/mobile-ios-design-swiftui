//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2019.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct ColorsView: View {
    
    typealias ColorAndName = (color: Color, name: String)
    var colors: [ColorAndName] = [(SBBColor.red, "red"), (SBBColor.red125, "red125"), (SBBColor.red150, "red150"), (SBBColor.white, "white"), (SBBColor.milk, "milk"), (SBBColor.cloud, "cloud"), (SBBColor.silver, "silver"), (SBBColor.aluminium, "aluminium"), (SBBColor.platinum, "platinum"), (SBBColor.cement, "cement"), (SBBColor.graphite, "graphite"), (SBBColor.storm, "storm"), (SBBColor.smoke, "smoke"), (SBBColor.metal, "metal"), (SBBColor.granite, "granite"), (SBBColor.anthracite, "anthracite"), (SBBColor.iron, "iron"), (SBBColor.black, "black"), (SBBColor.blue, "blue"), (SBBColor.sky, "sky"), (SBBColor.night, "night"), (SBBColor.violet, "violet"), (SBBColor.autumn, "autumn"), (SBBColor.orange, "orange"), (SBBColor.peach, "peach"), (SBBColor.lemon, "lemon"), (SBBColor.green, "green")]
    var semanticColors: [ColorAndName] = [(SBBColor.textBlack, "textBlack"), (SBBColor.textMetal, "textMetal"), (SBBColor.textWhite, "textWhite"), (SBBColor.textRed, "textRed"), (SBBColor.background, "background"), (SBBColor.buttonBackground, "buttonBackground"), (SBBColor.viewBackground, "biewBackground")]
    
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
    static var previews: some View {
        Group {
            ColorsView()
                .previewDisplayName("Light")
           ColorsView()
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
