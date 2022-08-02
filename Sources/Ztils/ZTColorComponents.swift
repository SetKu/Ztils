//
//  ZTColorComponents.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-08-01.
//

#if canImport(UIKit)
import Foundation
import UIKit

public struct ZTColorComponents: Codable {
    var r: CGFloat
    var g: CGFloat
    var b: CGFloat
    var a: CGFloat
    
    public init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }
    
    func formColor() -> UIColor {
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
#endif
