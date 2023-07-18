//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import SwiftUI

public extension SBBMessage where TopImage == EmptyView, BottomImage == EmptyView {
    /**
     Returns a SBBMessage.
     
     - Parameters:
        - title: The Text to display as title.
        - text: The Text to display as the body of the message.
        - imageType: The type of message, either ImageType.info or ImageType.error.
        - errorCode: The Text to display as error.
        - isLoading: Whether to show the loading indicator at the bottom.
        - fixedSize: Whether the message size is fixed, if not fixed: automatically wrapped in ScrollView if too big.
        - bottomAccessibilityHidden: Whether the bottom image (View) is hidden for the accessibility (VoiceOver).
     */
    init(title: Text, text: Text, imageType: ImageType, errorCode: Text? = nil, isLoading: Bool = false, fixedSize: Bool = false, bottomAccessibilityHidden: Bool = true) {
        self.title = title
        self.message = text
        self.errorCode = errorCode
        self.imageType = imageType
        self.topImage = nil
        self.bottomImage = nil
        self.isLoading = isLoading
        self.retry = nil
        self.fixedSize = fixedSize
        self.bottomAccessibilityHidden = bottomAccessibilityHidden
    }
    
    /**
     Returns a SBBMessage.
     
     - Parameters:
        - title: The Text to display as title.
        - text: The Text to display as the body of the message.
        - imageType: The type of message, either ImageType.info or ImageType.error.
        - errorCode: The Text to display as error.
        - retry: The action to do when retry button (displayed at the bottom) is pressed.
        - fixedSize: Whether the message size is fixed, if not fixed: automatically wrapped in ScrollView if too big.
        - bottomAccessibilityHidden: Whether the bottom image (View) is hidden for the accessibility (VoiceOver).
     */
    init(title: Text, text: Text, imageType: ImageType, errorCode: Text? = nil, retry: @escaping (() -> ()), fixedSize: Bool = false, bottomAccessibilityHidden: Bool = true) {
        self.title = title
        self.message = text
        self.errorCode = errorCode
        self.imageType = imageType
        self.topImage = nil
        self.bottomImage = nil
        self.isLoading = false
        self.retry = retry
        self.fixedSize = fixedSize
        self.bottomAccessibilityHidden = bottomAccessibilityHidden
    }
}

public extension SBBMessage where TopImage == EmptyView {
    
    /**
     Returns a SBBMessage.
     
     - Parameters:
        - title: The Text to display as title.
        - text: The Text to display as the body of the message.
        - imageType: The type of message, either ImageType.info or ImageType.error.
        - bottomImage: The image (View) to display at the bottom of the message.
        - errorCode: The Text to display as error.
        - fixedSize: Whether the message size is fixed, if not fixed: automatically wrapped in ScrollView if too big.
        - bottomAccessibilityHidden: Whether the bottom image (View) is hidden for the accessibility (VoiceOver).
     */
    init(title: Text, text: Text, imageType: ImageType, bottomImage: BottomImage, errorCode: Text? = nil, fixedSize: Bool = false, bottomAccessibilityHidden: Bool = true) {
        self.title = title
        self.message = text
        self.errorCode = errorCode
        self.imageType = imageType
        self.topImage = nil
        self.bottomImage = bottomImage
        self.isLoading = false
        self.retry = nil
        self.fixedSize = fixedSize
        self.bottomAccessibilityHidden = bottomAccessibilityHidden
    }
}

public extension SBBMessage where BottomImage == EmptyView {
    
    /**
     Returns a SBBMessage.
     
     - Parameters:
        - title: The Text to display as title.
        - text: The Text to display as the body of the message.
        - topImage: The image (View) to display at the top of the message.
        - errorCode: The Text to display as error.
        - isLoading: Whether to show the loading indicator at the bottom.
        - fixedSize: Whether the message size is fixed, if not fixed: automatically wrapped in ScrollView if too big.
        - bottomAccessibilityHidden: Whether the bottom image (View) is hidden for the accessibility (VoiceOver).
     */
    init(title: Text, text: Text, topImage: TopImage, errorCode: Text? = nil, isLoading: Bool = false, fixedSize: Bool = false, bottomAccessibilityHidden: Bool = true) {
        self.title = title
        self.message = text
        self.errorCode = errorCode
        self.imageType = nil
        self.topImage = topImage
        self.bottomImage = nil
        self.isLoading = isLoading
        self.retry = nil
        self.fixedSize = fixedSize
        self.bottomAccessibilityHidden = bottomAccessibilityHidden
    }
    
