//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2021.
//

import SwiftUI

public struct SBBChip: View {
    
    @Binding private var isSelected: Bool
    private var label: Text
    private var numberOfItems: Int
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var backgroundColor: Color {
        switch (isSelected, colorScheme) {
        case (false, _):
            return Color.sbbColor(.red)
        case (true, .light):
            return Color.sbbColor(.milk)
        case (true, .dark):
            return Color.sbbColor(.iron)
        default:
            return Color.yellow
        }
    }

    public init(label: Text, isSelected: Binding<Bool>, numberOfItems: Int) {
        self.label = label
        self._isSelected = isSelected
        self.numberOfItems = numberOfItems
    }
    
    public var body: some View {
        Button(action: { isSelected.toggle() }) {
            HStack(spacing: 12) {
                label
                    .sbbFont(.body)
                Group {
                    if isSelected {
                        Image(sbbName: "cross", size: .small)
                    } else {
                        Text("\(numberOfItems)")
                            .foregroundColor(Color.sbbColor(.white))
                            .sbbFont(.subtitle)
                            .accessibility(label: Text("\(numberOfItems) \("entries".localized)"))
                    }
                }
                    .frame(width: 26, height: 26)
                    .background(backgroundColor)
                    .cornerRadius(13)
            }
                .padding(.leading, 9)
        }
            .buttonStyle(SBBTertiaryButtonStyle(size: .small, horizontalPadding: 3))
        .accessibility(hint: Text("list filter".localized))
        .accessibility(value: Text(isSelected ? "active".localized : "not active".localized))
    }
}

struct SBBChip_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBChip(label: Text("Label"), isSelected: .constant(true), numberOfItems: 99)
                .previewDisplayName("Enabled, Selected, light")
            SBBChip(label: Text("Label"), isSelected: .constant(true), numberOfItems: 99)
                .previewDisplayName("Enabled, Selected, dark")
                .environment(\.colorScheme, .dark)
            SBBChip(label: Text("Label"), isSelected: .constant(true), numberOfItems: 99)
                .disabled(true)
                .previewDisplayName("Disabled, Selected, light")
            SBBChip(label: Text("Label"), isSelected: .constant(true), numberOfItems: 99)
                .disabled(true)
                .previewDisplayName("Disabled, Selected, dark")
                .environment(\.colorScheme, .dark)
            SBBChip(label: Text("Label"), isSelected: .constant(false), numberOfItems: 99)
                .previewDisplayName("Enabled, UnSelected, light")
            SBBChip(label: Text("Label"), isSelected: .constant(false), numberOfItems: 99)
                .previewDisplayName("Enabled, Unselected, dark")
                .environment(\.colorScheme, .dark)
            SBBChip(label: Text("Label"), isSelected: .constant(false), numberOfItems: 99)
                .disabled(true)
                .previewDisplayName("Disabled, UnSelected, light")
            SBBChip(label: Text("Label"), isSelected: .constant(false), numberOfItems: 99)
                .disabled(true)
                .previewDisplayName("Disabled, Unselected, dark")
                .environment(\.colorScheme, .dark)
        }
            .previewLayout(.sizeThatFits)
    }
}