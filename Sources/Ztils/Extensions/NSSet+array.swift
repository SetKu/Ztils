//
//  NSSet+Array.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-08-05.
//

import Foundation

public extension NSSet {
    func array<T: Hashable>() -> Array<T> {
        Array(self as? Set ?? [])
    }
}