    /**
     Returns a SBBMessage.
     
     - Parameters:
        - title: The Text to display as title.
        - text: The Text to display as the body of the message.
        - topImage: The image (View) to display at the top of the message.
        - errorCode: The Text to display as error.
        - retry: The action to do when retry button (displayed at the bottom) is pressed.
        - fixedSize: Whether the message size is fixed, if not fixed: automatically wrapped in ScrollView if too big.
        - bottomAccessibilityHidden: Whether the bottom image (View) is hidden for the accessibility (VoiceOver).
     */
    init(title: Text, text: Text, topImage: TopImage, errorCode: Text? = nil, retry: @escaping (() -> ()), fixedSize: Bool = false, bottomAccessibilityHidden: Bool = true) {
        self.title = title
        self.message = text
        self.errorCode = errorCode
        self.imageType = nil
        self.topImage = topImage
        self.bottomImage = nil
        self.isLoading = false
        self.retry = retry
        self.fixedSize = fixedSize
        self.bottomAccessibilityHidden = bottomAccessibilityHidden
    }
}


/**
 A  View that is used to display a message, usually in full screen.
 
 ## Overview
 You create a SBBMessage by providing a title and a text message, both as Text. You typically provide a ``SBBMessage/ImageType`` for the message, it is either ``SBBMessage/ImageType/info`` if the message is informative or ``SBBMessage/ImageType/error`` if the message is an error or a warning.
 The top and bottom image can be customized with the parameters `topImage` and `bottomImage`.
 
 ```swift
 var body: some View {
    SBBMessage(title: "A title", text: "Some message", imageType: .info, errorCode: Text("Error: 404"), isLoading: false)
 }
 
 var body: some View {
    SBBMessage(title: "A title", text: "Some message", imageType: .info, errorCode: Text("Error: 404"), retry: {
         // Some action to do on retry
         }
    )
 }
 ```
 ![SBBMessage](SBBMessage)
 */
public struct SBBMessage<TopImage: View, BottomImage: View>: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var contentSize: CGSize = .zero
    
    public enum ImageType: CaseIterable {
        /// Used for information: the image is either a man or a woman
        case info
        /// Used for error or warnings: the image is the display board
        case error
    }
    
    var image: Image? {
        if let imageType = imageType {
            switch imageType {
            case .info:
                let randomInt = Int.random(in: 0..<2)
                if randomInt == 0 {
                    return Image(colorScheme == .dark ? "sbb_m_dark" : "sbb_m_day", bundle: Helper.bundle)
                } else {
                    return Image(colorScheme == .dark ? "sbb_w_dark" : "sbb_w_day", bundle: Helper.bundle)
                }
                
            case .error:
                return Image(colorScheme == .dark ? "sbb_board_dark" : "sbb_board_day", bundle: Helper.bundle)
            }
        } else {
            return nil
        }
    }
    
    private let title: Text
    private let message: Text
    private let errorCode: Text?
    private let imageType: ImageType?
    private let topImage: TopImage?
    private let bottomImage: BottomImage?
    private let isLoading: Bool
    private let retry: (() -> ())?
    private let fixedSize: Bool
    private let bottomAccessibilityHidden: Bool
    
    /**
     Returns a SBBMessage.
     
     - Parameters:
        - title: The Text to display as title.
        - text: The Text to display as the body of the message.
        - topImage: The image (View) to display at the top of the message.
        - bottomImage: The image (View) to display at the bottom of the message.
        - errorCode: The Text to display as error.
        - isLoading: Whether to show the loading indicator at the bottom.
        - fixedSize: Whether the message size is fixed, if not fixed: automatically wrapped in ScrollView if too big.
        - bottomAccessibilityHidden: Whether the bottom image (View) is hidden for the accessibility (VoiceOver).
     */
    public init(title: Text, text: Text, topImage: TopImage, bottomImage: BottomImage, errorCode: Text? = nil, isLoading: Bool = false, fixedSize: Bool = false, bottomAccessibilityHidden: Bool = true) {
        self.title = title
        self.message = text
        self.errorCode = errorCode
        self.imageType = nil
        self.topImage = topImage
        self.bottomImage = bottomImage
        self.isLoading = isLoading
        self.retry = nil
        self.fixedSize = fixedSize
        self.bottomAccessibilityHidden = bottomAccessibilityHidden
    }
    
    /**
     Returns a SBBMessage.
     
     - Parameters:
        - title: The Text to display as title.
        - text: The Text to display as the body of the message.
        - topImage: The image (View) to display at the top of the message.
        - bottomImage: The image (View) to display at the bottom of the message.
        - errorCode: The Text to display as error.
        - retry: The action to do when retry button (displayed at the bottom) is pressed.
        - fixedSize: Whether the message size is fixed, if not fixed: automatically wrapped in ScrollView if too big.
        - bottomAccessibilityHidden: Whether the bottom image (View) is hidden for the accessibility (VoiceOver).
     */
    init(title: Text, text: Text, topImage: TopImage, bottomImage: BottomImage, errorCode: Text? = nil, retry: @escaping (() -> ()), fixedSize: Bool = false, bottomAccessibilityHidden: Bool = true) {
        self.title = title
        self.message = text
        self.errorCode = errorCode
        self.imageType = nil
        self.topImage = topImage
        self.bottomImage = bottomImage
        self.isLoading = false
        self.retry = retry
        self.fixedSize = fixedSize
        self.bottomAccessibilityHidden = bottomAccessibilityHidden
    }
    
    private var contentView: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                VStack(alignment: .center, spacing: 32) {
                    Group {
                        if let image = image {
                            image
                        } else if let topImage = topImage {
                            topImage
                        }
                    }
                    .accessibility(hidden: true)
                    
                    VStack(alignment: .center, spacing: 16) {
                        title
                            .sbbFont(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.sbbColor(.textBlack))
                        message
                            .multilineTextAlignment(.center)
                            .sbbFont(.legend)
                            .foregroundColor(Color.sbbColor(colorScheme == .light ? .granite : .graphite))
                        if let errorCode = errorCode {
                            errorCode
                                .sbbFont(.legendSmall)
                                .foregroundColor(Color.sbbColor(colorScheme == .light ? .granite : .graphite))
                        }
                    }
                    .accessibilityElement(children: .combine)
                    
                    Group {
                        if isLoading {
                            SBBLoadingIndicator()
                        } else if let retry = retry {
                            Button(action: retry) {
                                Image(sbbIcon: .arrows_circle_small)
                            }
                            .buttonStyle(SBBIconButtonStyle())
                        } else if let bottomImage = bottomImage {
                            bottomImage
                        }
                    }
                    .accessibility(hidden: bottomAccessibilityHidden)
                }
                .sbbScreenPadding(.horizontal)
                .fixedSize(horizontal: false, vertical: true)
                .viewSize(self.$contentSize)
                Spacer()
            }
            Spacer()
        }
        .background(Color.sbbColor(.background))
    }
    
    public var body: some View {
        Group {
            if fixedSize {
                contentView
            } else {
                GeometryReader { geometry in
                    VStack {
                        if useScrollView(parentSize: geometry.size.height) {
                            ScrollView(.vertical, showsIndicators: false) {
                                contentView
                            }
                        } else {
                            contentView
                        }
                    }
                }
            }
        }
    }
    
    func useScrollView(parentSize: CGFloat) -> Bool {
        return contentSize.height > parentSize
    }
}

