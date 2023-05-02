//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2020.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct ListItemDemo: View {
    
    @Binding var colorScheme: ColorScheme
    
    let image = Image(sbbIcon: .station_small)
    let footnote = Text("This is a footnote.")
    
    @State var swipeButtonCounter = 0
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                SBBFormGroup(title: "ListItem variations") {
                    SBBListItem(label: Text("Label"))
                    NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: { SBBListItem(label: Text("Label (info type)"), rightImage: Image(sbbIcon: .circle_information_small_small)) })
                    NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: { SBBListItem(label: Text("Label and image"), leftImage: self.image, rightImage: Image(sbbIcon: .circle_information_small_small)) })
                    NavigationLink(destination: ListItemDetailDemo(colorScheme: self.$colorScheme), label: { SBBListItem(label: Text("Label and Footnote"), rightImage: Image(sbbIcon: .chevron_small_right_small), footnote: self.footnote) })
                    SBBListItem(label: Text("Label, Image, Footnote and Swipe actions"), leftImage: self.image, footnote: self.footnote)
                        .rightSwipeButton(label: Image(sbbIcon: .plus_small)) {
                            self.swipeButtonCounter += 1
                        }
                        .leftSwipeButton(label: Image(sbbIcon: .minus_small)) {
                            self.swipeButtonCounter -= 1
                        }
                    SBBListItem(label: Text("Label with swipe actions (count: \(self.swipeButtonCounter))"), showBottomLine: false)
                        .rightSwipeButton(label: Text("+")) {
                            self.swipeButtonCounter += 1
                        }
                        .leftSwipeButton(label: Text("-")) {
                            self.swipeButtonCounter -= 1
                        }
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
