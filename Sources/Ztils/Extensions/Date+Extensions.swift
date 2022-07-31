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
        let formatter = DateFormatter()
        formatter.dateFormat = abbreviated ? "EEE" : "EEEE"
        return formatter.string(from: self)
    }
}
