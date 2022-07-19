//
//  Color+Adaptive.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-18.
//

#if canImport(SwiftUI)
#if canImport(UIKit)
import SwiftUI
import UIKit

public extension UIColor {
    convenience init(light: UIColor, dark: UIColor) {
        self.init(dynamicProvider: { traits in
            traits.userInterfaceStyle == .light
            ? light
            : dark
        })
    }
}

public extension Color {
    @available(iOS 15.0, *)
    init(light: Color, dark: Color) {
        self.init(uiColor: UIColor(light: UIColor(light), dark: UIColor(dark)))
    }
}
#endif
#endif
