//
//  ZTColorComponents.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-08-01.
//

import Foundation

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

public struct ZTColorComponents: Codable {
    public var r: CGFloat
    public var g: CGFloat
    public var b: CGFloat
    public var a: CGFloat
    
    public init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }
    
    #if canImport(UIKit)
    public init(_ uiColor: UIColor) {
        r = 0
        g = 0
        b = 0
        a = 0
        
        uiColor.getRed(
            &r,
            green: &g,
            blue: &b,
            alpha: &a
        )
    }
    
    public func formUIColor() -> UIColor {
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    #endif
    
    #if canImport(AppKit)
    public init(_ uiColor: NSColor) {
        r = 0
        g = 0
        b = 0
        a = 0
        
        uiColor.getRed(
            &r,
            green: &g,
            blue: &b,
            alpha: &a
        )
    }
    
    public func formNSColor() -> NSColor {
        return NSColor(red: r, green: g, blue: b, alpha: a)
    }
    #endif
}
