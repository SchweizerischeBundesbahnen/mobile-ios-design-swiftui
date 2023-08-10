//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import SwiftUI
import Combine


/**
 A  View that is used to display a date picker.
 
 ## Overview
 You create a SBBDatePicker by providing a Date binding and choosing a type of picker. The options are: dateTime for both a date and a time, date for the date only and time for the time only.
 You can choose whether the SBBDatePicker is boxed (e.g. background + rounded corner) or not. You can specify a label, in which case the SBBDatePicker will not be boxed.
 Additionally, the modifier .setMinuteStep() allows you to decides the step that is used for the minutes (5 minutes, 10 minutes, ...).
 
 ```swift
 @State private var selectedDateTime = Date()
 
 var body: some View {
    VStack {
         SBBDatePicker(selection: $selectedDateTime, pickerType: .dateTime, isBoxed: true)
             .setMinuteStep(minuteStep)
     
         SBBDatePicker(selection: $selectedDateTime, pickerType: .dateTime, label: "Label")
             .setMinuteStep(minuteStep)
    }
 }
 ```
 
 ![SBBDatePicker](SBBDatePicker)
 
You can also create a SBBDatePicker for a time range. You do that by providing two Date bindings.
 
 ```swift
 @State private var selectedFromTime = Date()
 @State private var selectedToTime = Date()
 
 var body: some View {
    VStack {
         SBBDatePicker(fromTime: $selectedToTime, toTime: $selectedToTime, isBoxed: true)
             .setMinuteStep(minuteStep)
     
         SBBDatePicker(fromTime: $selectedToTime, toTime: $selectedToTime, label: "Label")
             .setMinuteStep(minuteStep)
    }
 }
 ```

 ![SBBDatePickerTimerange](SBBDatePickerTimerange)
 */
public struct SBBDatePicker: View {
    @Binding private var selection: Date
    @Binding private var selection2: Date
    
    // Maximum of 4 different elements, each element should be independent: changing month should not change year.
    @State private var date1: Date // date, day, hour
    @State private var date2: Date // hour, month, minute
    @State private var date3: Date // minute, year, hour
    @State private var date4: Date // minute
    
    public enum PickerType: CaseIterable {
        /// Date and time (date, hour, minute)
        case dateTime
        /// Date only (day, month, year)
        case date
        /// Time only (hour, minute)
        case time
    }
    
    private let label: String?
    private let pickerType: PickerType?
    private let isBoxed: Bool
    private var minuteStep: Int = 1
        
    /**
     Returns a SBBDatePicker.
     
     - Parameters:
        - selection: The currently selected date.
        - pickerType: The type of picker.
        - isBoxed: Whether the picker is boxed (background + rounded corner).
     */
    public init(selection: Binding<Date>, pickerType: PickerType, isBoxed: Bool = true) {
        self.init(selection: selection, selection2: nil, pickerType: pickerType, isBoxed: isBoxed, label: nil)
    }
    
    /**
     Returns a SBBDatePicker without background.
     
     - Parameters:
        - selection: The currently selected date.
        - pickerType: The type of picker.
        - label: The label displayed on top.
     */
    public init(selection: Binding<Date>, pickerType: PickerType, label: String) {
        self.init(selection: selection, selection2: nil, pickerType: pickerType, isBoxed: false, label: label)
    }
    
    /**
     Returns a SBBDatePicker with time range: two pickers that allow to select two different times.
     
     - Parameters:
        - fromTime: The currently selected 'from' date.
        - toTime: The currently selected 'to' date.
        - isBoxed: Whether the picker is boxed (background + rounded corner).
     */
    public init(fromTime: Binding<Date>, toTime: Binding<Date>, isBoxed: Bool = true) {
        self.init(selection: fromTime, selection2: toTime, pickerType: nil, isBoxed: isBoxed, label: nil)
    }
    
    /**
     Returns a SBBDatePicker with time range without background: two pickers that allow to select two different times.
     
     - Parameters:
        - fromTime: The currently selected 'from' date.
        - toTime: The currently selected 'to' date.
        - label: The label displayed on top.
     */
    public init(fromTime: Binding<Date>, toTime: Binding<Date>, label: String) {
        self.init(selection: fromTime, selection2: toTime, pickerType: nil, isBoxed: false, label: label)
    }
    
    private init(selection: Binding<Date>, selection2: Binding<Date>?, pickerType: PickerType?, isBoxed: Bool, label: String?) {
        self._selection = selection
        self._selection2 = selection2 ?? .constant(Date())
        self.pickerType = pickerType
        self.isBoxed = isBoxed
        self.label = label
        
        self._date1 = State(initialValue: selection.wrappedValue)
        self._date2 = State(initialValue: selection.wrappedValue)
        self._date3 = selection2 == nil ? State(initialValue: selection.wrappedValue) : State(initialValue: selection2!.wrappedValue)
        self._date4 = selection2 == nil ? State(initialValue: selection.wrappedValue) : State(initialValue: selection2!.wrappedValue)
    }
    
