//
//  ZTViewController.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-21.
//

import Foundation

#if canImport(UIKit)
import UIKit

open class ZTViewController: UIViewController {
    private var _dynamicTypeSizeDidChangeActions = [() -> Void]()
    
    open override func loadView() {
        super.loadView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(dynamicTypeSizeDidChange), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    @objc private func dynamicTypeSizeDidChange() {
        DispatchQueue.main.async {
            self._dynamicTypeSizeDidChangeActions.forEach {
                $0()
            }
        }
    }
}
#endif
