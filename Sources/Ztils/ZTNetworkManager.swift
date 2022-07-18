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
    ///   - requestTimeout: The time to wait for the server to respond to the request before timing out.
    ///   - resourceTimeout: The time to allow for the transfer of a specific server resource before timing out.
    /// - Returns: The decoded JSON in the type specified by the caller.
    /// - Throws: Several errors can be thrown during the process: bad URL errors, bad server responses, decoding errors, etc.
    public static func decodeJSON<T: Decodable>(
        _ type: T.Type,
        from urlString: String,
        requestTimeout: TimeInterval = 5,
        resourceTimeout: TimeInterval = 60
    ) async throws -> T {
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let request = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = requestTimeout
        config.timeoutIntervalForResource = resourceTimeout
        let session = URLSession(configuration: config)
        
        let (data, response) = try await session.data(for: request)
        
        try validate(response: response)
        
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }
    
    @available(iOS 15.0, *)
    private final class ZTPingDelegate: NSObject, URLSessionTaskDelegate {
        var metrics = [URLSessionTaskMetrics]()
        
        func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
            self.metrics.append(metrics)
        }
    }
    
    /// Pings the specified URL to check whether it exists.
    /// - Parameter urlString: The URL for the resource to ping as a string.
    /// - Returns: The time the request took to finish and validate.
    /// - Throws: The ping request will fail if the URL provided is invalid or the ping request failed.
    @available(iOS 15.0, *)
    public static func ping(url urlString: String) async throws -> TimeInterval {
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        request.httpMethod = "HEAD"
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let session = URLSession(configuration: sessionConfiguration)
        
        let delegate = ZTPingDelegate()
        let (_, response) = try await session.data(for: request, delegate: delegate)

        try validate(response: response)
        
        let metric = delegate.metrics.first!
        let transactionMetrics = metric.transactionMetrics.first!
        
        let start = transactionMetrics.fetchStartDate!
        let end = transactionMetrics.responseStartDate!
        
        return end.timeIntervalSince(start)
    }
    
    /// Checks that the provided URL response is a valid response code of 200 (OK).
    /// - Parameter response: The `URLResponse` object to validate.
    /// - Throws: A bad server response error if the provided response had a status code other than 200.
    public static func validate(response: URLResponse) throws {
        let code = (response as? HTTPURLResponse)?.statusCode
        guard code != nil && code == 200 else {
            throw URLError(.badServerResponse)
        }
    }
}
