//
//  Copyright © 2023 SBB. All rights reserved.
//

import SwiftUI

/**
 A View that is used to display a SBB DSM stepper, usually inside a ``SBBFormGroup``.
 
 ## Overview
 You create a SBBUpDnCounter by providing a Label. Optionally you can also provide a icon on the left side and / or a subtext.
 ```swift
 @State var counter = 0
 var body: some View {
     SBBFormGroup(title: "Title") {
         SBBUpDnCounterView(label: Text("Label"), value: $counter)
     }
 }
 ```
 ![SBBUpDnCounter](SBBUpDnCounter)
 */
public struct SBBUpDnCounterView: View {
    
    private let leftIcon: Image?
    private let label: Text
    private let subText: Text?
    @Binding private var value: Int
    private let showBottomLine: Bool
    
    private var minValue: Int?
    private var maxValue: Int?
    
    private let incrementAction: (() -> Void)?
    private let decrementAction: (() -> Void)?
    
    @Environment(\.sizeCategory) var sizeCategory
    @Environment(\.colorScheme) var colorScheme
    
    /**
     Returns a UpDnCounter with a label, an optional image and an optional footnote. The Binding value will be increased / decreased. There is also an optional range parameter
     
     - Parameters:
     - leftIcon: an optional image to show on the leading edge the the UpDnCounter
     - label: Sets the main label.
     - subtext: An optional Text displayed underneath the main label
     - value: a Binding that will be increased / decreased by the stepper
     - range: a ClosedRange to limit the stepper value
     - showBottomLine: Shows or hides a separator line at the bottom of the View (typically only false for last elements in a List).
     */
    public init(leftIcon: Image? = nil, label: Text, subtext: Text? = nil, value: Binding<Int>, range: ClosedRange<Int>? = nil, showBottomLine: Bool = true) {
        self.leftIcon = leftIcon
        self.label = label
        self.subText = subtext
        _value = value
        
        self.minValue = range?.lowerBound
        self.maxValue = range?.upperBound
        self.incrementAction = nil
        self.decrementAction = nil
        self.showBottomLine = showBottomLine
    }
    
