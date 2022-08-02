//
//  Colors+Adaptive.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-18.
//

#if canImport(UIKit)
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

#if canImport(SwiftUI)
import SwiftUI

public extension Color {
    @available(iOS 15.0, *)
    init(light: Color, dark: Color) {
        self.init(uiColor: UIColor(light: UIColor(light), dark: UIColor(dark)))
    }
}
#endif
#endif

#if canImport(AppKit)
import AppKit

public extension NSColor {
    convenience init(light: NSColor, dark: NSColor) {
        self.init(name: nil, dynamicProvider: { appearance in
            appearance.name == .aqua ||
            appearance.name == .accessibilityHighContrastAqua ||
            appearance.name == .vibrantLight ||
            appearance.name == .accessibilityHighContrastVibrantLight
            ? light
            : dark
        })
    }
}

#if canImport(SwiftUI)
import SwiftUI

public extension Color {
    init(light: NSColor, dark: NSColor) {
        self.init(nsColor: NSColor(light: light, dark: dark))
    }
}
#endif
#endif
