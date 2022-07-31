//
//  Color+forText.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-31.
//

#if canImport(SwiftUI)
import SwiftUI

public extension Color {
    // Solution derived from Stack Overflow blog post.
    // https://stackoverflow.com/questions/1855884/determine-font-color-based-on-background-color
    @available(iOS 14.0, *)
    static func forText(withBackground color: Color, threshold: CGFloat = 0.65) -> Color {
        guard let components = color.cgColor?.components else { return Color.primary }
        
        let luminance = (
            0.299 * components[0] +
            0.587 * components[1] +
            0.114 * components[2]
            / 255
        )
        
        if luminance > threshold {
            return Color.black
        }
        
        return Color.white
    }
}
#endif
