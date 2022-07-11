//
//  Cache.swift
//  
//
//  Created by Zachary Morden on 2022-07-10.
//

//
// NSCache wrapper as is described and documented by John Sundell on Swift by Sundell.
// URL: https://www.swiftbysundell.com/articles/caching-in-swift/
//

import Foundation

/// A wrapper for NSCache created by John Sundell enabling data persistence and system adaptations, such as low-memory evictions.
public final class Cache<Key: Hashable, Value> {
    private let wrapped = NSCache<WrappedKey, Entry>()
    private let dateProvider: () -> Date
    private let entryLifetime: TimeInterval
    private let keyTracker = KeyTracker()
    
    /// - Parameters:
    ///   - dateProvider: A provider capable of returning the date to base entry lifetime calculations off of.
    ///   - entryLifetime: The individual lifetime of an entry object in the cache.
    ///   - maximumEntryCount: The maximum number of entries that will be persisted in the cache for a key.
    init(dateProvider: @escaping () -> Date = Date.init, entryLifetime: TimeInterval = 12 * 60 * 60, maximumEntryCount: Int = 50) {
        self.dateProvider = dateProvider
        self.entryLifetime = entryLifetime
        wrapped.countLimit = maximumEntryCount
        wrapped.delegate = keyTracker
    }
}

public extension Cache {
    final class WrappedKey: NSObject {
        let key: Key
        
        init(_ key: Key) {
            self.key = key
        }
        
        public override var hash: Int { return key.hashValue }
        
        public override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else { return false }
            return value.key == key
        }
    }
    
    final class Entry {
        let key: Key
        let value: Value
        let expirationDate: Date
        
        init(key: Key, value: Value, expirationDate: Date) {
            self.key = key
            self.value = value
            self.expirationDate = expirationDate
        }
    }
}

private extension Cache {
    /// Finds the latest entry corresponding to the provided key.
    /// - Parameter key: The key to query for an entry for in the cache.
    /// - Returns: The latest entry for the provided key, if it exists.
    func entry(forKey key: Key) -> Entry? {
        guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
            return nil
        }
        
        guard dateProvider() < entry.expirationDate else {
            // The entry has now expired and should be removed from the cache to respect system memory.
            removeValue(forKey: key)
            return nil
        }
        
        return entry
    }
    
    func insert(_ entry: Cache.Entry) {
        self.insert(entry.value, forKey: entry.key)
    }
}

public extension Cache {
    /// Sets the value for the key within the cache.
    ///
    /// The value can be removed by using the `removeValue(forKey:) method.`
    ///
    /// - Parameters:
    ///   - value: The value to insert.
    ///   - key: The key to insert the value for within the cache.
    func insert(_ value: Value, forKey key: Key) {
        keyTracker.keys.insert(key)
        let date = dateProvider().addingTimeInterval(entryLifetime)
        let entry = Entry(key: key, value: value, expirationDate: date)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }
    
    /// Returns the current stored value in the cache for the key.
    /// - Parameter key: The key to query a value for in the cache.
    /// - Returns: The value currently stored for the key or nil, which would be returned if a value has yet to be set for the key or its value has been removed. See `removeValue(forKey:).`
    func value(forKey key: Key) -> Value? {
        return entry(forKey: key)?.value
    }
    
    /// Removes the current value in the cache for the key, thereby causing a sequential `value(forKey:)` call with the same key to return nil.
    /// - Parameter key: The key to remove the value for in the cache.
    func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }
    
    /// Shorthand subscript for the `value()`, `insert()`, and `removeValue()` methods for the cache.
    subscript(key: Key) -> Value? {
        get { return value(forKey: key) }
        set {
            guard let value = newValue else {
                removeValue(forKey: key)
                return
            }
            
            insert(value, forKey: key)
        }
    }
}

private extension Cache {
    /// An object that keeps track of all the keys for the current `Cache` object and acts as the wrapped `NSCache` delegate.
    final class KeyTracker: NSObject, NSCacheDelegate {
        var keys = Set<Key>()
        
        func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject object: Any) {
            guard let entry = object as? Entry else {
                return
            }
            
            keys.remove(entry.key)
        }
    }
}

extension Cache.Entry: Codable where Key: Codable, Value: Codable { }

extension Cache: Codable where Key: Codable, Value: Codable {
    convenience public init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.singleValueContainer()
        let entries = try container.decode([Entry].self)
        entries.forEach(insert)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(keyTracker.keys.compactMap(entry))
    }
}

extension Cache where Key: Codable, Value: Codable {
    func saveToDisk(
        withName name: String,
        using fileManager: FileManager = .default
    ) throws {
        let folderURLs = fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )
        
        let fileURL = folderURLs[0].appendingPathComponent(name + ".cache")
        let data = try JSONEncoder().encode(self)
        try data.write(to: fileURL)
    }
}
