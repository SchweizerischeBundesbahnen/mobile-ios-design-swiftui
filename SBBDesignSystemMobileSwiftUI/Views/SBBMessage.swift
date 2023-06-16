//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import SwiftUI

public extension SBBMessage where TopImage == EmptyView, BottomImage == EmptyView {
    
    init(title: Text, text: Text, imageType: ImageType, errorCode: Text? = nil, isLoading: Bool = false) {
        self.title = title
        self.message = text
        self.errorCode = errorCode
        self.imageType = imageType
        self.topImage = nil
        self.bottomImage = nil
        self.isLoading = isLoading
        self.retry = nil
    }
    
    init(title: Text, text: Text, imageType: ImageType, errorCode: Text? = nil, retry: @escaping (() -> ())) {
        self.title = title
        self.message = text
        self.errorCode = errorCode
        self.imageType = imageType
        self.topImage = nil
        self.bottomImage = nil
        self.isLoading = false
        self.retry = retry
    }
}

public extension SBBMessage where TopImage == EmptyView {
    
    init(title: Text, text: Text, imageType: ImageType, bottomImage: BottomImage, errorCode: Text? = nil) {
        self.title = title
        self.message = text
        self.errorCode = errorCode
        self.imageType = imageType
        self.topImage = nil
        self.bottomImage = bottomImage
        self.isLoading = false
        self.retry = nil
    }
}

public extension SBBMessage where BottomImage == EmptyView {
    
    init(title: Text, text: Text, topImage: TopImage, errorCode: Text? = nil, isLoading: Bool = false) {
        self.title = title
        self.message = text
        self.errorCode = errorCode
        self.imageType = nil
        self.topImage = topImage
        self.bottomImage = nil
        self.isLoading = isLoading
        self.retry = nil
    }
    
    init(title: Text, text: Text, topImage: TopImage, errorCode: Text? = nil, retry: @escaping (() -> ())) {
        self.title = title
        self.message = text
        self.errorCode = errorCode
        self.imageType = nil
        self.topImage = topImage
        self.bottomImage = nil
        self.isLoading = false
        self.retry = retry
    }
}

public struct SBBMessage<TopImage: View, BottomImage: View>: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    public enum ImageType: CaseIterable {
        //
        case info
        //
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
    
    public init(title: Text, text: Text, topImage: TopImage, bottomImage: BottomImage, errorCode: Text? = nil, isLoading: Bool = false) {
        self.title = title
        self.message = text
        self.errorCode = errorCode
        self.imageType = nil
        self.topImage = topImage
        self.bottomImage = bottomImage
        self.isLoading = isLoading
        self.retry = nil
    }
    
    init(title: Text, text: Text, topImage: TopImage, bottomImage: BottomImage, errorCode: Text? = nil, retry: @escaping (() -> ())) {
        self.title = title
        self.message = text
        self.errorCode = errorCode
        self.imageType = nil
        self.topImage = topImage
        self.bottomImage = bottomImage
        self.isLoading = false
        self.retry = retry
    }
    
    public var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center, spacing: 32) {
                Spacer()
                
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
                .accessibility(hidden: true)
                Spacer()
            }
                .sbbScreenPadding(.horizontal)
            Spacer()
        }
            .background(Color.sbbColor(.background))
            
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
