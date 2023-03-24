//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

/**
 A  View that can be used to inform users about an event (e.g. an error) or to show them a selection of options.
 
 ## Overview
 You create a SBBDialogue by providing a title, a label, an optional errorCode, the desired ``SBBDialogue/Style``, and your custom content:
 ```swift
 var body: some View {
     SBBDialogue(title: title, label: label, errorCode: errorCode, style: .inline) {
         Button(action: { }) {
             Text("Custom Action 2")
         }
             .buttonStyle(SBBSecondaryButtonStyle())
         Button(action: { }) {
             Text("Custom Action 1")
         }
             .buttonStyle(SBBPrimaryButtonStyle())
     }
 }
 ```
 ![SBBDialogue](SBBDialogue)
 
 You typically use a SBBDialogue with ``SBBDialogue/Style/inline`` or ``SBBDialogue/Style/list`` directly in your view. A SBBDialogue with ``SBBDialogue/Style/fullscreen`` is used together with the .sbbModal() ViewModifier:
 ```swift
 @State var showDialogue = false
 
 var body: some View {
     YourView()
        .sbbModal(isPresented: $showDialogue) {
             SBBDialogue(title: title, label: label, errorCode: errorCode, style: .fullscreen) {
                 Button(action: { }) {
                     Text("Custom Action 2")
                 }
                     .buttonStyle(SBBSecondaryButtonStyle())
                 Button(action: { }) {
                     Text("Custom Action 1")
                 }
                     .buttonStyle(SBBPrimaryButtonStyle())
             }
        }
 }
  ```
 */
public struct SBBDialogue<Content>: View where Content: View {
    
    /// SBBDialogue Style.
    public enum ImageStyle: CaseIterable {
        /// Happy SBBDialogue Style, presenting a happy image above the title.
        case happy
        /// Sad SBBDialogue Style, presenting a sad image above the title.
        case sad
        
        var image: Image {
            switch self {
            case .happy:
                return Image("men-happy", bundle: Helper.bundle)
            case .sad:
                return Image("men-sad", bundle: Helper.bundle)
            }
        }
    }
    
    /// SBBDialogue Style.
    public enum Style: CaseIterable {
        /// Fullscreen SBBModalView Style (to be used with the .sbbModal() ViewModifier). The SBBModalView is displayed above the entire screen (pinned to the bottom edge).
        case fullscreen
        /// Inline SBBModalView Style (to be used inline as the (vertically) last element of the View).
        case inline
        /// List SBBModalView Style (to be used wherever desired, e.g. in a list).
        case list
        
        var contentBackgroundColor: Color {
            switch self {
            case .fullscreen:
                return Color.sbbColor(.modalBackground)
            case .inline, .list:
                return Color.sbbColor(.background)
            }
        }
    }
    
    @Environment(\.colorScheme) var colorScheme

    private var title: Text
    private var label: Text
    private var errorCode: Text?
    private let content: Content
    private let style: Style
    private let imageStyle: ImageStyle?

