//
//  ZTScrollView.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-12.
//

// Adopted from Max Natchanon's Medium blogpost:
// URL: https://is.gd/IF0Vgv

#if canImport(SwiftUI)
import SwiftUI

private struct ZTScrollPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

public struct ZTScrollView<Content: View>: View {
    private let axes: Axis.Set
    private let showsIndicators: Bool
    private let content: (CGFloat) -> Content
    
    @State private var offset = ZTScrollPreferenceKey.defaultValue
    @Binding private var offsetBinding: CGFloat
    
    init(
        axes: Axis.Set = .vertical,
        showsIndicators: Bool = true,
        contentOffset: Binding<CGFloat>? = nil,
        @ViewBuilder content: @escaping (CGFloat) -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.content = content
        
        if let contentOffset {
            self._offsetBinding = contentOffset
            return
        }
        
        self._offsetBinding = .constant(0)
    }
    
    public var body: some View {
        GeometryReader { outsideGeo in
            ScrollView(axes, showsIndicators: showsIndicators) {
                GeometryReader { insideGeo in
                    let offset = calculateOffset(outside: outsideGeo, inside: insideGeo)
                    
                    Color.clear
                        .preference(key: ZTScrollPreferenceKey.self, value: offset)
                }
                
                VStack {
                    content(offset)
                }
            }
            .onPreferenceChange(ZTScrollPreferenceKey.self) {
                offset = $0
                offsetBinding = offset
            }
        }
    }
    
    private func calculateOffset(outside: GeometryProxy, inside: GeometryProxy) -> CGFloat {
        if axes == .vertical {
            return outside.frame(in: .global).minY - inside.frame(in: .global).minY
        }
        
        return outside.frame(in: .global).minX - inside.frame(in: .global).minX
    }
}

struct ZMScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ZTScrollView { offset in
            Text("Hello! \(offset)")
        }
    }
}
#endif
