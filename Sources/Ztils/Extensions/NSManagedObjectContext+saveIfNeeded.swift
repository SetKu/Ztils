//
//  NSManagedObjectContext+saveIfNeeded.swift
//  Ztils
//
//  Created by Zachary Morden on 2022-08-06.
//

import Foundation

#if canImport(CoreData)
import CoreData

public extension NSManagedObjectContext {
    func saveIfNeeded() throws {
        if self.hasChanges {
            try self.save()
        }
    }
}
#endif
