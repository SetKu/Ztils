//
//  NSImage+pngRepresentation.swift
//  
//
//  Created by Zachary Morden on 2022-08-01.
//

import Foundation

#if canImport(AppKit)
import AppKit

public extension NSImage {
    var pngRepresentation: Data {
        let cgImage = self.cgImage(forProposedRect: nil, context: nil, hints: nil)!
        let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
        let pngData = bitmapRep.representation(using: NSBitmapImageRep.FileType.png, properties: [:])!
        return pngData
    }
}
#endif
