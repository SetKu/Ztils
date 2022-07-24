//
//  UIViewController+Extensions.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-21.
//

import Foundation

#if canImport(UIKit)
import UIKit

public extension UIViewController {
    private var _actions = Set<ZTAction>()
    
    /// Runs a selector when the dynamic type size changes.
    /// - Parameter selector: The local selector to perform on dynamic type size change. This selector must be a method within the view controller itself.
    public func onDynamicTypeSizeChange(run selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    /// Runs a closure when the dynamic type size changes.
    /// - Parameter closure: The closure to call on change.
    public func onDynamicTypeSizeChange(run closure: @escaping () -> Void) {
        let action = ZTAction(closure)
        _actions.insert(action)
        
        NotificationCenter.default.addObserver(self, selector: #selector(_actions[action].action), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
}
#endif