struct SBBMessage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBMessage(title: Text("Title, single line if possible."), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus."), imageType: .info, isLoading: false)
                .previewDisplayName("Info")
            SBBMessage(title: Text("Title, single line if possible."), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus."), imageType: .info, isLoading: true)
                .previewDisplayName("Info Loading")
            SBBMessage(title: Text("Title, single line if possible."), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus."), imageType: .info, retry: {})
                .previewDisplayName("Info Retry")
            SBBMessage(title: Text("Title, single line if possible."), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus."), imageType: .info, bottomImage: Image(sbbIcon: .arrow_circle_small))
                .previewDisplayName("Info Bottom Image")
            SBBMessage(title: Text("Title, single line if possible."), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus."), imageType: .error, errorCode: Text("Error: 404"), isLoading: false)
                .previewDisplayName("Error")
            SBBMessage(title: Text("Title, single line if possible."), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus."), imageType: .error, errorCode: Text("Error: 404"), isLoading: true)
                .previewDisplayName("Error Loading")
            SBBMessage(title: Text("Title, single line if possible."), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus."), imageType: .error, errorCode: Text("Error: 404"), retry: {})
                .previewDisplayName("Error Retry")
            SBBMessage(title: Text("Title, single line if possible."), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus."), imageType: .error, bottomImage: Image(sbbIcon: .arrow_circle_small), errorCode: Text("Error: 404"))
                .previewDisplayName("Error Bottom Image")
            SBBMessage(title: Text("Title, single line if possible."), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus."), topImage: SBBLoadingIndicator())
                .previewDisplayName("Top Image")
            SBBMessage(title: Text("Title, single line if possible."), text: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vulputate massa ut ex fringilla, vel rutrum nulla pretium. Vivamus auctor ex sed nunc maximus."), topImage: Image(sbbIcon: .binoculars_large), bottomImage: Image(sbbIcon: .arrows_circle_medium))
                .previewDisplayName("Top and Bottom Image")
            
        }
    }
}
