//
//  PassthroughView.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-07.
//

#if canImport(UIKit)
import UIKit

public class PassthroughView: UIView {
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
}
#endif
