//
//  UIButton+flash.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-09.
//

#if canImport(UIKit)
import UIKit

public extension UIButton {
    func flash() {
        alpha = 0.1
        
        UIView.animate(withDuration: 0.4) {
            self.alpha = 1
        }
    }
}
#endif

