//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

/**
 A  View that is used to display a loading state.
 
 ## Overview
 You create a SBBLoadingIndicator by specifying its ``SBBLoadingIndicator/Size`` and its ``SBBLoadingIndicator/Style``:
 ```swift
 var body: some View {
    SBBLoadingIndicator(size: .normal, style: .primary)
 }
 ```
 ![SBBLoadingIndicator](SBBLoadingIndicator)
 */
public struct SBBLoadingIndicator: View {
    
    /// SBBLoadingIndicator Size.
    public enum Size {
        /// Normal SBBLoadingIndicator Size.
        case normal
        /// Small SBBLoadingIndicator Size.
        case small
        
        var size: CGSize {
            switch self {
            case .normal:
                return CGSize(width: 55, height: 32)
            case .small:
                return CGSize(width: 31, height: 18)
            }
        }
    }
    
    /// SBBLoadingIndicator Style.
    public enum Style {
        /// SBBLoadingIndicator in primary color (red by default) on a background depending on the current ColorScheme.
        case primary
        /// Grey SBBLoadingIndicator on a background depending on the current ColorScheme.
        case grey
        /// White SBBLoadingIndicator on a background of the primary color (red by default).
        case primaryBackground
        
        func color(for colorScheme: ColorScheme) -> Color {
            switch (self, colorScheme) {
            case (.primary, _):
                return Color.sbbColor(.primary)
            case (.grey, _):
                return Color.sbbColor(.metal)
            case (.primaryBackground, _):
                return Color.sbbColor(.white)
            }
        }
    }
    
    private struct RectangleProperties {
        var offset: CGFloat
        var opacity: Double
    }
    
    private var rectangleOpacity = [0.0, 0.4, 1.0, 0.7, 0.4, 0.1]
    private var rectangleOffsets: [CGFloat]
    @State private var rectangleProperties: [RectangleProperties]
    
    @Environment(\.colorScheme) var colorScheme
    
    private var style: Style
    private var width: CGFloat
    private var height: CGFloat
    private var numberOfRectangles = 5
    private var animationDuration = 0.5
    private var rotationInDegrees = 20.0
    private var innerWidth: CGFloat // the width of the entire "train" is wider than it's containing view, since it's rotated to the back around the leading y-axis
    private var rectangleWidth: CGFloat
    
    /**
     Returns a SBBLoadingIndicator with the given size and style.
     
     - Parameters:
        - size: Sets the size of the SBBLoadingIndicator.
        - style: Sets the colof of the SBBLoadingIndicator.
     */
    public init(size: Size = .normal, style: Style = .primary) {
        self.style = style
        self.width = size.size.width
        self.height = size.size.height
        
        let innerWidth = width / CGFloat(cos(rotationInDegrees * .pi / 180)) * 3.0
        self.innerWidth = innerWidth
        let paddingBetweenRectangles = size == .normal ? 8.0 : 4.0
        self.rectangleWidth = innerWidth / CGFloat(numberOfRectangles) + paddingBetweenRectangles
        
        rectangleOffsets = [-rectangleWidth, 0, rectangleWidth, 2.0*rectangleWidth, 3.0*rectangleWidth, 4.0*rectangleWidth]

        _rectangleProperties = State(initialValue: [RectangleProperties(offset: rectangleOffsets[1], opacity: rectangleOpacity[1]), RectangleProperties(offset: rectangleOffsets[2], opacity: rectangleOpacity[2]), RectangleProperties(offset: rectangleOffsets[3], opacity: rectangleOpacity[3]), RectangleProperties(offset: rectangleOffsets[4], opacity: rectangleOpacity[4]), RectangleProperties(offset: rectangleOffsets[5], opacity: rectangleOpacity[5])])
    }
        
    public var body: some View {
        Group {
            ZStack {
                ForEach(rectangleProperties.indices, id:\.self) { index in
                    Rectangle()
                        .fill(style.color(for: colorScheme))
                        .frame(width: innerWidth / CGFloat(numberOfRectangles), height: height)
                        .opacity(rectangleProperties[index].opacity)
                        .offset(x: rectangleProperties[index].offset)
                        .onAppear {
                            DispatchQueue.main.async {
                                withAnimation(Animation.linear(duration: animationDuration)
                                        .repeatForever(autoreverses: false)
                                )
                                {
                                    rectangleProperties[index].offset = rectangleOffsets[index]
                                }
                            
                                withAnimation(Animation.linear(duration: animationDuration)
                                                .repeatForever(autoreverses: false)
                                ) {
                                    rectangleProperties[index].opacity = rectangleOpacity[index]
                                }
                            }
                        }
                }
            }
                .rotation3DEffect(.degrees(rotationInDegrees), axis: (x: 0, y: 1, z: 0), anchor: .leading)
        }
            .frame(width: width, height: height, alignment: .leading)
            .padding(16)
            
        .accessibility(label: Text("Loading.".localized))
    }
}

// Note: You need to run the Preview (by pressing play) to be able to see the LoadingIndicator
struct SBBLoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                SBBLoadingIndicator()
                    .previewDisplayName("normal, red, light")
                SBBLoadingIndicator()
                    .previewDisplayName("normal, red, dark")
                    .environment(\.colorScheme, .dark)
                SBBLoadingIndicator(style: .grey)
                    .previewDisplayName("normal, grey, light")
                SBBLoadingIndicator(style: .grey)
                    .previewDisplayName("normal, grey, dark")
                SBBLoadingIndicator(style: .primaryBackground)
                    .previewDisplayName("normal, white, light")
                SBBLoadingIndicator(style: .primaryBackground)
                    .previewDisplayName("normal, white, dark")
                    .environment(\.colorScheme, .dark)
            }
            Group {
                SBBLoadingIndicator(size: .small)
                    .previewDisplayName("small, red, light")
                SBBLoadingIndicator(size: .small)
                    .previewDisplayName("small, red, dark")
                    .environment(\.colorScheme, .dark)
                SBBLoadingIndicator(size: .small, style: .grey)
                    .previewDisplayName("small, grey, light")
                SBBLoadingIndicator(size: .small, style: .grey)
                    .previewDisplayName("small, grey, dark")
                SBBLoadingIndicator(size: .small, style: .primaryBackground)
                    .previewDisplayName("small, white, light")
                SBBLoadingIndicator(size: .small, style: .primaryBackground)
                    .previewDisplayName("small, white, dark")
                    .environment(\.colorScheme, .dark)
            }
        }
            .previewLayout(.sizeThatFits)
    }
}
