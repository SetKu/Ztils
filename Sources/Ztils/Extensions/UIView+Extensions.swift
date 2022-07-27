//
//  UIView+Extensions.swift
//  
//
//  Created by Zachary Morden on 2022-07-27.
//

#if canImport(UIKit)
import UIKit

public extension UIView {
    /// A convenience overload for `UIView.animate(withDuration:delay:options:animations:)`.
    /// - Parameters:
    ///   - duration: The length of the animation.
    ///   - options: Any options to be included as part of the animation.
    ///   - animations: The activities to animate.
    func animate(_ duration: TimeInterval, options: UIView.AnimationOptions? = nil, animations: @escaping () -> Void) {
        if let options = options {
            Self.animate(withDuration: duration, delay: 0, options: options, animations: animations)
            return
        }
        
        Self.animate(withDuration: duration, animations: animations)
    }
}
#endif
