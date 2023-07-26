//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import SwiftUI


/**
 A View that takes a picker and wraps it into a box / adds a label to it. Used for ``SBBPicker`` and ``SBBDatePicker``.
 */
struct SBBPickerWrapper<Picker: View>: View {
    let pickerView: Picker
    let nbValues: Int
    let label: String?
    let isBoxed: Bool
    
    init(pickerView: Picker, nbValues: Int = 7, label: String?, isBoxed: Bool) {
        self.pickerView = pickerView
        self.nbValues = nbValues
        self.label = label
        self.isBoxed = isBoxed
    }
    
    public var body: some View {
        Group {
            VStack(alignment: .leading) {
                if let label = label {
                    Text(label)
                        .font(.custom("SBBWeb-Light", fixedSize: 12))
                }
                if isBoxed {
                    pickerView
                        .frame(height: SBBPickerValues.getHeight(nbValues), alignment: .center)
                        .background(Color.sbbColor(.viewBackground))
                        .cornerRadius(16)
                } else {
                    VStack(spacing: 0) {
                        pickerView
                        SBBDivider()
                    }
                    .frame(height: SBBPickerValues.datePickerHeight, alignment: .center)
                }
            }
        }
            .sbbScreenPadding()
    }
}


extension View {
    /**
     Adds the 'selected' rectangle to the picker.
     */
    func addSelectedView(nbValues: Int = 7) -> some View {
        ZStack {
            VStack {
                RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                    .padding(.horizontal, 8)
                    .frame(height: SBBPickerValues.valuesHeight, alignment: .center)
                    .foregroundColor(Color.sbbColorInternal(.pickerSelectedSegmentBackground))
            }
            .frame(height: SBBPickerValues.getHeight(nbValues), alignment: .center)
            self
        }
    }
}
