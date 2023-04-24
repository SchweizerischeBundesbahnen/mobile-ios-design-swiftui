//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI

/**
 A View that is used to display a tab bar at the bottom of the page, as well as the content of the selected tab.
 
 ## Overview
 You create a SBBTabView by providing a selectedSegment binding and the different Views to be displayed in each tab. The views must be TabBarEntryView, they can  be created from scratch or with the modifier `.sbbTabItem(image: Image?, label: Text?, tag: AnyHashable)` which allows to add an image, a label and a tag. The tag is required as it is used to reference the tab.

 ```swift
 @State private var selectedSegment = 0

 var body: some View {
     SBBTabView(selection: $selectedSegment) {
         HStack {
             Image(sbbIcon: .station_small)
             Text("This is the content of the Station tab.")
         }
         .sbbTabItem(
             image: Image(sbbIcon: .station_small),
             label: Text("Station"),
             tag: 0
         )
 
         HStack {
             Image(sbbIco: .bus_stop_small)
             Text("This is the content of the Stop tab.")
         }
         .sbbTabItem(
             image: Image(sbbIcon: .bus_stop_small),
             label: Text("Stop"),
             tag: 1
         )
     }
 }
 ```
 
 Note that the number of elements in the ViewBuilder must be between 1 and 10.
 
 ![SBBTabView](SBBTabView)
 ![SBBTabViewLandscape](SBBTabViewLandscape)
 */
public struct SBBTabView<Selection>: View where Selection: Hashable {
    
    @Binding private var selection: Selection
    
    @State private var tabBarHidden: Bool = false
    
    private let contents: [TabBarEntryView]
    private var selectionIndex: Int {
        TabBarEntryView.selectionIndex(for: selection, in: contents)
    }
    private var contentAboveBar: Bool
    private var isPortrait: Bool {
        self.horizontalSizeClass == .compact && self.verticalSizeClass == .regular
    }
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    /**
     Returns a SBBTabView displaying a tab bar at the bottom of the page, along with the content of the selected tab.
     
     - Parameters:
        - selection: The currently selected tab.
        - contentAboveBar: The content view is displayed above the tab bar (no elements may therefore be hidden).
        - content: The View content of each tab, must be a TabBarEntryView. A view can be transformed into a TabBarEntryView using `.sbbTabItem(image: Image?, label: Text?, tag: AnyHashable)`.
     */
    public init?(selection: Binding<Selection>, contentAboveBar: Bool = false, @ArrayBuilder<TabBarEntryView> content: () -> [TabBarEntryView]) {
        self._selection = selection
        self.contents = content()
        self.contentAboveBar = contentAboveBar
        guard 1...5 ~= self.contents.count else {
            return nil
        }
    }
    
    
    public var body: some View {
        GeometryReader { geometry in
            if !self.tabBarHidden {
                ZStack {
                    TabView(selection: self.$selection) {
                        ForEach(Array(self.contents.enumerated()), id: \.offset) { index, _ in
                            contents[index]
                                .tag(self.contents[index].tag)
                                .padding(.bottom, contentAboveBar ? isPortrait ? 75 : 38 : 0)
                        }
                    }
                    
                    VStack {
                        Spacer()
                        TabBarView(selection: self.$selection, content: self.contents)
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                    self.tabBarHidden = true
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    self.tabBarHidden = false
                }
                .background(Color.sbbColor(.background).edgesIgnoringSafeArea(.horizontal))
            }
        }
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
