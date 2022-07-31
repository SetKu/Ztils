//
//  Date+Extensions.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-07.
//

import Foundation

public extension Date {
    static var weekFromNow: Date { Date().addingTimeInterval(7 * 24 * 60 * 60) }
    
    var weekdayNumber: Int {
        Calendar.current.component(.weekday, from: self)
    }

    func weekday(abbreviated: Bool = false) -> String {
        return self.formatted(by: abbreviated ? "EEE" : "EEEE")
    }
    
    func component(_ component: Calendar.Component) -> Int {
        Calendar.current.component(component, from: self)
    }
    
    func formatted(by string: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = string
        return formatter.string(from: self)
    }
}
