//
//  ZTAction.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-21.
//

#if canImport(UIKit)
import UIKit

internal class ZTAction: NSObject, Identifiable {
    internal let id = UUID()
    private let _action: () -> Void
    
    internal init(_ action: @autoclosure @escaping () -> Void) {
        self._action = action
    }
    
    @objc internal func action() {
        _action()
    }
}
#endif
