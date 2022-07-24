//
//  ZTView.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-21.
//

#if canImport(UIKit)
import UIKit

open class ZTView: UIView {
    private var _dynamicTypeSizeDidChangeActions = [() -> Void]()
    
    public init() {
        super.init(frame: .zero)
        NotificationCenter.default.addObserver(self, selector: #selector(dynamicTypeSizeDidChange), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(dynamicTypeSizeDidChange), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public func onDynamicTypeSizeChange(perform closure: @escaping () -> Void) {
        self._dynamicTypeSizeDidChangeActions.append(closure)
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
