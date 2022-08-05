//
//  ZTStorage.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-08-04.
//

import Foundation
import SwiftUI

@propertyWrapper
public struct ZTStorage<T: Codable> {
    private let defaultValue: T
    private let key: String
    private let suiteName: String?
    
    public var wrappedValue: T {
        get {
            if let suiteName = suiteName {
                if let data = UserDefaults(suiteName: suiteName)?.data(forKey: key) {
                    if let decoded = try? JSONDecoder().decode(T.self, from: data) {
                        return decoded
                    }
                }
            }
            
            if let data = UserDefaults.standard.data(forKey: key) {
                if let decoded = try? JSONDecoder().decode(T.self, from: data) {
                    return decoded
                }
            }
            
            return defaultValue
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                if let suiteName = suiteName {
                    UserDefaults(suiteName: suiteName)?.set(data, forKey: key)
                    return
                }
                
                UserDefaults.standard.set(data, forKey: key)
            }
        }
    }
    
    public init(_ key: String, defaultValue: T, suiteName: String? = nil) {
        self.key = key
        self.defaultValue = defaultValue
        self.suiteName = suiteName
    }
}
