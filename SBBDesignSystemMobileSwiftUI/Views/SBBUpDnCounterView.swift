//
//  Copyright © 2023 SBB. All rights reserved.
//

import SwiftUI

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
    
    @Environment(\.colorScheme) var colorScheme
    
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
                    if let leftIcon {
                        leftIcon
                            .resizeToContentSizeCategory(originalHeight: 24)
                            .padding(.trailing, 10)
                            .accessibility(hidden: true)
                    }
                    label
                        .sbbFont(.body)
                        .padding(.vertical, 12)
                        .multilineTextAlignment(.leading)
                }
                if let subText {
                    subText
                        .sbbFont(.legend)
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
                .sbbFont(.headline)
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
        .padding(.horizontal, 16)
        .overlay(
            Group {
                if showBottomLine {
                    Rectangle()
                        .fill(Color.sbbColorInternal(.textfieldLineInactive))
                        .frame(height: 1)
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
