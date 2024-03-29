//
//  View+if.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-07.
//

#if canImport(SwiftUI)
import SwiftUI

public extension View {
    /// Applies the given transform if the given condition evaluates to `true` on a view.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source ``View``.
    /// - Returns: Either the original ``View`` or the modified ``View`` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder func `if`<Content: View, Modifier: ViewModifier>(_ condition: Bool, modifier: Modifier) -> some View {
        if condition {
            self.modifier(modifier)
        } else {
            self
        }
    }
}
#endif


