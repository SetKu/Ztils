//
//  ZTSpacifier.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-12.
//

#if canImport(SwiftUI)
import SwiftUI

struct ZTSpacifier<Content: View>: View {
    enum Places {
        case leading, trailing, both
    }
    
    private let place: Places
    private let content: () -> Content
    
    init(at place: Places = .both, @ViewBuilder content: @escaping () -> Content) {
        self.place = place
        self.content = content
    }
    
    var body: some View {
        HStack {
            if place == .leading || place == .both {
                Spacer()
            }
            
            content()
            
            if place == .trailing || place == .both {
                Spacer()
            }
        }
    }
}
#endif
