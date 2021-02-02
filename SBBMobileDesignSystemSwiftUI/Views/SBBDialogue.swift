//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public struct SBBDialogue<Content>: View where Content: View {
    
    public enum ImageStyle {
        case happy
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
    
    public enum Style {
        case fullscreen
        case inline
        case list
        
        var contentBackgroundColor: Color {
            switch self {
            case .fullscreen:
                return Color.sbbColor(.viewBackground)
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
            if style != .list && imageStyle != nil {
                imageStyle!.image
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
            HStack {
                Spacer()
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
                if errorCode != nil {
                    errorCode!
                        .sbbFont(.legendSmall)
                        .foregroundColor(Color.sbbColor(.textMetal))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
                Spacer()
            }
                .padding(16)
                .background(style.contentBackgroundColor)
                .cornerRadius((style == .fullscreen) ? 16 : 0, corners: .topLeft)
                .cornerRadius((style == .fullscreen) ? 16 : 0, corners: .topRight)
        }
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
        Image(sbbName: "arrows-circle", size: .small)
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
