//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2022.
//

import SwiftUI
import Foundation

/**
 A View that is used to display a tab bar.
 */
public struct SBBTabView<Selection>: View where Selection: Hashable {
    @Binding private var selection: Selection
    private let contents: [TabBarEntryView]
    // TODO: how to make it dynamic? Here max tab = 6 so we'll define all 6 possibilities
    @State private var textSizes: [CGSize] = [.zero, .zero, .zero, .zero, .zero, .zero]
    @State private var textSize: CGSize = .zero
    @State private var transitionFactor: CGFloat = 1.0
    @State private var transitionFactorPressed: CGFloat = 1.0
    @State private var currentTab: Int = -1
    @State private var isPressed: Bool = false
    @State private var tabBarHidden: Bool = false
    private var selectionIndex: Int {
        for index in (0...self.contents.count) {
            // Some tab may not have a label
            if let tag = self.contents[index].tag, let tagValue = tag as? Selection {
                    if tagValue == selection {
                        return index
                    }
                }
            }
        return 0
    }
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    
    public init<Views>(selection: Binding<Selection>, @ViewBuilder content: () -> TupleView<Views>) {
        self._selection = selection
        // Content must have at least 2 views to work (Tuple)
        self.contents = content().getTabViews
    }
    
    private func isPortrait() -> Bool {
        if self.horizontalSizeClass == .compact && self.verticalSizeClass == .regular {
            return true
        } else {
            return false
        }
    }
    
