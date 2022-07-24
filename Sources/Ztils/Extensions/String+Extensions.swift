//
//  String+Extensions.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-07.
//

import Foundation

public extension String {
    var solelyContainsWhitespace: Bool { self.allSatisfy({ $0.isWhitespace }) }
    var withFirstLetterCapitalized: String { self.prefix(1).capitalized + self.dropFirst(1) }
}

extension String: Error { }
