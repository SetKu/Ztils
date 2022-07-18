//
//  CGSize+Extensions.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-07.
//

#if canImport(UIKit)
import UIKit

public extension CGSize {
    func scaled(by factor: CGFloat) -> CGSize {
        return CGSize(width: width * factor, height: height * factor)
    }
    
    func scaledByDynamicTypeSize() -> CGSize {
        return self.scaled(by: UIFontMetrics.default.scaledValue(for: 1))
    }
    
    func adding(size: CGSize) -> CGSize {
        return CGSize(width: width + size.width, height: height + size.height)
    }
}
#endif
