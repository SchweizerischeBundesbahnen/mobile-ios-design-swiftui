//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

// TODO: add anti-aliasing once SwiftUI supports it
/// A  View that is used to display a loading state.
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
        /// Red SBBLoadingIndicator on a background depending on the current ColorScheme.
        case red
        /// Grey SBBLoadingIndicator on a background depending on the current ColorScheme.
        case grey
        /// White SBBLoadingIndicator on a red background.
        case white
        
        func color(for colorScheme: ColorScheme) -> Color {
            switch (self, colorScheme) {
            case (.red, _):
                return Color.sbbColor(.red).opacity(1.0)
            case (.grey, .light):
                return Color.sbbColor(.iron).opacity(0.5)
            case (.grey, .dark):
                return Color.sbbColor(.white).opacity(0.7)
            case (.grey, _):    // should never happen, silences a warning
                return Color.sbbColor(.iron).opacity(0.5)
            case (.white, _):
                return Color.sbbColor(.white).opacity(0.7)
            }
        }
    }
    
    private struct RectangleProperties {
        var offset: CGFloat
        var opacity: Double
    }
    
    @State private var rectangleProperties: [RectangleProperties]
    
    @Environment(\.colorScheme) var colorScheme
    
    private var style: Style
    private var width: CGFloat
    private var height: CGFloat
    private var numberOfRectangles = 4
    private var animationDuration = 0.9
    private var paddingBetweenRectangles: CGFloat = 10
    private var rotationInDegrees = 60.0
    private var innerWidth: CGFloat // the width of the entire "train" is wider than it's containing view, since it's rotated to the back around the leading y-axis
    
    /**
     Returns a SBBLoadingIndicator with the given size and style.
     
     - Parameters:
        - size: Sets the size of the SBBLoadingIndicator.
        - style: Sets the colof of the SBBLoadingIndicator.
     */
    public init(size: Size = .normal, style: Style = .red) {
        self.style = style
        self.width = size.size.width
        self.height = size.size.height
        
        let innerWidth = width / CGFloat(cos(rotationInDegrees * .pi / 180)) * 2.0
        self.innerWidth = innerWidth
        
        let rectangleProperty = RectangleProperties(offset: innerWidth / 2, opacity: 0)
        _rectangleProperties = State(initialValue: [RectangleProperties](repeating: rectangleProperty, count: numberOfRectangles))
    }
    
    public var body: some View {
        Group {
            ZStack {
                ForEach(0..<rectangleProperties.count) { index in
                    Rectangle()
                        .fill(style.color(for: colorScheme))
                        .frame(width: innerWidth / CGFloat(numberOfRectangles) - paddingBetweenRectangles / CGFloat(numberOfRectangles - 1), height: height)
                        .opacity(rectangleProperties[index].opacity)
                        .offset(x: rectangleProperties[index].offset)
                            .onAppear {
                                DispatchQueue.main.async {
                                    withAnimation(Animation.linear(duration: animationDuration)
                                                    .repeatForever(autoreverses: false)
                                                    .delay(animationDuration / Double(numberOfRectangles) * Double(index))) {
                                        rectangleProperties[index].offset = -rectangleProperties[index].offset
                                    }
                                    withAnimation(Animation.linear(duration: animationDuration / 2)
                                                    .repeatForever()
                                                    .delay(animationDuration / Double(numberOfRectangles) * Double(index))) {
                                        rectangleProperties[index].opacity = 1
                                    }
                                }
                            }
                }
            }
                .frame(width: innerWidth, height: height, alignment: .center)
                .rotation3DEffect(.degrees(rotationInDegrees), axis: (x: 0, y: 1, z: 0), anchor: .leading)
        }
            .frame(width: width, height: height, alignment: .leading)
            .padding(8)
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
                SBBLoadingIndicator(style: .white)
                    .previewDisplayName("normal, white, light")
                SBBLoadingIndicator(style: .white)
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
                SBBLoadingIndicator(size: .small, style: .white)
                    .previewDisplayName("small, white, light")
                SBBLoadingIndicator(size: .small, style: .white)
                    .previewDisplayName("small, white, dark")
                    .environment(\.colorScheme, .dark)
            }
        }
            .previewLayout(.sizeThatFits)
    }
}
