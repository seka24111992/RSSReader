//
//  WeakReference.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

open class WeakReference<Value> {
    
    private weak var _value: AnyObject?
    
    open var value: Value? {
        get {
            return _value as? Value
        }
        set {
            _value = newValue as AnyObject
        }
    }
    
    public init(value: Value) {
        self.value = value
    }
    
}
