//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public struct SBBProcessFlow: View {
    
    @Binding private var currentStepIndex: Int
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
    
    public init(currentStepIndex: Binding<Int>, images: [Image]) {
        self._currentStepIndex = currentStepIndex
        self.images = images
    }
    
    public var body: some View {
        HStack {
            ForEach(0 ..< images.count, id: \.self) { i in
                images[i]
                    .resizeToContentSizeCategory(originalHeight: 24)
                    .padding(4)
                    .foregroundColor((i <= currentStepIndex) ? Color.sbbColor(.red) : Color.clear)
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
            SBBProcessFlow(currentStepIndex: .constant(1), images: images)
                .previewDisplayName("light")
            SBBProcessFlow(currentStepIndex: .constant(2), images: images)
                .previewDisplayName("dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}
