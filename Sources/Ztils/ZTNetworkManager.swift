//
//  NetworkManager.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-07.
//

import Foundation

/// A container class for quickly working with asynchronous data requests.
public class ZTNetworkManager {
    /// Decodes the JSON provided from a URL to a specified type whilst providing safety checks (i.e. server response codes).
    /// - Parameters:
    ///   - type: The type to decode the JSON from the server to.
    ///   - urlString: The string to convert into a URL to query from.
    /// - Returns: The decoded JSON in the type specified by the caller.
    /// - Throws: Several errors can be thrown during the process: bad URL errors, bad server responses, decoding errors, etc.
    static func decodeJSON<T: Decodable>(_ type: T.Type, from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else { throw CocoaError(.coderValueNotFound) }
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let code = (response as? HTTPURLResponse)?.statusCode
        guard code != nil && code == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }
}
