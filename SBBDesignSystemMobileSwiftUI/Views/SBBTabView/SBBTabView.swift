//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

/**
 A View that is used to display a tab bar at the bottom of the page, as well as the content of the selected tab.
 
 ## Overview
 You create a SBBTabView by providing a selectedSegment binding and the different Views to be displayed in each tab. The views can be modified so that the tab contains an image and a label. Each tab should also be tagger, otherwise they won't be reachable.

 ```swift
 @State private var selectedSegment = 0

 var body: some View {
     SBBTabView(selection: $selectedSegment) {
         HStack {
             Image(sbbName: "station", size: .small)
             Text("This is the content of the Station tab.")
         }
         .sbbTag(0)
         .sbbTabItem(
             image: Image(sbbName: "station", size: .small),
             label: Text("Station")
         )
 
         HStack {
             Image(sbbName: "bus-stop", size: .small)
             Text("This is the content of the Stop tab.")
         }
         .sbbTag(1)
         .sbbTabItem(
             image: Image(sbbName: "bus-stop", size: .small),
             label: Text("Stop")
         )
     }
 }
 ```
 
 Note that the number of elements in the ViewBuilder must be at least two.
 
 ![SBBTabView](SBBTabView)
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
    
    /**
     Returns a SBBTabView displaying a tab bar at the bottom of the page, along with the content of the selected tab.
     
     - Parameters:
        - selection: The currently selected tab.
        - content: The View content of each tab. An image and label can be added to a View (using `.sbbTabItem(image: Image, label: Text)`) and a tag should be specified for the tab to be reachable (using `.sbbTag(tag: Hashable)`).
     */
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
                    TabBarView(selection: self.$selection, content: self.contents)
                    
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
        .sbbStyle()
    }
}

struct SBBTabView_Previews: PreviewProvider {
    private static var tabBar = SBBTabView(selection: .constant(0)){
        VStack {
            Text("Station")
            Image(sbbName: "station", size: .small)
        }
        .sbbTag(0)
        .sbbTabItem(
            image: Image(sbbName: "station", size: .small),
            label: Text("Station")
        )
        
        VStack {
            Text("Stop")
            Image(sbbName: "bus-stop", size: .small)
        }
        .sbbTag(1)
        .sbbTabItem(
            image: Image(sbbName: "bus-stop", size: .small),
            label: Text("Stop")
        )
        
        VStack {
            Text("En route")
            Image(sbbName: "train", size: .small)
        }
        .sbbTag(2)
        .sbbTabItem(
            image: Image(sbbName: "train", size: .small),
            label: Text("En route")
        )
        
        VStack {
            Text("Finder")
            Image(sbbName: "fullscreen", size: .small)
        }
        .sbbTag(3)
        .sbbTabItem(
            image: Image(sbbName: "fullscreen", size: .small),
            label: Text("Finder")
        )
        
        VStack {
            Text("Elevator")
            Image(sbbName: "Lift", size: .small)
        }
        .sbbTag(4)
        .sbbTabItem(
            image: Image(sbbName: "lift", size: .small),
            label: Text("Elevator")
        )
        
        VStack {
            Text("Settings")
            Image(sbbName: "gears", size:.small)
        }
        .sbbTag(5)
        .sbbTabItem(
            image: Image(sbbName: "gears", size: .small),
            label: Text("Settings")
        )
    }
    
    static var previews: some View {
        Group {
            tabBar
                .previewDisplayName("Light portrait")
            
            tabBar
                .previewDisplayName("Dark portrait")
                .environment(\.colorScheme, .dark)
            
            if #available(iOS 15.0, *) {
                tabBar
                    .previewDisplayName("Light landscape")
                    .previewInterfaceOrientation(.landscapeLeft)
                
                tabBar
                    .previewDisplayName("Dark landscape")
                    .environment(\.colorScheme, .dark)
                    .previewInterfaceOrientation(.landscapeLeft)
            }
        }
    }
}
