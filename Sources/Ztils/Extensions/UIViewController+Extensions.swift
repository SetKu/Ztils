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
    
    public func onDynamicTypeSizeChange(run selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    public func onDynamicTypeSizeChange(run closure: @autoclosure @escaping () -> Void) {
        let action = ZTAction(closure)
        _actions.insert(action)
        
        NotificationCenter.default.addObserver(self, selector: #selector(action.action), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
}
#endif
