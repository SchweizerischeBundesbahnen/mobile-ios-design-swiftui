//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2024.
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
    SBBStepper()
 }
 ```
 ![SBBStepper](SBBStepper)
 */
public struct SBBStepper: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var spacerWidth: CGFloat = .zero
    @State private var labelWidth: CGFloat = .zero
    
    private var currentStepIndex: Int = 1
    private let numberOfSteps: Int
    private let images: [Image]?
    private let labels: [String]?
    
    private var borderColor: Color {
        return (colorScheme == .light) ? Color.sbbColor(.black) : Color.sbbColor(.white)
    }
    private var selectedBorderColor: Color {
        return (colorScheme == .light) ? Color.sbbColor(.primary) : Color.sbbColor(.white)
    }
    private var iconColor: Color {
        return (colorScheme == .light) ? Color.sbbColor(.black) : Color.sbbColor(.white)
    }
    private var selectedIconColor: Color {
        return (colorScheme == .light) ? Color.sbbColor(.white) : Color.sbbColor(.black)
    }
    private var lineColor: Color {
        return (colorScheme == .light) ? Color.sbbColor(.black).opacity(0.3) : Color.sbbColor(.white).opacity(0.7)
    }
    private var backgroundColor: Color {
        return (colorScheme == .light) ? Color.sbbColor(.white) : Color.sbbColor(.charcoal)
    }
    private var selectedBackgroundColor: Color {
        return (colorScheme == .light) ? Color.sbbColor(.primary) : Color.sbbColor(.white)
    }
    private var stepSize: CGFloat {
        return UIFontMetrics.default.scaledValue(for: 32)
    }
    private var tickSize: CGFloat {
        return UIFontMetrics.default.scaledValue(for: 12)
    }
    
    /**
     Returns a SBBStepper displaying a flow of multiple steps by using icons. Highlights, the current step. You can add as many steps/images as you like, but need to make sure, there's enough space (width) for them to be displayed correctly.
     
     - Parameters:
        - currentStepIndex: The index of the current step's state. First step corresponds to "0".
        - numberOfSteps: The number of steps, must be between 3 and 6.
        - images: optional array of images containing a single image for every step (typically in size .small, images in other sizes will get resized if needed). If no images are provided, numbers are used for the steps.
        - labels: optional array of strings, used as label when the step is selected.
     */
    public init?(currentStepIndex: Int, numberOfSteps: Int, images: [Image]? = nil, labels: [String]? = nil) {
        guard 3...6 ~= numberOfSteps else {
            return nil
        }
        self.currentStepIndex = max(min(currentStepIndex, numberOfSteps), 0)
        self.numberOfSteps = numberOfSteps
        self.images = images
        self.labels = labels
    }
    
    private func stepView(index: Int) -> some View {
        Group {
            if let images, images.count > index {
                images[index]
                    .resizeToContentSizeCategory(originalHeight: 24)
            } else {
                Text("\(index + 1)")
                    .sbbFont(.medium_light)
            }
        }
            .padding(4)
            .foregroundColor((index == currentStepIndex) ? selectedIconColor : iconColor)
            .background((index == currentStepIndex) ? selectedBackgroundColor : backgroundColor)
            .cornerRadius(stepSize / 2)
            .background(
                RoundedRectangle(cornerRadius: stepSize / 2)
                    .stroke((index == currentStepIndex) ? selectedBorderColor : borderColor, lineWidth: 1)
            )
            .frame(width: stepSize, height: stepSize)
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .center, spacing: 4) {
                ForEach(0 ..< numberOfSteps, id: \.self) { index in
                    if index < currentStepIndex {
                        stepView(index: index)
                            .overlay(Circle()
                                .frame(width: tickSize, height: tickSize)
                                .overlay(Image(sbbIcon: .tick_small)
                                    .resizeToContentSizeCategory(originalHeight: 11)
                                    .foregroundColor(Color.sbbColor(.white))
                                    .font(.small_bold)
                                )
                                    .offset(x: 13, y: -13)
                                    .foregroundColor(Color.sbbColor(.primary)))
                    } else {
                        stepView(index: index)
                    }
                    
                    if index < numberOfSteps - 1 {
                        Rectangle()
                            .fill(lineColor)
                            .frame(height: 1)
                            .viewWidth($spacerWidth)
                    }
                }
            }
            
            GeometryReader { geometry in
                if let labels, labels.count > currentStepIndex {
                    Text(labels[currentStepIndex])
                        .sbbFont(.medium_light)
                        .viewWidth($labelWidth)
                        .offset(x: calculateOffset(geometry: geometry))
                }
            }
        }
            .accessibilityElement(children: .ignore)
            .accessibility(label: Text("\(labels != nil && labels!.count > currentStepIndex ? "\(labels![currentStepIndex]), " : "")\(String.localizedStringWithFormat(NSLocalizedString("Step %lld out of %lld", tableName: nil, bundle: Helper.bundle, value: "", comment: ""), currentStepIndex + 1, numberOfSteps))"))
    }
    
    private func calculateOffset(geometry: GeometryProxy) -> CGFloat {
        let index: CGFloat = CGFloat(currentStepIndex)
        let stepWidth: CGFloat = stepSize + 4 + spacerWidth + 4
        let offsetForStep: CGFloat = stepSize / 2 - labelWidth / 2
        let maxOffset: CGFloat = geometry.size.width - labelWidth - 4
        return min(max(0, index * stepWidth + offsetForStep), maxOffset)
    }
}
