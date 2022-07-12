//
//  ZMScrollView.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-12.
//

// Adopted from Max Natchanon's Medium blogpost:
// URL: https://is.gd/IF0Vgv

#if canImport(SwiftUI)
import SwiftUI

struct ZMScrollPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ZMScrollView<Content: View>: View {
    let axes: Axis.Set
    let showsIndicators: Bool
    let content: (CGFloat) -> Content
    private let offsetBinding: (Binding<CGFloat>)?
    
    @State private var offset = ZMScrollPreferenceKey.defaultValue {
        didSet {
            offsetBinding?.wrappedValue = offset
        }
    }
    
    init(
        axes: Axis.Set = .vertical,
        showsIndicators: Bool = true,
        contentOffset: Binding<CGFloat>? = nil,
        @ViewBuilder content: @escaping (CGFloat) -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.content = content
        self.offsetBinding = contentOffset
    }
    
    var body: some View {
        GeometryReader { outsideGeo in
            ScrollView(axes, showsIndicators: showsIndicators) {
                GeometryReader { insideGeo in
                    let offset = calculateOffset(outside: outsideGeo, inside: insideGeo)
                    
                    Color.clear
                        .preference(key: ZMScrollPreferenceKey.self, value: offset)
                }
                
                content(offset)
            }
            .onPreferenceChange(ZMScrollPreferenceKey.self) {
                offset = $0
            }
        }
    }
    
    private func calculateOffset(outside: GeometryProxy, inside: GeometryProxy) -> CGFloat {
        let base: CGFloat
        
        if axes == .vertical {
            base = outside.frame(in: .global).minY - inside.frame(in: .global).minY
        } else {
            base = outside.frame(in: .global).minX - inside.frame(in: .global).minX
        }
        
        return base * -1
    }
}

struct ZMScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ZMScrollView { offset in
            Text("Hello! \(offset)")
        }
    }
}
#endif
