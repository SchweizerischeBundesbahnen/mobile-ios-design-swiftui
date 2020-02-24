//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct TypographyView: View {
    
    @Binding var colorScheme: ColorScheme
    
    let padding: CGFloat = 4
    let longText = "\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat."
    
    var body: some View {
        VStack {
            ScrollView {
                Group {
                    Text("SBB Header")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .sbbFont(.header)
                        .foregroundColor(SBBColor.textWhite)
                        .background(SBBColor.red)
                        .padding(self.padding)
                }
                Group {
                    Text("SBB Headline black")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .sbbFont(.headline)
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
                        .sbbFont(.titleDefault)
                        .foregroundColor(SBBColor.textBlack)
                        .padding(self.padding)
                    Text("SBB Title metal")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .sbbFont(.titleDefault)
                        .foregroundColor(SBBColor.textMetal)
                        .padding(self.padding)
                    Text("SBB Title Modul")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .sbbFont(.titleModul)
                        .foregroundColor(SBBColor.textRed)
                        .padding(self.padding)
                }
                Group {
                    Text("SBB Subtitle black")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .sbbFont(.subtitle)
                        .foregroundColor(SBBColor.textBlack)
                        .padding(self.padding)
                    Text("SBB Subtitle metal")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .sbbFont(.subtitle)
                        .foregroundColor(SBBColor.textMetal)
                        .padding(self.padding)
                }
                Group {
                    Text("SBB Copy black")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .sbbFont(.copy)
                        .foregroundColor(SBBColor.textBlack)
                        .padding(self.padding)
                    Text("SBB Copy white")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .sbbFont(.copy)
                        .foregroundColor(SBBColor.textWhite)
                        .background(SBBColor.black)
                        .padding(self.padding)
                }
                Group {
                    Text("SBB TableHeader black")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .sbbFont(.tableHeader)
                        .foregroundColor(SBBColor.textBlack)
                        .padding(self.padding)
                }
                Group {
                    Text("SBB Body black\(longText)")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .sbbFont(.body)
                        .foregroundColor(SBBColor.textBlack)
                        .padding(self.padding)
                    Text("SBB Body metal\(longText)")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .sbbFont(.body)
                        .foregroundColor(SBBColor.textMetal)
                        .padding(self.padding)
                    Text("SBB Body red\(longText)")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .sbbFont(.body)
                        .foregroundColor(SBBColor.textRed)
                        .padding(self.padding)
                    Text("SBB Body black (custom size: 25)\(longText)")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .sbbFont(.body, size: 25)
                        .foregroundColor(SBBColor.textBlack)
                        .padding(self.padding)
                }
                Group {
                    Text("SBB Legend black\(longText)")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .sbbFont(.legend)
                        .foregroundColor(SBBColor.textBlack)
                        .padding(self.padding)
                    Text("SBB Legend metal\(longText)")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .sbbFont(.legend)
                        .foregroundColor(SBBColor.textMetal)
                        .padding(self.padding)
                    Text("SBB Legend red\(longText)")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .sbbFont(.legend)
                        .foregroundColor(SBBColor.textRed)
                        .padding(self.padding)
                    Text("SBB Legend white\(longText)")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .sbbFont(.legend)
                        .foregroundColor(SBBColor.textWhite)
                        .background(SBBColor.black)
                        .padding(self.padding)
                    Text("SBB Legend small\(longText)")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .sbbFont(.legendSmall)
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

struct TypographyView_Previews: PreviewProvider {
    @State static var lightScheme: ColorScheme = .light
    @State static var darkScheme: ColorScheme = .dark
    
    static var previews: some View {
        Group {
            TypographyView(colorScheme: $lightScheme)
                .previewDisplayName("Light")
            TypographyView(colorScheme: $darkScheme)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
