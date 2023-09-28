//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import SwiftUI
import Combine

/**
 A  View that is used to show a notification.
 
 ## Overview
 You create a SBBNotification by providing a binding for a boolean that decides wether the notification is displayed or not, the type ``StatusType``, an optional title and a text. Some other parameters can be changed: the maximum number of lines for the text, a duration after which the notification automatically closes, an action to perform if we want more info and some additional action to perform when the notification is closed.
 
 ```swift
 
 @State var isPresented = true
 
 var body: some View {
    SBBNotification(isPresented: $isPresented, statusType: .alert, title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."))
 }
 ```
 ![SBBNotification](SBBNotification)
 */
public struct SBBNotification: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.sizeCategory) var sizeCategory
    
    @Binding var isPresented: Bool
    @State var textSize: CGSize = .zero
    let statusType: StatusType
    let title: Text?
    let text: Text
    let onClose: (() -> ())?
    let onMoreInfo: (() -> ())?
    let maxNumberLines: Int?
    let closeAfterSeconds: Int?
    
    private var timer: Timer?
    
    /**
     Returns a SBBNotification.
     
     - Parameters:
        - isPresented: Whether the notification is displayed.
        - statusType: The type of status for the notification.
        - title: The title of the notification.
        - text: The content text for the notification.
        - maxNumberLines: The optional max of number of lines used by the text.
        - closeAfterSeconds: The optional time in seconds after which the notification closes.
        - onClose: The optional action to do when the notification is closed.
        - onMoreInfo: The optional action to do when tapping on more action (only displayed if there is indeed an action).
     */
    public init(isPresented: Binding<Bool>, statusType: StatusType, title: Text, text: Text, maxNumberLines: Int? = nil, closeAfterSeconds: Int? = nil, onClose: (() -> ())? = nil, onMoreInfo: (() -> ())? = nil) {
        self._isPresented = isPresented
        self.statusType = statusType
        self.title = title
        self.text = text
        self.maxNumberLines = maxNumberLines
        self.closeAfterSeconds = closeAfterSeconds
        self.onClose = onClose
        self.onMoreInfo = onMoreInfo
    }
    
    /**
     Returns a SBBNotification.
     
     - Parameters:
        - isPresented: Whether the notification is displayed.
        - statusType: The type of status for the notification.
        - text: The content text for the notification.
        - maxNumberLines: The optional max of number of lines used by the text.
        - closeAfterSeconds: The optional time in seconds after which the notification closes.
        - onClose: The optional action to do when the notification is closed.
     */
    public init(isPresented: Binding<Bool>, statusType: StatusType, text: Text, maxNumberLines: Int? = nil, closeAfterSeconds: Int? = nil, onClose: (() -> ())? = nil) {
        self._isPresented = isPresented
        self.statusType = statusType
        self.title = nil
        self.text = text
        self.maxNumberLines = maxNumberLines
        self.closeAfterSeconds = closeAfterSeconds
        self.onClose = onClose
        self.onMoreInfo = nil
    }
    
    private var backgroundColor: Color {
        switch statusType {
        case .alert:
            return Color.sbbColor(.red)
        case .warning:
            return Color.sbbColor(.peach)
        case .success:
            return Color.sbbColor(.green)
        case .info:
            return Color.sbbColor(.smoke)
        }
    }
    
    private var icon: some View {
        switch statusType {
        case .alert:
            return Image(sbbIcon: sizeCategory.isAccessibilityCategory ? .circle_cross_medium : .circle_cross_small)
                .foregroundColor(Color.sbbColor(.red))
        case .warning:
            // TODO: use .circle_exclamation_point once icons update
            return Image(sbbIcon: sizeCategory.isAccessibilityCategory ? .exclamation_point_medium : .exclamation_point_small)
                .foregroundColor(Color.sbbColor(colorScheme == .dark ? .peach : .black))
        case .success:
            return Image(sbbIcon: sizeCategory.isAccessibilityCategory ? .circle_tick_medium : .circle_tick_small)
                .foregroundColor(Color.sbbColor(.green))
        case .info:
            return Image(sbbIcon: sizeCategory.isAccessibilityCategory ? .circle_information_medium : .circle_information_small)
                .foregroundColor(Color.sbbColor(.textBlack))
        }
    }
    
    private var closeButton: some View {
        Button(action: {
            self.isPresented = false
            if let onClose = onClose {
                onClose()
            }
        }) {
            Image(sbbIcon: .cross_small)
                .foregroundColor(Color.sbbColor(.textBlack))
                .frame(width: 28, height: 28)
        }
    }
    
    public var body: some View {
        if self.isPresented {
            VStack(spacing: 0) {
                VStack(spacing: 16) {
                    if let title = title {
                        HStack {
                            icon
                                .frame(width: 28, height: 28)
                            title
                                .foregroundColor(Color.sbbColor(.textBlack))
                                .sbbFont(.headline)
                            Spacer()
                            closeButton
                        }
                    }
                    HStack(alignment: .top) {
                        if title == nil {
                            icon
                                .frame(width: 28, height: 28)
                        }
                        Group {
                            if let maxNumberLines = maxNumberLines {
                                text
                                    .minimumScaleFactor(0.1)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(maxNumberLines)
                            } else {
                                text
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                        .frame(minWidth: 28, minHeight: 28)
                        .foregroundColor(Color.sbbColor(.textBlack))
                        .sbbFont(.body)
                        .viewSize($textSize)
                        Spacer()
                        
                        if let onMoreInfo = onMoreInfo {
                            Button(action: {
                                onMoreInfo()
                            }) {
                                Image(sbbIcon: .chevron_small_right_medium)
                                    .foregroundColor(Color.sbbColor(.textBlack))
                                    .frame(height: title == nil ? textSize.height - 28 : textSize.height)
                            }
                        } else if title == nil {
                            closeButton
                        }
                        
                    }
                }
                .sbbScreenPadding()
                .background(Color.sbbColor(colorScheme == .dark ? .black : .white).opacity(colorScheme == .dark ? 0.85 : 0.95))
                .cornerRadius(16, corners: [.topRight, .bottomRight])
                .cornerRadius(7, corners: [.topLeft, .bottomLeft])
                .padding(1)
                .padding(.leading, 8)
            }
            .background(backgroundColor)
            .cornerRadius(17)
            .transition(.opacity)
            .onAppear {
                if let closeAfterSeconds = self.closeAfterSeconds {
                    DispatchQueue.main.asyncAfter(deadline: .now () + Double(closeAfterSeconds)) {
                        self.isPresented = false
                        onClose?()
                    }
                }
            }
        } else {
            EmptyView()
        }
    }
}

struct SBBNotification_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                SBBNotification(isPresented: .constant(true), statusType: .alert, title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."))
                SBBNotification(isPresented: .constant(true), statusType: .alert, title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."), onMoreInfo: {})
            }
            .previewDisplayName("Normal")
            VStack {
                SBBNotification(isPresented: .constant(true), statusType: .alert, text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."))
            }
            .previewDisplayName("No title")
            VStack {
                SBBNotification(isPresented: .constant(true), statusType: .warning, title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."))
                SBBNotification(isPresented: .constant(true), statusType: .warning, title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."), onMoreInfo: {})
            }
            .environment(\.sizeCategory, .accessibilityLarge)
            .previewDisplayName("Accessibility")
            VStack {
                SBBNotification(isPresented: .constant(true), statusType: .success, title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."), maxNumberLines: 4)
                SBBNotification(isPresented: .constant(true), statusType: .success, title: Text("Title"), text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."), maxNumberLines: 4, onMoreInfo: {})
            }
            .environment(\.sizeCategory, .accessibilityLarge)
            .previewDisplayName("Accessibility limit lines")
            VStack {
                SBBNotification(isPresented: .constant(true), statusType: .info, text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."))
                SBBNotification(isPresented: .constant(true), statusType: .success, text: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore."), maxNumberLines: 4)
            }
            .environment(\.sizeCategory, .accessibilityLarge)
            .previewDisplayName("Accessibility no title")
        }
        .previewLayout(.sizeThatFits)
    }
}
