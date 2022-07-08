//
//  URLSchemeHandling.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-07.
//

#if canImport(UIKit)
import UIKit

/// Use this protocol to define handlers for a URL scheme that can be used to properly route incoming URLs.
protocol URLSchemeHandler {
    /// Determines whether the handler can open the provided URL from its implementation.
    func canOpenURL(_ url: URL) -> Bool
    
    /// Opens the provided URL with the handler.
    func openURL(_ url: URL)
}

/// Use this protocol to define a coordinator which handles handlers that conform to the `URLSchemeHandler` protocol.
protocol URLSchemeCoordinator {
    /// Handles the provided URL by distributing it to all capable handlers.
    /// - Returns: Whether the URL was actually handled.
    @discardableResult
    func handleURL(_ url: URL) -> Bool
}
#endif
