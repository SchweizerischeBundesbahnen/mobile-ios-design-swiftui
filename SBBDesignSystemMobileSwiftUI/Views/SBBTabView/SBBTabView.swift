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
 ![SBBTabViewLandscape](SBBTabViewLandscape)
 */
public struct SBBTabView<Selection>: View where Selection: Hashable {
    
    @Binding private var selection: Selection
    
    @State private var tabBarHidden: Bool = false
    
    private let contents: [TabBarEntryView]
    private var selectionIndex: Int {
        contents.firstIndex { $0.tag as? Selection == selection } ?? 0
    }
    private var contentAboveBar: Bool
    
    /**
     Returns a SBBTabView displaying a tab bar at the bottom of the page, along with the content of the selected tab.
     
     - Parameters:
        - selection: The currently selected tab.
        - contentBehindBar: The content view is displayed behind the tab bar (some elements may therefore be hidden).
        - content: The View content of each tab. An image and label can be added to a View (using `.sbbTabItem(image: Image, label: Text)`) and a tag should be specified for the tab to be reachable (using `.sbbTag(tag: Hashable)`).
     */
    public init?(selection: Binding<Selection>, contentAboveBar: Bool = false, @ArrayBuilder<TabBarEntryView> content: () -> [TabBarEntryView]) {
        self._selection = selection
        self.contentAboveBar = contentAboveBar
        self.contents = content()
        guard 1...10 ~= self.contents.count else {
            return nil
        }
    }
    
    
    public var body: some View {
        GeometryReader { geometry in
            
            if self.contentAboveBar {
                VStack(spacing: 0) {
                    self.contents[self.selectionIndex].contentView
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    
                    if !self.tabBarHidden {
                        TabBarView(selection: self.$selection, content: self.contents)
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                    self.tabBarHidden = true
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    self.tabBarHidden = false
                }
            } else {
                ZStack(alignment: .bottom) {
                    self.contents[self.selectionIndex].contentView
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    
                    if !self.tabBarHidden {
                        TabBarView(selection: self.$selection, content: self.contents)
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                    self.tabBarHidden = true
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    self.tabBarHidden = false
                }
            }
        }
        .background(Color.sbbColor(.background)).edgesIgnoringSafeArea(.horizontal)
    }
}

struct SBBTabView_Previews: PreviewProvider {
    private static var tabBar = SBBTabView(selection: .constant(0)){
        FakeTabBarEntry.fakeTab1
        FakeTabBarEntry.fakeTab2
        FakeTabBarEntry.fakeTab3
        FakeTabBarEntry.fakeTab4
        FakeTabBarEntry.fakeTab5
        FakeTabBarEntry.fakeTab6
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
