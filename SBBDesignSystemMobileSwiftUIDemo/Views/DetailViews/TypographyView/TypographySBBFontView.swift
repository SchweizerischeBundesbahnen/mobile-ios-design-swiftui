//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct TypographySBBFontView: View {
        
    let padding: CGFloat = 4
    let longText = "\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat."
    
    var body: some View {
        VStack {
            Group {
                Text("xlarge light")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sbbFont(.xlarge_light)
                    .foregroundColor(.sbbColor(.textWhite))
                    .background(Color.sbbColor(.primary))
                    .padding(self.padding)
            }
            Group {
                Text("large bold black")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sbbFont(.large_bold)
                    .foregroundColor(.sbbColor(.textBlack))
                    .padding(self.padding)
                Text("large bold white")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sbbFont(.large_bold)
                    .foregroundColor(.sbbColor(.textWhite))
                    .background(Color.sbbColor(.black))
                    .padding(self.padding)
            }
            Group {
                Text("medium bold black")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sbbFont(.medium_bold)
                    .foregroundColor(.sbbColor(.textBlack))
                    .padding(self.padding)
                Text("medium bold metal")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sbbFont(.medium_bold)
                    .foregroundColor(.sbbColor(.textMetal))
                    .padding(self.padding)
                Text("medium bold Modul")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sbbFont(.medium_bold)
                    .foregroundColor(.sbbColor(.textRed))
                    .padding(self.padding)
            }
            Group {
                Text("small bold black")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sbbFont(.small_bold)
                    .foregroundColor(.sbbColor(.textBlack))
                    .padding(self.padding)
                Text("small bold metal")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sbbFont(.small_bold)
                    .foregroundColor(.sbbColor(.textMetal))
                    .padding(self.padding)
            }
            Group {
                Text("large light black")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sbbFont(.large_light)
                    .foregroundColor(.sbbColor(.textBlack))
                    .padding(self.padding)
                Text("large light white")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sbbFont(.large_light)
                    .foregroundColor(.sbbColor(.textWhite))
                    .background(Color.sbbColor(.black))
                    .padding(self.padding)
            }
            Group {
                Text("SBB TableHeader black")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sbbFont(.tableHeader)
                    .foregroundColor(.sbbColor(.textBlack))
                    .padding(self.padding)
            }
            Group {
                Text("medium light black\(longText)")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sbbFont(.medium_light)
                    .foregroundColor(.sbbColor(.textBlack))
                    .padding(self.padding)
                Text("medium light metal\(longText)")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sbbFont(.medium_light)
                    .foregroundColor(.sbbColor(.textMetal))
                    .padding(self.padding)
                Text("medium light red\(longText)")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sbbFont(.medium_light)
                    .foregroundColor(.sbbColor(.textRed))
                    .padding(self.padding)
            }
            Group {
                Text("small light black\(longText)")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sbbFont(.small_light)
                    .foregroundColor(.sbbColor(.textBlack))
                    .padding(self.padding)
                Text("small light metal\(longText)")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sbbFont(.small_light)
                    .foregroundColor(.sbbColor(.textMetal))
                    .padding(self.padding)
                Text("small light red\(longText)")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sbbFont(.small_light)
                    .foregroundColor(.sbbColor(.textRed))
                    .padding(self.padding)
                Text("small light \(longText)")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sbbFont(.small_light)
                    .foregroundColor(.sbbColor(.textWhite))
                    .background(Color.sbbColor(.black))
                    .padding(self.padding)
                Text("xsmall light \(longText)")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .sbbFont(.xsmall_light)
                    .foregroundColor(.sbbColor(.textMetal))
                    .padding(self.padding)
            }
        }
    }
}

struct TypographySBBFontView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            TypographySBBFontView()
                .previewDisplayName("Light")
            TypographySBBFontView()
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
