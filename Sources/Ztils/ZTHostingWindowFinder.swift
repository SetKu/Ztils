//
//  HostingWindowFinder.swift
//  
//
//  Created by Zachary Morden on 2022-07-11.
//

#if canImport(SwiftUI)
import SwiftUI

/// A view capable of finding the parent UIWindow for a SwiftUI view.
public struct ZTHostingWindowFinder: UIViewRepresentable {
    /// The callback that will be called when the view's window is (or is not) found.
    var callback: (UIWindow?) -> ()
    
    public func makeUIView(context: Context) -> UIView {
        let view = UIView()
        
        DispatchQueue.main.async { [weak view] in
            self.callback(view?.window)
        }
        
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) { }
    
    public typealias UIViewType = UIView
}
#endif
