//
//  NetworkManager.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-07-07.
//

import Foundation

final class NetworkManager {
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
