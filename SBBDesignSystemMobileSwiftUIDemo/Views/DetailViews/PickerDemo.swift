//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import SwiftUI
import SBBDesignSystemMobileSwiftUI

struct PickerDemo: View {
    @Binding var colorScheme: ColorScheme
        
    @State var pickerType: PickerType = .dateTime
    @State var isBoxed: Bool = true
    @State var label: Bool = false
    @State var minuteStep: Int = 5
    @State var nbValues: Int = 10
    @State var didChange: Bool = false
    
    @State var selectedDateTime: Date = Date()
    @State var selectedDate: Date = Date()
    @State var selectedTime: Date = Date()
    @State var selectedTimeFrom: Date = Date()
    @State var selectedTimeTo: Date = Date()
    @State var selectedValue: String = "Value 4"
    
    enum PickerType: String, CaseIterable {
        case dateTime
        case date
        case time
        case timerange
        case value
    }
    
    private var demoView: some View {
        VStack(spacing: 16) {
            switch pickerType {
                case .dateTime:
                if label {
                    SBBDatePicker(selection: $selectedDateTime, pickerType: .dateTime, label: "Label")
                        .setMinuteStep(minuteStep)
                } else {
                    SBBDatePicker(selection: $selectedDateTime, pickerType: .dateTime, isBoxed: isBoxed)
                        .setMinuteStep(minuteStep)
                }
                Text("Selected date and time: ") + Text("\(selectedDateTime.format(for: .weekday)) \(selectedDateTime.format(for: .year)) \(selectedDateTime.format(for: .hour)):\(selectedDateTime.format(for: .minute))").bold()
            case .date:
                if label {
                    SBBDatePicker(selection: $selectedDate, pickerType: .date, label: "Label")
                } else {
                    SBBDatePicker(selection: $selectedDate, pickerType: .date, isBoxed: isBoxed)
                }
                Text("Selected date: ") + Text("\(selectedDate.format(for: .day)) \(selectedDate.format(for: .month)) \(selectedDate.format(for: .year))").bold()
            case .time:
                if label {
                    SBBDatePicker(selection: $selectedTime, pickerType: .time, label: "Label")
                        .setMinuteStep(minuteStep)
                } else {
                    SBBDatePicker(selection: $selectedTime, pickerType: .time, isBoxed: isBoxed)
                        .setMinuteStep(minuteStep)
                }
                Text("Selected time: ") + Text("\(selectedTime.format(for: .hour)):\(selectedTime.format(for: .minute))").bold()
            case .timerange:
                if label {
                    SBBDatePicker(fromTime: $selectedTimeFrom, toTime: $selectedTimeTo, label: "Label")
                        .setMinuteStep(minuteStep)
                } else {
                    SBBDatePicker(fromTime: $selectedTimeFrom, toTime: $selectedTimeTo, isBoxed: isBoxed)
                        .setMinuteStep(minuteStep)
                }
                Text("Selected timerange: ") + Text("\(selectedTimeFrom.format(for: .hour)):\(selectedTimeFrom.format(for: .minute)) to \(selectedTimeTo.format(for: .hour)):\(selectedTimeTo.format(for: .minute))").bold()
            case .value:
                if label {
                    SBBPicker($selectedValue, tags: (1...nbValues).map { "Value \($0)"}, label: "Label") { value in
                        Text("\(value)")
                    }
                } else {
                    SBBPicker($selectedValue, tags: (1...nbValues).map { "Value \($0)"}, isBoxed: isBoxed) { value in
                        Text("\(value)")
                    }
                }
                Text("Selected value: ") + Text("\(selectedValue)").bold()
            }
        }
    }
    
    private var settingsView: some View {
        VStack(spacing: 10) {
            SBBRadioButtonGroup(title: "Picker type", selection: $pickerType, tags: PickerType.allCases) {
                SBBRadioButton(text: Text("Date and time"))
                    .tag(PickerType.dateTime)
                SBBRadioButton(text: Text("Date"))
                    .tag(PickerType.date)
                SBBRadioButton(text: Text("Time"))
                    .tag(PickerType.time)
                SBBRadioButton(text: Text("Time range"))
                    .tag(PickerType.timerange)
                SBBRadioButton(text: Text("Value"), showBottomLine: false)
                    .tag(PickerType.value)
            }
            
            SBBFormGroup(title: "Options") {
                Toggle(isOn: $isBoxed) {
                    Text("Is boxed")
                }
                .toggleStyle(SBBSwitchStyle())
                .padding(8)
                
                if !isBoxed {
                    Toggle(isOn: $label) {
                        Text("Label")
                    }
                    .toggleStyle(SBBSwitchStyle())
                    .padding(8)
                }
            }
            
            if [PickerType.dateTime, PickerType.time, PickerType.timerange].contains(pickerType) {
                SBBRadioButtonGroup(title: "Step for the minutes", selection: $minuteStep, tags: [1, 5, 10]) {
                    SBBRadioButton(text: Text("1 minute"))
                        .tag(1)
                    SBBRadioButton(text: Text("5 minutes"))
                        .tag(5)
                    SBBRadioButton(text: Text("10 minutes"), showBottomLine: false)
                        .tag(10)
                }
            }
            
            if pickerType == .value {
                SBBFormGroup(title: "Number of values") {
                    Stepper(value: $nbValues, in: 1...20, label: { Text("\(nbValues)") })
                        .sbbFont(.body)
                        .padding(10)
                }
            }
        }
    }
    
    var body: some View {
        Group {
            // WORKAROUND: otherwise change does not immediately propagate
            if didChange {
                DemoWithModalSettingsView(colorScheme: $colorScheme, demoTitle: "Picker", demoView: demoView, settingsView: settingsView, onClose: { didChange.toggle() })
            } else {
                DemoWithModalSettingsView(colorScheme: $colorScheme, demoTitle: "Picker", demoView: demoView, settingsView: settingsView, onClose: { didChange.toggle() })
            }
        }
        .onChange(of: isBoxed) { value in
            if value {
                self.label = false
            }
        }
    }
}