    /**
     Returns a UpDnCounter with a label, an optional image and an optional footnote. There is also an optional range parameter. There are manual action function paramenter to increase / decrease.
     
     - Parameters:
     - leftIcon: an optional image to show on the leading edge the the UpDnCounter
     - label: Sets the main label.
     - subtext: An optional Text displayed underneath the main label
     - displayValue: The value that will be displayed
     - range: a ClosedRange to limit the stepper value
     - showBottomLine: Shows or hides a separator line at the bottom of the View (typically only false for last elements in a List).
     - incrementAction: The action to perform then pressing the `+` of the stepper
     - decrementAction: The action to perform when pressing the `-`of the stepper
     */
    public init(leftIcon: Image? = nil, label: Text, subtext: Text? = nil, displayValue: Int, range: ClosedRange<Int>? = nil, showBottomLine: Bool = true, incrementAction: @escaping () -> Void, decrementAction: @escaping () -> Void) {
        self.leftIcon = leftIcon
        self.label = label
        self.subText = subtext
        _value = .constant(displayValue)
        
        self.minValue = range?.lowerBound
        self.maxValue = range?.upperBound
        self.incrementAction = incrementAction
        self.decrementAction = decrementAction
        self.showBottomLine = showBottomLine
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 1) {
                HStack(spacing: 0) {
                    if !sizeCategory.isAccessibilityCategory, let leftImage = leftIcon {
                        leftImage
                            .resizeToContentSizeCategory(originalHeight: 24)
                            .padding(.trailing, 10)
                            .accessibility(hidden: true)
                    }
                    label
                        .sbbFont(.medium_light)
                        .padding(.vertical, 12)
                        .multilineTextAlignment(.leading)
                }
                if let subText {
                    subText
                        .sbbFont(.small_light)
                        .padding(.bottom, 12)
                        .foregroundColor(.sbbColor(colorScheme == .dark ? .cement : .granite))
                        .multilineTextAlignment(.leading)
                }
            }
            Spacer()
            Button {
                decrementValueIfPossible()
            } label: {
                minusView
                    .accessibilityLabel(hasReachedMinValue ? Text("\(label) has reached minimum of \(minValue ?? 0)") : Text("Decrement \(label) to \(value - 1)"))
            }
            .contentShape(Rectangle().inset(by: -10))
            .disabled(hasReachedMinValue)
            .padding(.leading, 8)
            Text("\(value)")
                .sbbFont(.large_bold)
                .frame(minWidth: 40)
                .accessibilityLabel(Text("\(label) has value \(value)"))
                .padding(.horizontal, 4)
            Button {
                incrementValueIfPossible()
            } label: {
                plusView
                    .accessibilityLabel(hasReachedMaxValue ? Text("\(label) has reached maximum of \(maxValue ?? 0)") : Text("Increment \(label) to \(value + 1)"))
            }
            .contentShape(Rectangle().inset(by: -10))
            .disabled(hasReachedMaxValue)
        }
        .frame(minHeight: 44)
        .padding(.horizontal, 16)
        .foregroundColor(.sbbColor(.textBlack))
        .background(Color.sbbColor(.viewBackground))
        .overlay(
            Group {
                if showBottomLine {
                    SBBDivider()
                } else {
                    EmptyView()
                }
            }
                 , alignment: .bottom)
    }
    
    private func incrementValueIfPossible() {
        if let maxValue {
            if value < maxValue {
                value = value + 1
                incrementAction?()
            }
        } else {
            value = value + 1
            incrementAction?()
        }
    }
    
    private var plusView: some View {
        Rectangle()
            .frame(width: 10, height: 30)
            .foregroundColor(.clear)
            .overlay (
                Rectangle()
                    .frame(width: 2, height: 10)
            )
            .overlay (
                Rectangle()
                    .frame(width: 10, height: 2)
            )
            .foregroundColor(hasReachedMaxValue ? reachedMinMaxColour : .red)
    }
    
    private func decrementValueIfPossible() {
        if let minValue {
            if minValue < value {
                value = value - 1
                decrementAction?()
            }
        } else {
            value = value - 1
            decrementAction?()
        }
    }
    
    private var minusView: some View {
        Rectangle()
            .frame(width: 10, height: 30)
            .foregroundColor(.clear)
            .overlay (
                Rectangle()
                    .frame(width: 10, height: 2)
            )
            .foregroundColor(hasReachedMinValue ? reachedMinMaxColour : .red)
    }
    
    private var hasReachedMinValue: Bool {
        guard let minValue else {
            return false
        }
        return value <= minValue
    }
    
    private var hasReachedMaxValue: Bool {
        guard let maxValue else {
            return false
        }
        return value >= maxValue
    }
    
    private var reachedMinMaxColour: Color {
        colorScheme == .dark ? .sbbColor(.granite) : .sbbColor(.graphite)
    }
}

struct SBBUpDnCounterView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SBBUpDnCounterView(label: Text("Gleisüberschreitung"), value: .constant(0))
            SBBUpDnCounterView(label: Text("Gleisüberschreitung"), subtext: Text("Ein sehr langer Text der auf meherern Zeilen geschrieben werden sollte"), value: .constant(5))
            SBBUpDnCounterView(leftIcon: Image(sbbIcon: .train_tracks_small), label: Text("Gleisüberschreitung"), value: .constant(10))
            SBBUpDnCounterView(leftIcon: Image(sbbIcon: .train_tracks_small), label: Text("Gleisüberschreitung"), value: .constant(77777))
            
            SBBUpDnCounterView(label: Text("Gleisüberschreitung"), subtext: Text("Ein subtext"), displayValue: 5, incrementAction: {}, decrementAction: {})
            SBBUpDnCounterView(leftIcon: Image(sbbIcon: .train_tracks_small), label: Text("Gleisüberschreitung"), displayValue: 5, incrementAction: {}, decrementAction: {})
        }
    }
}
