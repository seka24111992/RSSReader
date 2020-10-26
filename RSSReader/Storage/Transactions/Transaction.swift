//
//  Transaction.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import MagicalRecord


open class Transaction {
    
    // MARK: - Properties
    
    public let context: NSManagedObjectContext
    
    // MARK: - Constructor
    
    private init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Executing
    
    public static func execute(operations: @escaping (Transaction) -> Void, completed: @escaping (Error?) -> Void) {
        MagicalRecord.save({
            context in
            
            let transaction = Transaction(context: context)
            operations(transaction)
        }) {
            success, error in
            
            completed(error)
        }
    }
    
}