    private func segmentWidth(parentWidth: CGFloat, nbTabs: Int) -> CGFloat {
        return parentWidth / CGFloat(nbTabs)
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let segmentWidth: CGFloat = self.segmentWidth(parentWidth: geometry.size.width, nbTabs: self.contents.count)
            let circleSize: CGFloat = isPortrait() ? 44 : 36
            let circlePad: CGFloat = isPortrait() ? 6 : 2
            let topPad: CGFloat = isPortrait() ? 8 : 0
            let barHeight: CGFloat = isPortrait() ? 100 : 40
            let buttonHeight: CGFloat = circleSize + topPad
            let buttonWidth: CGFloat = circleSize + 2 * circlePad
        
            let tabBarCoordinatesParameters = TabBarCoordinatesParameters(nbTabs: self.contents.count, circleRadius: circleSize / 2, segmentWidth: segmentWidth, segmentWidths: self.textSizes, circlePad: circlePad, heightDiff: topPad, width: geometry.size.width)
            
            VStack(spacing: 0) {
                // Content of the tab
                self.contents[self.selectionIndex].contentView
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                
                if !self.tabBarHidden {
                    ZStack(alignment: .bottom) {
                        // Circles behind the bar
                        HStack(spacing: 0) {
                            ForEach(0..<self.contents.count) { index in
                                Circle()
                                    .overlay(self.contents[index].imageView.colorInvert())
                                    .frame(width: circleSize, height: circleSize, alignment: .leading)
                                    .padding(.top, topPad)
                                    .padding(.trailing, isPortrait() ? 0 : self.textSizes[index].width)
                                    .accessibilityHidden(true)
                                    .frame(width: segmentWidth, height: barHeight, alignment: .top)
                            }
                            .frame(width: segmentWidth, height: barHeight, alignment: .top)
                            .shadow(color: Color.sbbColor(.graphite), radius: self.colorScheme == .dark ? 0 : 10, x: 0, y: 0)
                        }
                        
                        // Additional (to cover unsafe area at the bottom)
                        Rectangle()
                            .frame(width: geometry.size.width * 2, height: barHeight)
                            .offset(y: barHeight)
                            .foregroundColor(Color.sbbColor(.tabViewBackground))
                            .frame(width: geometry.size.width, height: barHeight)
                        
                        // Tab bar shape
                        TabBarShape(destTab: self.selectionIndex, currentTab: self.currentTab, tabBarCoordinatesParameters: tabBarCoordinatesParameters, transitionFactor: self.transitionFactor, transitionFactorPressed: self.transitionFactorPressed, isPressed: self.isPressed)
                            .foregroundColor(Color.sbbColor(.tabViewBackground))
                        
                        if isPortrait() {
                            // Current tab title at the bottom of the selected tab
                            self.contents[self.selectionIndex].labelView
                                .accessibility(hidden: true)
                                .background(ViewGeometry())
                                .onPreferenceChange(ViewSizeKey.self) {
                                    self.textSize = $0
                                }
                                .sbbFont(.body)
                                .lineLimit(1)
                                .minimumScaleFactor(0.1)
                                .foregroundColor(Color.sbbColor(.textBlack))
                                .padding(.top, buttonHeight + topPad)
                                .offset(x: self.getOffsetLabel(selectionIndex: self.selectionIndex, textWidth: self.textSize.width, segmentWidth: segmentWidth))
                                .frame(width: geometry.size.width, alignment: .leading)
                                .frame(height: barHeight, alignment: .topLeading)
                        }
                        
                        HStack(spacing: 0) {
                            ForEach(0..<self.contents.count) { index in
                                Button(action: {
                                    currentTab = self.selectionIndex
                                    self.selection = self.contents[index].tag as? Selection ?? self.selection

                                    if self.selectionIndex != currentTab && !isPressed {
                                        self.transitionFactor = 0.2
                                        withAnimation(Animation.easeIn(duration: 0.2)) {
                                            self.transitionFactor = 1
                                        }
                                    }
                                }) {
                                    if isPortrait() {
                                        // Display only the icon
                                        self.contents[index].imageView
                                            .frame(width: buttonWidth, height: buttonHeight)
                                    } else {
                                        // Display the icon and the text
                                        HStack(spacing: 0) {
                                            self.contents[index].imageView
                                            .frame(width: buttonWidth, height: buttonHeight)
                                            self.contents[index].labelView
                                               .accessibility(hidden: true)
                                                .sbbFont(.body)
                                                .lineLimit(1)
                                                .minimumScaleFactor(0.1)
                                                .padding(.leading, self.selectionIndex == index ? 10 : 0)
                                                .background(ViewGeometry())
                                                .onPreferenceChange(ViewSizeKey.self) {
                                                    self.textSizes[index] = $0
                                                }
                                        }
                                    }
                                }
                                .simultaneousGesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged({ _ in
                                            if !self.isPressed {
                                                self.isPressed = true
                                                self.currentTab = index
                                                self.transitionFactorPressed = 0
                                                withAnimation(Animation.easeIn(duration: 0.2)) {
                                                    self.transitionFactorPressed = 1
                                                }
                                            }
                                        })
                                        .onEnded({ _ in
                                            self.isPressed = false

                                        })
                                )
                                .accessibility(label: Text((index == self.selectionIndex) ? "\("selected".localized)." : ".") + self.contents[index].labelView + Text(". \("tab".localized)"))
                                .accessibility(removeTraits: .isButton)
                                .accessibility(hint: Text(" \(index + 1) \("of".localized) \(self.contents.count)"))
                            }
                            .foregroundColor(Color.sbbColor(.textBlack))
                            .frame(width: segmentWidth, height: barHeight, alignment: .top)
                        }
                        .clipShape(TabBarShape(destTab: self.selectionIndex, currentTab: self.currentTab, tabBarCoordinatesParameters: tabBarCoordinatesParameters, transitionFactor: self.transitionFactor, transitionFactorPressed: self.transitionFactorPressed, isPressed: self.isPressed))
                    }
                    .frame(height: barHeight)
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
    
    private func getOffsetLabel(selectionIndex: Int, textWidth: CGFloat, segmentWidth: CGFloat) -> CGFloat {
        let halfSegment = segmentWidth / 2
        let halfText = textWidth / 2
        let offset = segmentWidth * CGFloat(selectionIndex) + halfSegment - halfText
        
        if selectionIndex == 0 {
            if halfText >= 0.8 * halfSegment {
                return 10
            }
            return halfSegment - halfText
        } else if selectionIndex == self.contents.count - 1 {
            if halfText >= 0.8 * halfSegment {
                return offset - halfText + halfSegment - 10
            }
            return offset
        } else {
            return offset
        }
    }
}

private struct ViewSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

private struct ViewGeometry: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ViewSizeKey.self, value: geometry.size)
        }
    }
}

struct SBBTabView_Previews: PreviewProvider {
    private static var tabBar = SBBTabView(selection: .constant(1)){
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
