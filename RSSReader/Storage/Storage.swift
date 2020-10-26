//
//  Storage.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import CoreData

public protocol Storage {
    
    associatedtype EntityType: AbstractEntity
    
    init(context: NSManagedObjectContext)
    
    static func usingContext(_ context: NSManagedObjectContext, executeOperations: (Self) -> Void)
    static func usingTransaction(_ transaction: Transaction, executeOperations: (Self) -> Void)
    
    func create() -> EntityType?
    func create(withPreparations preparations: (EntityType) -> Void) -> EntityType?
    func createOrUpdate(entityWithPredicate predicate: NSPredicate, withPreparations preparations: (EntityType) -> Void) -> EntityType?
    
    @discardableResult
    func prepare(_ entity: EntityType, withPreparations preparations: (EntityType) -> Void) -> Bool
    
    func fetch(by predicate: NSPredicate) -> EntityType?
    func fetchFirst(by predicate: NSPredicate, active: Bool?) -> EntityType?
    func fetchFirst(by predicate: NSPredicate, orderedBy parameter: String, ascending: Bool, active: Bool?) -> EntityType?
    func fetchAll(active: Bool?) -> [EntityType]
    func fetchAll(with predicate: NSPredicate, active: Bool?) -> [EntityType]
    func fetchAll(with predicate: NSPredicate, orderedBy parameter: String, ascending: Bool, active: Bool?) -> [EntityType]
    
    func count() -> Int
    func countOf(active: Bool) -> Int
    func countOf(entitiesWith predicate: NSPredicate, active: Bool?) -> Int
    
    @discardableResult
    func restore(_ entity: EntityType) -> Bool
    @discardableResult
    func delete(_ entity: EntityType, permanently: Bool) -> Bool
    
    @discardableResult
    func deleteAll(permanently: Bool) -> Bool
    @discardableResult
    func deleteAll(with predicate: NSPredicate, permanently: Bool) -> Bool
    
}

extension Storage {
    
    public static func usingContext(_ context: NSManagedObjectContext, executeOperations: (Self) -> Void) {
        let object = Self.init(context: context)
        executeOperations(object)
    }
    
    public static func usingTransaction(_ transaction: Transaction, executeOperations: (Self) -> Void) {
        usingContext(transaction.context, executeOperations: executeOperations)
    }
    
}
