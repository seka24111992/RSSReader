//
//  Synchronizable.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

public protocol Synchronizable {
    
    var syncOperations: [Operation] { get }
    
}
