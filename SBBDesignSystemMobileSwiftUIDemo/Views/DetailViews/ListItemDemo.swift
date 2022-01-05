//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct ListItemDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    let image = Image(sbbName: "station", size: .small)
    let footnote = Text("This is a footnote.")
    
    @State var swipeButtonCounter = 0
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                SBBFormGroup(title: "ListItem variations") {
                    NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: { SBBListItem(label: Text("Label")) })
                    NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: { SBBListItem(label: Text("Label (info type)"), type: .info) })
                    NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: { SBBListItem(label: Text("Label and image"), image: self.image) })
                    NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: { SBBListItem(label: Text("Label and Footnote"), footnote: self.footnote) })
                    NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: { SBBListItem(label: Text("Label, Image and Footnote"), image: self.image, footnote: self.footnote)})
                    NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: { SBBListItem(label: Text("Label with swipe actions (count: \(self.swipeButtonCounter))"), showBottomLine: false)
                        .rightSwipeButton(label: Text("+"), action: {
                            self.swipeButtonCounter += 1
                            
                        })
                        .leftSwipeButton(label: Text("-"), action: {
                            self.swipeButtonCounter -= 1
                            
                        })
                    })
                }
            }
                .sbbScreenPadding()
        }
            .navigationBarTitle("ListItem")
            .sbbStyle()
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
