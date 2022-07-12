//
//  ZTSizePreferenceKey.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-06.
//

// Credit for this solution goes to Federico Zanatello on Five Stars.
// URL: https://www.fivestars.blog/articles/swiftui-share-layout-information/

#if canImport(SwiftUI)
import SwiftUI

/// A preference key that corresponds to a `CGSize` and combines by adding.
struct ZTSizePreferenceKey: PreferenceKey {
    static var defaultValue = CGSize.zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = CGSize(width: value.width + nextValue().width, height: value.height + nextValue().height)
    }
}
#endif
