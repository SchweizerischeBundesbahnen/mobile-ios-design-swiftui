//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

/// A  View that allows visual separation of a multi-step processes or forms. Highlights, the current step.
/**
 A  View that allows visual separation of a multi-step processes or forms. Highlights, the current step.
 
 ## Overview
 You create a SBBProcessFlow  by providing a set of Images (one per step) and the current index:
 ```swift
 var currentIndex = 1

 var body: some View {
    SBBProcessFlow(currentStepIndex: currentIndex, images: [Image(sbbName: "face-worker", size: .small), Image(sbbName: "piggy-bank", size: .small), Image(sbbName: "heart", size: .small)])
 }
 ```
 ![SBBProcessFlow](SBBProcessFlow)
 */
public struct SBBProcessFlow: View {
    
    private var currentStepIndex: Int
    private let images: [Image]
    private var height: CGFloat {
        return UIFontMetrics.default.scaledValue(for: 32)
    }
    private var borderColor: Color {
        return (colorScheme == .light) ? Color.sbbColor(.cloud) : Color.sbbColor(.smoke)
    }
    private var backgroundColor: Color {
        return (colorScheme == .light) ? Color.sbbColor(.white) : Color.sbbColor(.black)
    }
    
    @Environment(\.colorScheme) private var colorScheme
    
    /**
     Returns a SBBProcessFlow displaying a flow of multiple steps by using icons. Highlights, the current step. You can add as many steps/images as you like, but need to make sure, there's enough space (width) for them to be displayed correctly.
     
     - Parameters:
        - currentStepIndex: The index of the current step's state. First step corresponds to "0".
        - images: Array of images containing a single image for every step (typically in size .small, images in other sizes will get resized if needed).
     */
    public init(currentStepIndex: Int, images: [Image]) {
        self.currentStepIndex = currentStepIndex
        self.images = images
    }
    
    public var body: some View {
        HStack {
            ForEach(0 ..< images.count, id: \.self) { i in
                images[i]
                    .resizeToContentSizeCategory(originalHeight: 24)
                    .padding(4)
                    .foregroundColor((i <= currentStepIndex) ? Color.sbbColor(.primary) : Color.clear)
                    .background(backgroundColor)
                    .cornerRadius(height / 2)
                    .background(
                        RoundedRectangle(cornerRadius: height / 2)
                            .stroke(borderColor, lineWidth: 1)
                    )
                if i < images.count - 1 {
                    Spacer()
                }
            }
        }
            .background(
                Rectangle()
                    .fill(borderColor)
                    .frame(height: 1)
            )
            .accessibilityElement(children: .ignore)
            .accessibility(label: Text(String.localizedStringWithFormat(NSLocalizedString("Step %lld out of %lld", tableName: nil, bundle: Helper.bundle, value: "", comment: ""), currentStepIndex + 1, images.count)))
    }
}

struct SBBProcessFlow_Previews: PreviewProvider {
    
    static let images = [Image(sbbName: "lock-closed", size: .small), Image(sbbName: "lock-open", size: .small), Image(sbbName: "tick", size: .small)]
    
    static var previews: some View {
        Group {
            SBBProcessFlow(currentStepIndex: 1, images: images)
                .previewDisplayName("light")
            SBBProcessFlow(currentStepIndex: 2, images: images)
                .previewDisplayName("dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}
