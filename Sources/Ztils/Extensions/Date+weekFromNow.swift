//
//  Date+weekFromNow.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-07.
//

import Foundation

public extension Date {
    static var weekFromNow: Date { Date().addingTimeInterval(7 * 24 * 60 * 60) }
}
