//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBMobileDesignSystemSwiftUI

struct ListItemDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    let label = Text("Label")
    let image = Image("station_117_small")
    let footnote = Text("This is a footnote.")
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                SBBFormGroup(title: "Label") {
                    NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: { SBBListItem(label: self.label) })
                    NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: { SBBListItem(label: self.label) })
                }
                SBBFormGroup(title: "Label (info type)") {
                    NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: { SBBListItem(label: self.label, type: .info) })
                    NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: { SBBListItem(label: self.label, type: .info) })
                }
                SBBFormGroup(title: "Label and Image") {
                    NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: { SBBListItem(label: self.label, image: self.image) })
                    NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: { SBBListItem(label: self.label, image: self.image) })
                }
                SBBFormGroup(title: "Label and Footnote") {
                    NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: { SBBListItem(label: self.label, footnote: self.footnote) })
                    NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: { SBBListItem(label: self.label, footnote: self.footnote) })
                }
                SBBFormGroup(title: "Label, Image and Footnote") {
                    NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: {                     SBBListItem(label: self.label, image: self.image, footnote: self.footnote)
 })
                    NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: {                     SBBListItem(label: self.label, image: self.image, footnote: self.footnote)
 })
                }
            }
            .padding(16)
        }
            .navigationBarTitle("ListItem")
            .background(SBBColor.background)
            .colorScheme(colorScheme)
    }
}

struct ListItemDemo_Previews: PreviewProvider {
    
    @State static var lightScheme: ColorScheme = .light
    @State static var darkScheme: ColorScheme = .dark
    
    static var previews: some View {
        Group {
            ListItemDemo(colorScheme: $lightScheme)
                .previewDisplayName("Light")
            ListItemDemo(colorScheme: $darkScheme)
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
    }
}