    /**
     Returns a SBBDialogue displaying a title, a label, an optional errorCode and custom content.
     
     - Parameters:
        - title: The Text to display as title.
        - label: The Text to display as a description below the title.
        - errorCode: An optional error code to be displayed at the bottom edge of the view (typically a http request error code).
        - style: The style of the SBBDialogue depending on how it is presented.
        - imageStyle: An optional imageStyle presenting a happy/sad image above the title.
        - content: A custom VIew to be shown underneath the title and label.
     */
    public init(title: Text, label: Text, errorCode: Text? = nil, style: Style = .fullscreen, imageStyle: ImageStyle? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self.title = title
        self.label = label
        self.errorCode = errorCode
        self.style = style
        self.imageStyle = imageStyle
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            if style == .fullscreen {
                Spacer()
            }
            if style != .list, let imageStyle = imageStyle {
                imageStyle.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(
                        Group {
                            if style == .inline {
                                Rectangle()
                                    .frame(height: 93)
                                    .foregroundColor(.clear)
                                    .background(LinearGradient(gradient: Gradient(colors: [.clear, (colorScheme == .light) ? .white : .black]), startPoint: .top, endPoint: .bottom))
                                    .offset(y: -16)
                            }
                        }
                    , alignment: .bottom)
                    .offset(y: 16)
                    .accessibility(hidden: true)
            }
            VStack(alignment: .center, spacing: 16) {
                title
                    .sbbFont(.titleModul)
                    .foregroundColor(Color.sbbColor(.textBlack))
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibility(addTraits: .isHeader)
                label
                    .sbbFont(.legend)
                    .foregroundColor(Color.sbbColor(.textMetal))
                    .fixedSize(horizontal: false, vertical: true)
                VStack(alignment: .center, spacing: 16) {
                    content
                }
                    .padding(.vertical, 8)
                if let errorCode = errorCode {
                    errorCode
                        .sbbFont(.legendSmall)
                        .foregroundColor(Color.sbbColor(.textMetal))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
                .sbbScreenPadding()
                .background(style.contentBackgroundColor)
                .cornerRadius((style == .fullscreen) ? 16 : 0, corners: .topLeft)
                .cornerRadius((style == .fullscreen) ? 16 : 0, corners: .topRight)
                .background(    // we need to reapply background color for styles, where not all edges are rounded (.cornerRadius clips the view)
                    (style == .fullscreen ? style.contentBackgroundColor : Color.clear)
                        .offset(y: 16)
                        .clipped()
                        .edgesIgnoringSafeArea(.bottom)
                )
        }
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct SBBDialogue_Previews: PreviewProvider {
    static let title = Text("Title")
    static let label = Text("Multiline Text")
    static let errorCode = Text("ErrorCode: 404")
    static let button1 = Button(action: {}) {
        Text("Button 1")
    }
    static let button2 = Button(action: {}) {
        Text("Button 2")
    }
    static let button3 = Button(action: {}) {
        Text("Button 3")
    }
    static let buttonReload = Button(action: {}) {
        Image(sbbIcon: .arrow_circle_small)
    }
    
    static var previews: some View {
        Group {
            SBBDialogue(title: title, label: label, errorCode: errorCode) {
                button3
                    .buttonStyle(SBBSecondaryButtonStyle())
                button2
                    .buttonStyle(SBBSecondaryButtonStyle())
                button1
                    .buttonStyle(SBBPrimaryButtonStyle())
            }
                .previewDisplayName("fullscreen, custom buttons")
            SBBDialogue(title: title, label: label) {
                button3
                    .buttonStyle(SBBSecondaryButtonStyle())
                button2
                    .buttonStyle(SBBSecondaryButtonStyle())
                button1
                    .buttonStyle(SBBPrimaryButtonStyle())
            }
                .previewDisplayName("fullscreen, custom buttons, dark")
                .environment(\.colorScheme, .dark)
            SBBDialogue(title: title, label: label, errorCode: errorCode, imageStyle: .sad) {
                button3
                    .buttonStyle(SBBSecondaryButtonStyle())
                button2
                    .buttonStyle(SBBSecondaryButtonStyle())
                button1
                    .buttonStyle(SBBPrimaryButtonStyle())
            }
                .previewDisplayName("fullscreen, sad image, custom buttons")
            SBBDialogue(title: title, label: label, imageStyle: .happy) {
                button3
                    .buttonStyle(SBBSecondaryButtonStyle())
                button2
                    .buttonStyle(SBBSecondaryButtonStyle())
                button1
                    .buttonStyle(SBBPrimaryButtonStyle())
            }
                .previewDisplayName("fullscreen, custom buttons, happy image, dark")
                .environment(\.colorScheme, .dark)
            SBBDialogue(title: title, label: label, errorCode: errorCode) {
                buttonReload
                    .buttonStyle(SBBIconButtonStyle())
            }
                .previewDisplayName("fullscreen, reload button")
            SBBDialogue(title: title, label: label) {
                buttonReload
                    .buttonStyle(SBBIconButtonStyle())
            }
                .previewDisplayName("fullscreen, reload button, dark")
                .environment(\.colorScheme, .dark)
        }
        Group {
            SBBDialogue(title: title, label: label, errorCode: errorCode, style: .inline) {
                button3
                    .buttonStyle(SBBSecondaryButtonStyle())
                button2
                    .buttonStyle(SBBSecondaryButtonStyle())
                button1
                    .buttonStyle(SBBPrimaryButtonStyle())
            }
                .previewDisplayName("inline, custom buttons")
            SBBDialogue(title: title, label: label, style: .inline) {
                button3
                    .buttonStyle(SBBSecondaryButtonStyle())
                button2
                    .buttonStyle(SBBSecondaryButtonStyle())
                button1
                    .buttonStyle(SBBPrimaryButtonStyle())
            }
                .previewDisplayName("inline, custom buttons, dark")
                .environment(\.colorScheme, .dark)
            SBBDialogue(title: title, label: label, errorCode: errorCode, style: .inline, imageStyle: .sad) {
                button3
                    .buttonStyle(SBBSecondaryButtonStyle())
                button2
                    .buttonStyle(SBBSecondaryButtonStyle())
                button1
                    .buttonStyle(SBBPrimaryButtonStyle())
            }
                .previewDisplayName("inline, custom buttons, sad image")
            SBBDialogue(title: title, label: label, style: .inline, imageStyle: .happy) {
                button3
                    .buttonStyle(SBBSecondaryButtonStyle())
                button2
                    .buttonStyle(SBBSecondaryButtonStyle())
                button1
                    .buttonStyle(SBBPrimaryButtonStyle())
            }
                .previewDisplayName("inline, custom buttons, happy image, dark")
                .environment(\.colorScheme, .dark)
            SBBDialogue(title: title, label: label, errorCode: errorCode, style: .inline) {
                buttonReload
                    .buttonStyle(SBBIconButtonStyle())
            }
                .previewDisplayName("inline, reload button")
            SBBDialogue(title: title, label: label, style: .inline) {
                buttonReload
                    .buttonStyle(SBBIconButtonStyle())
            }
                .previewDisplayName("inline, reload button, dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
        Group {
            SBBDialogue(title: title, label: label, errorCode: errorCode, style: .list) {
                buttonReload
                    .buttonStyle(SBBIconButtonStyle())
            }
                .previewDisplayName("list, reload button")
            SBBDialogue(title: title, label: label, style: .list) {
                buttonReload
                    .buttonStyle(SBBIconButtonStyle())
            }
                .previewDisplayName("list, reload button, dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}
