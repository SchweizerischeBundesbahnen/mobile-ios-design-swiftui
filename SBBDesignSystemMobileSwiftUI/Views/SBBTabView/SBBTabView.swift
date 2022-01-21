//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

/**
 A View that is used to display a tab bar at the bottom of the page.
 */
public struct SBBTabView<Selection>: View where Selection: Hashable {
    
    @Binding private var selection: Selection
    
    @State private var tabBarHidden: Bool = false
    
    private let contents: [TabBarEntryView]
    private var selectionIndex: Int {
        for index in (0...self.contents.count) {
            if let tag = self.contents[index].tag, let tagValue = tag as? Selection {
                if tagValue == selection {
                    return index
                }
            }
        }
        return 0
    }
    
    public init<Views>(selection: Binding<Selection>, @ViewBuilder content: () -> TupleView<Views>) {
        self._selection = selection
        // Content must have at least 2 views to work (Tuple)
        self.contents = content().getTabViews
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.contents[self.selectionIndex].contentView
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                
                if !self.tabBarHidden {
                    TabBarView(selection: self.$selection, contents: self.contents)
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.sbbColor(.background))
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                self.tabBarHidden = true
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                self.tabBarHidden = false
            }
        }
    }
}

struct SBBTabView_Previews: PreviewProvider {
    private static var tabBar = SBBTabView(selection: .constant(0)){
        VStack {
            Text("Bahnhof")
            Image(sbbName: "station", size:.small)
        }
        .sbbTag(0)
        .sbbTabItem(
            image: Image(sbbName: "station", size:.small),
            label: Text("Bahnhof")
        )
        
        VStack {
            Text("Haltestelle")
            Image(sbbName: "bus-stop", size:.small)
        }
        .sbbTag(1)
        .sbbTabItem(
            image: Image(sbbName: "bus-stop", size:.small),
            label: Text("Haltestelle")
        )
        
        VStack {
            Text("Unterwegs")
            Image(sbbName: "train", size:.small)
        }
        .sbbTag(2)
        .sbbTabItem(
            image: Image(sbbName: "train", size:.small),
            label: Text("UnterwegsUnterwegsUnterwegs")
        )
        
        VStack {
            Text("Türknopf")
            Image(sbbName: "fullscreen", size:.small)
        }
        .sbbTag(3)
        .sbbTabItem(
            image: Image(sbbName: "fullscreen", size:.small),
            label: Text("Finder")
        )
        
        VStack {
            Text("Lifte")
            Image(sbbName: "Lift", size:.small)
        }
        .sbbTag(4)
        .sbbTabItem(
            image: Image(sbbName: "lift", size:.small),
            label: Text("Lifte")
        )
        
        VStack {
            Text("Einstellungen")
            Image(sbbName: "gears", size:.small)
        }
        .sbbTag(5)
        .sbbTabItem(
            image: Image(sbbName: "gears", size:.small),
            label: Text("Einstellungen")
        )
    }
    
    static var previews: some View {
        Group {
            tabBar
                .previewDisplayName("Light")
            
            tabBar
                .previewDisplayName("Dark")
                .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
