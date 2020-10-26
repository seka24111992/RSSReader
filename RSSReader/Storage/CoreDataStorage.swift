//
//  CoreDataStorage.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import MagicalRecord

open class CoreDataStorage<Entity: AbstractEntity> {
    
    // MARK: - Properties
    
    public let context: NSManagedObjectContext
    
    // MARK: - Constructor
    
    public convenience init() {
        self.init(context: NSManagedObjectContext.mr_default())
    }
    
    public init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Predicates
    
    public func entities(whereActiveEquals active: Bool) -> NSPredicate {
        return NSPredicate(format: "active = %@", NSNumber(value: active))
    }
    
    // MARK: - Updating
    
    public func create() -> Entity? {
        return Entity.mr_createEntity(in: context)
    }
    
    public func create(withPreparations preparations: (Entity) -> Void) -> Entity? {
        if let entity = create(), prepare(entity, withPreparations: preparations) {
            return entity
        }
        return nil
    }
    
    public func createOrUpdate(entityWithPredicate predicate: NSPredicate, withPreparations preparations: (Entity) -> Void) -> Entity? {
        if let entity = fetch(by: predicate) ?? create(), restore(entity), prepare(entity, withPreparations: preparations) {
            return entity
        }
        return nil
    }
    
    @discardableResult
    public func prepare(_ entity: Entity, withPreparations preparations: (Entity) -> Void) -> Bool {
        if let entity = entity.mr_(in: context) {
            preparations(entity)
            
            return true
        }
        return false
    }
    
    // MARK: - Fetching
    
    public func fetch(by predicate: NSPredicate) -> Entity? {
        return Entity.mr_findFirst(with: predicate, in: context)
    }
    
    public func fetchFirst(by predicate: NSPredicate, active: Bool? = nil) -> Entity? {
        var conditions = predicate
        if let active = active {
            conditions = NSCompoundPredicate(andPredicateWithSubpredicates: [conditions, entities(whereActiveEquals: active)])
        }
        return Entity.mr_findFirst(with: conditions, in: context)
    }
    
    public func fetchFirst(by predicate: NSPredicate, orderedBy parameter: String, ascending: Bool, active: Bool? = nil) -> Entity? {
        var conditions = predicate
        if let active = active {
            conditions = NSCompoundPredicate(andPredicateWithSubpredicates: [conditions, entities(whereActiveEquals: active)])
        }
        return Entity.mr_findFirst(with: conditions, sortedBy: parameter, ascending: ascending, in: context)
    }
    
    public func fetchAll(active: Bool? = nil) -> [Entity] {
        return fetchAll(with: NSPredicate(value: true), active: active)
    }
    
    public func fetchAll(with predicate: NSPredicate, active: Bool? = nil) -> [Entity] {
        var conditions = predicate
        if let active = active {
            conditions = NSCompoundPredicate(andPredicateWithSubpredicates: [conditions, entities(whereActiveEquals: active)])
        }
        return Entity.mr_findAll(with: conditions, in: context) as? [Entity] ?? []
    }
    
    public func fetchAll(with predicate: NSPredicate, orderedBy parameter: String, ascending: Bool, active: Bool? = nil) -> [Entity] {
        var conditions = predicate
        if let active = active {
            conditions = NSCompoundPredicate(andPredicateWithSubpredicates: [conditions, entities(whereActiveEquals: active)])
        }
        return Entity.mr_findAllSorted(by: parameter, ascending: ascending, with: conditions, in: context) as? [Entity] ?? []
    }
    
    public func count() -> Int {
        return countOf(entitiesWith: NSPredicate(value: true), active: nil)
    }
    
    public func countOf(active: Bool) -> Int {
        return countOf(entitiesWith: NSPredicate(value: true), active: active)
    }
    
    public func countOf(entitiesWith predicate: NSPredicate, active: Bool? = nil) -> Int {
        var conditions = predicate
        if let active = active {
            conditions = NSCompoundPredicate(andPredicateWithSubpredicates: [conditions, entities(whereActiveEquals: active)])
        }
        return Int(Entity.mr_countOfEntities(with: conditions, in: context))
    }
    
    public func fetchController(with predicate: NSPredicate,
                                sortedBy sortDescriptors: [NSSortDescriptor] = [],
                                limitedBy fetchLimit: Int? = nil,
                                offsetBy fetchOffset: Int? = nil,
                                grouppedBy sectionName: String? = nil,
                                active: Bool? = nil) -> NSFetchedResultsController<Entity> {
        var conditions = predicate
        if let active = active {
            conditions = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, entities(whereActiveEquals: active)])
        }
        
        let fetchRequest: NSFetchRequest<Entity> = NSFetchRequest(entityName: Entity.mr_entityName())
        fetchRequest.predicate = conditions
        fetchRequest.sortDescriptors = sortDescriptors
        if let fetchLimit = fetchLimit {
            fetchRequest.fetchLimit = fetchLimit
        }
        if let fetchOffset = fetchOffset {
            fetchRequest.fetchOffset = fetchOffset
        }
        return NSFetchedResultsController<Entity>(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: sectionName, cacheName: nil)
    }
    
    // MARK: - Deleting
    
    @discardableResult
    public func restore(_ entity: Entity) -> Bool {
        return prepare(entity) {
            $0.active = true
        }
    }
    
    @discardableResult
    public func delete(_ entity: Entity, permanently: Bool) -> Bool {
        if !permanently {
            return prepare(entity) {
                $0.active = false
            }
        }
        
        let result = entity.mr_deleteEntity(in: context)
        return result
    }
    
    @discardableResult
    public func deleteAll(permanently: Bool) -> Bool {
        return deleteAll(with: NSPredicate(value: true), permanently: permanently)
    }
    
    @discardableResult
    public func deleteAll(with predicate: NSPredicate, permanently: Bool) -> Bool {
        if permanently {
            let result = Entity.mr_deleteAll(matching: predicate, in: context)
            return result
        }
        
        var result = true
        for entity in fetchAll(with: predicate) {
            result = result && delete(entity, permanently: false)
        }
        return result
    }
    
}

//extension CoreDataStorage where Entity: SynchronizableEntity {
//
//    // MARK: - Predicates
//
//    public func entities(whereSyncrhonizedEquals syncrhonized: Bool) -> NSPredicate {
//        return NSPredicate(format: "isSynchronized = %@", NSNumber(value: syncrhonized))
//    }
//
//    // MARK: - Fetching
//
//    public func fetchAll(with predicate: NSPredicate, syncrhonized: Bool, active: Bool? = nil) -> [Entity] {
//        return fetchAll(with: NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, entities(whereSyncrhonizedEquals: syncrhonized)]), active: active)
//    }
//
//    public func fetchAll(with predicate: NSPredicate, orderedBy parameter: String, ascending: Bool, syncrhonized: Bool, active: Bool? = nil) -> [Entity] {
//        return fetchAll(with: NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, entities(whereSyncrhonizedEquals: syncrhonized)]), orderedBy: parameter, ascending: ascending, active: active)
//    }
//
//    // MARK: - Synchronizing
//
//    // MARK: - Deleting
//
//    @discardableResult
//    public func syncrhonize(_ entity: Entity) -> Bool {
//        return prepare(entity) {
//            $0.isSynchronized = true
//        }
//    }
//
//    @discardableResult
//    public func unsyncrhonize(_ entity: Entity) -> Bool {
//        return prepare(entity) {
//            $0.isSynchronized = false
//        }
//    }
//
//}
