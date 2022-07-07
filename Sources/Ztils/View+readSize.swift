//
//  View+readSize.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-06.
//

// Credit for this solution goes to Federico Zanatello on Five Stars.
// URL: https://www.fivestars.blog/articles/swiftui-share-layout-information/

#if canImport(SwiftUI)
import SwiftUI

extension View {
    /// Retrieves the size of the view.
    /// - Parameter onChange: The closure to execute when the size is retrieved.
    func readSize(_ onChange: @escaping (CGSize) -> Void) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: geo.size)
                }
            )
            .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}
#endif
