//
//  UIFont+scaled.swift
//  
//
//  Created by Zachary Morden on 2022-07-11.
//

#if canImport(UIKit)
import UIKit

public extension UIFont {
    var scaled: UIFont {
        UIFontMetrics.default.scaledFont(for: self)
    }
}
#endif