    private var dateTimeView: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                HStack(alignment: .center) {
                    Spacer()
                    SBBDatePickerHelper(selection: $date1, component: .weekday, step: 1, alignment: .trailing)
                    Spacer()
                }
                    .frame(width: geometry.size.width / 2)
                HStack(alignment: .center, spacing: 32) {
                    Spacer()
                    SBBDatePickerHelper(selection: $date2, component: .hour, step: 1, alignment: .center)
                    SBBDatePickerHelper(selection: $date3, component: .minute, step: minuteStep, alignment: .center)
                    Spacer()
                }
                    .frame(width: geometry.size.width / 2)
            }
            .addSelectedView()
            .onChange(of: [date1, date2, date3]) { value in
                var dateComponents = DateComponents()
                dateComponents.year = Calendar.current.component(.year, from: date1)
                dateComponents.month = Calendar.current.component(.month, from: date1)
                dateComponents.day = Calendar.current.component(.day, from: date1)
                
                dateComponents.hour = Calendar.current.component(.hour, from: date2)
                dateComponents.minute = Calendar.current.component(.minute, from: date3)
                self.selection = Calendar.current.date(from: dateComponents)!
            }
        }
    }
    
    private var dateView: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                SBBDatePickerHelper(selection: $date1, component: .day, step: 1, alignment: .trailing, trailingPadding: 32)
                .frame(width: geometry.size.width / 4)
                SBBDatePickerHelper(selection: $date2, component: .month, step: 1, alignment: .leading)
                .frame(width: geometry.size.width / 3)
                HStack(alignment: .center) {
                    Spacer()
                    SBBDatePickerHelper(selection: $date3, component: .year, step: 1, alignment: .trailing, trailingPadding: 32)
                    Spacer()
                }
                .frame(width: geometry.size.width / 3)
            }
            .addSelectedView()
            .onChange(of: [date1, date2, date3]) { value in
                var dateComponents = DateComponents()
                dateComponents.day = Calendar.current.component(.day, from: date1)
                dateComponents.month = Calendar.current.component(.month, from: date2)
                dateComponents.year = Calendar.current.component(.year, from: date3)
                self.selection = Calendar.current.date(from: dateComponents)!
            }
        }
    }
    
    private var timeView: some View {
        HStack(spacing: 32) {
            SBBDatePickerHelper(selection: $date1, component: .hour, step: minuteStep, alignment: .trailing, trailingPadding: 16)
            SBBDatePickerHelper(selection: $date2, component: .minute, step: minuteStep, alignment: .leading, leadingPadding: 16)
        }
        .addSelectedView()
        .onChange(of: [date1, date2]) { value in
            var dateComponents = DateComponents()
            dateComponents.hour = Calendar.current.component(.hour, from: date1)
            dateComponents.minute = Calendar.current.component(.minute, from: date2)
            self.selection = Calendar.current.date(from: dateComponents)!
        }
    }
    
    private var timeRangeView: some View {
        HStack(spacing: 0) {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    SBBDatePickerHelper(selection: $date1, component: .hour, step: 1, alignment: .center, leadingPadding: 8)
                    .frame(width: geometry.size.width / 2)
                    SBBDatePickerHelper(selection: $date2, component: .minute, step: minuteStep, alignment: .center, trailingPadding: 8)
                    .frame(width: geometry.size.width / 2)
                }
                .addSelectedView()
                .onChange(of: [date1, date2]) { value in
                    var dateComponents = DateComponents()
                    dateComponents.hour = Calendar.current.component(.hour, from: date1)
                    dateComponents.minute = Calendar.current.component(.minute, from: date2)
                    self.selection = Calendar.current.date(from: dateComponents)!
                }
            }
            VStack {
                Rectangle()
                    .fill(Color.sbbColor(.divider))
                    .frame(width: 1)
                Text("und".localized)
                Rectangle()
                    .fill(Color.sbbColor(.divider))
                    .frame(width: 1)
            }
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    SBBDatePickerHelper(selection: $date3, component: .hour, step: 1, alignment: .center, leadingPadding: 8)
                    .frame(width: geometry.size.width / 2)
                    SBBDatePickerHelper(selection: $date4, component: .minute, step: minuteStep, alignment: .center, trailingPadding: 8)
                    .frame(width: geometry.size.width / 2)
                }
                .addSelectedView()
                .onChange(of: [date3, date4]) { value in
                    var dateComponents = DateComponents()
                    dateComponents.hour = Calendar.current.component(.hour, from: date3)
                    dateComponents.minute = Calendar.current.component(.minute, from: date4)
                    self.selection2 = Calendar.current.date(from: dateComponents)!
                }
            }
        }
    }
    
    public func setMinuteStep(_ minuteStep: Int) -> Self {
        var newSelf = self
        newSelf.minuteStep = minuteStep
        return newSelf
    }
    
    public var body: some View {
        SBBPickerWrapper(pickerView: Group {
            if let pickerType = pickerType {
                switch pickerType {
                case .dateTime:
                    dateTimeView
                case .date:
                    dateView
                case .time:
                    timeView
                }
            } else {
                timeRangeView
            }
        }, label: label, isBoxed: isBoxed)
    }
}

struct SBBDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SBBDatePicker(selection: .constant(Date()), pickerType: .dateTime)
                .previewDisplayName("Date time")
            SBBDatePicker(selection: .constant(Date()), pickerType: .date)
                .previewDisplayName("Date")
            SBBDatePicker(selection: .constant(Date()), pickerType: .time)
                .previewDisplayName("Time")
            SBBDatePicker(fromTime: .constant(Date()), toTime: .constant(Date()))
                .previewDisplayName("Date")
        }
        .previewLayout(.sizeThatFits)
    }
}
