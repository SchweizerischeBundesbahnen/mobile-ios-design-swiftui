//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct TypographyViewNew: View {
    
    @Binding var colorScheme: ColorScheme
    
    let padding: CGFloat = 4
    let longText = "\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat."
    
    var body: some View {
        VStack {
            ScrollView {
                Group {
                    Text("SBB Header")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.sbbHeader)
                        .foregroundColor(SBBColor.textWhite)
                        .background(SBBColor.red)
                        .padding(self.padding)
                }
                Group {
                    Text("SBB Headline black")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.sbbHeadline)
                        .foregroundColor(SBBColor.textBlack)
                        .padding(self.padding)
                    Text("SBB Headline white")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .sbbFont(.headline)
                        .foregroundColor(SBBColor.textWhite)
                        .background(SBBColor.black)
                        .padding(self.padding)
                }
                Group {
                    Text("SBB Title black")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.sbbTitleDefault)
                        .foregroundColor(SBBColor.textBlack)
                        .padding(self.padding)
                    Text("SBB Title metal")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.sbbTitleDefault)
                        .foregroundColor(SBBColor.textMetal)
                        .padding(self.padding)
                    Text("SBB Title Modul")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.sbbTitleModul)
                        .foregroundColor(SBBColor.textRed)
                        .padding(self.padding)
                }
                Group {
                    Text("SBB Subtitle black")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.sbbSubtitle)
                        .foregroundColor(SBBColor.textBlack)
                        .padding(self.padding)
                    Text("SBB Subtitle metal")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.sbbSubtitle)
                        .foregroundColor(SBBColor.textMetal)
                        .padding(self.padding)
                }
                Group {
                    Text("SBB Copy black")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.sbbCopy)
                        .foregroundColor(SBBColor.textBlack)
                        .padding(self.padding)
                    Text("SBB Copy white")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.sbbCopy)
                        .foregroundColor(SBBColor.textWhite)
                        .background(SBBColor.black)
                        .padding(self.padding)
                }
                Group {
                    Text("SBB TableHeader black")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.sbbTableHeader)
                        .foregroundColor(SBBColor.textBlack)
                        .padding(self.padding)
                }
                Group {
                    Text("SBB Body black\(longText)")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.sbbBody)
                        .foregroundColor(SBBColor.textBlack)
                        .padding(self.padding)
                    Text("SBB Body metal\(longText)")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.sbbBody)
                        .foregroundColor(SBBColor.textMetal)
                        .padding(self.padding)
                    Text("SBB Body red\(longText)")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.sbbBody)
                        .foregroundColor(SBBColor.textRed)
                        .padding(self.padding)
                    Text("SBB Body black (custom size: 25)\(longText)")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        //.font(Font.sbbBody(size: 25)) // TODO
                        .sbbFont(.body, size: 25)
                        .foregroundColor(SBBColor.textBlack)
                        .padding(self.padding)
                }
                Group {
                    Text("SBB Legend black\(longText)")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.sbbLegend)
                        .foregroundColor(SBBColor.textBlack)
                        .padding(self.padding)
                    Text("SBB Legend metal\(longText)")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.sbbLegend)
                        .foregroundColor(SBBColor.textMetal)
                        .padding(self.padding)
                    Text("SBB Legend red\(longText)")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.sbbLegend)
                        .foregroundColor(SBBColor.textRed)
                        .padding(self.padding)
                    Text("SBB Legend white\(longText)")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.sbbLegend)
                        .foregroundColor(SBBColor.textWhite)
                        .background(SBBColor.black)
                        .padding(self.padding)
                    Text("SBB Legend small\(longText)")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.sbbLegendSmall)
                        .foregroundColor(SBBColor.textMetal)
                        .padding(self.padding)
                }
            }
                .padding()
        }
            .navigationBarTitle("Typography")
            .background(SBBColor.background)
            .colorScheme(colorScheme)
            
    }
}

struct TypographyViewNew_Previews: PreviewProvider {
    @State static var lightScheme: ColorScheme = .light
    @State static var darkScheme: ColorScheme = .dark
    
    static var previews: some View {
        Group {
            TypographyViewNew(colorScheme: $lightScheme)
                .previewDisplayName("Light")
            TypographyViewNew(colorScheme: $darkScheme)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
