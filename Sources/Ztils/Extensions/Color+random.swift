//
//  Color+random.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-07.
//

#if canImport(SwiftUI)
import SwiftUI

public extension Color {
    static func random(saturation: Double, brightness: Double) -> Color {
        return Color(hue: Double.random(in: 0...1), saturation: saturation, brightness: brightness)
    }
}
#endif
