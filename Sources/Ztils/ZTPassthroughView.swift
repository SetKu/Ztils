//
//  ZTPassthroughView.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-07.
//

#if canImport(UIKit)
import UIKit

/// A UIKit view that redirects taps past its frame. The view visually appears to the user, but doesn't allow for hit testing.
///
/// - Note: Subviews can respond to touches, unlike the view itself.
public class ZTPassthroughView: UIView {
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
}
#endif
