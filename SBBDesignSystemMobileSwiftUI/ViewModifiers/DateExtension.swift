//
// Copyright (C) Schweizerische Bundesbahnen SBB, 2023.
//

import Foundation


/**
 Used for ``SBBDatePicker`` to format the date.
 */
public extension Date {
    func format(for component: Calendar.Component) -> String {
        let dateFormatter = DateFormatter()
        switch component {
        case .year:
            return "\(Calendar.current.component(component, from: self))"
        case .month:
            dateFormatter.dateFormat = "MMMM"
            return dateFormatter.string(from: self).capitalized
        case .day:
            dateFormatter.dateFormat = "dd"
            return "\(dateFormatter.string(from: self))\(Locale.current.identifier.contains("de") ? "." : "")"
        case .weekday:
            dateFormatter.dateFormat = Locale.current.identifier.contains("de") ? "E dd. MMM" : "E dd MMM"
            return dateFormatter.string(from: self)
        case .hour, .minute:
            let elm = "\(Calendar.current.component(component, from: self))"
            return elm.count == 2 ? elm : "0\(elm)"
        default:
            return self.description
        }
    }
    
    func add(_ value: Int, for component: Calendar.Component) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self)!
    }
    
    func getRange(_ range: Int, _ step: Int, for component: Calendar.Component) -> [Date] {
        return (-range...range).map { self.add($0 * step, for: component) }
    }
    
    func roundMinuteTo(_ step: Int) -> Date {
        var dateComponents = DateComponents()
        let currentMinute = Calendar.current.component(.minute, from: self)
        let currentMod10 = currentMinute % (step * 2)
        dateComponents.minute = currentMod10 <= step ? currentMinute - currentMod10 + step : currentMinute - currentMod10 + (step * 2)
        return Calendar.current.date(from: dateComponents)!
    }
}
