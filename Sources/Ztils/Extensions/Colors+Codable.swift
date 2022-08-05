//
//  Colors+Codable.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-08-01.
//

import Foundation

#if canImport(UIKit)
import UIKit

public extension UIColor {
    func components(for traitCollection: UITraitCollection) -> ZTColorComponents {
        let resolved = self.resolvedColor(with: traitCollection)
        var components = ZTColorComponents(r: 0, g: 0, b: 0, a: 0)
        
        resolved.getRed(
            &components.r,
            green: &components.g,
            blue: &components.b,
            alpha: &components.a
        )
        
        return components
    }

    func components(using colorScheme: UIUserInterfaceStyle) -> ZTColorComponents {
        let collection = UITraitCollection(userInterfaceStyle: colorScheme)
        return components(for: collection)
    }
}

fileprivate enum UIColorCodingKeys: CodingKey {
    case light, dark
}

public extension Decodable where Self: UIColor {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UIColorCodingKeys.self)
        let lightComponents = try container.decode(ZTColorComponents.self, forKey: .light)
        let darkComponents = try container.decode(ZTColorComponents.self, forKey: .dark)
        let light = lightComponents.formColor()
        let dark = darkComponents.formColor()
        
        self.init(dynamicProvider: {
            $0.userInterfaceStyle == .light
            ? light
            : dark
        })
    }
}

public extension Encodable where Self: UIColor {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UIColorCodingKeys.self)
        let lightComponents = components(using: .light)
        let darkComponents = components(using: .dark)
        try container.encode(lightComponents, forKey: .light)
        try container.encode(darkComponents, forKey: .dark)
    }
}

extension UIColor: Codable { }
#endif

#if canImport(AppKit)
import AppKit

fileprivate enum NSColorCodingKeys: CodingKey {
    case data
}

public extension Decodable where Self: NSColor {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NSColorCodingKeys.self)
        let data = try container.decode(Data.self, forKey: .data)
        let coder = try NSKeyedUnarchiver(forReadingFrom: data)
        self.init(coder: coder)!
    }
}

public extension Encodable where Self: NSColor {
    func encode(to encoder: Encoder) throws {
        let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: true)
        var container = encoder.container(keyedBy: NSColorCodingKeys.self)
        try container.encode(data, forKey: .data)
    }
}

extension NSColor: Codable { }
#endif
