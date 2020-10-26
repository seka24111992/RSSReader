//
//  PreferencesService.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/23/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

open class PreferencesService {
    
    // MARK: - Keys
    
    public enum Key : String {
        
        case advancedViewAvailable = "kAdvancedViewAvailable"
        case updateInterval = "kUpdateInterval"
        case sourcesValue = "kSourcesValue"
        
        
        public var defaultValue: Any? {
            switch self {
            case .advancedViewAvailable:
                return false
            case .updateInterval:
                return UpdateInterval.minute
            case .sourcesValue:
                return ["http://lenta.ru/rss", "http://www.gazeta.ru/export/rss/lenta.xml", "http://feeds.bbci.co.uk/news/world/rss.xml", "https://www.nytimes.com/svc/collections/v1/publish/https://www.nytimes.com/section/world/rss.xml"]
            }
        }
    }
    
    // MARK: - Singleton
    
    public static let shared = PreferencesService()
    
    // MARK: - Properties
    
    public var advancedViewAvailable: Bool {
        get {
            return value(for: Key.advancedViewAvailable, ofType: Bool.self)
        }
        set {
            set(newValue, forKey: Key.advancedViewAvailable)
        }
    }
    
    public var updateInterval: UpdateInterval {
        get {
            return UpdateInterval(rawValue: valueOrNil(for: Key.updateInterval, ofType: String.self) ?? UpdateInterval.minute.rawValue) ?? UpdateInterval.minute
        }
        set {
            set(newValue.rawValue as AnyObject, forKey: Key.updateInterval)
        }
    }
    
    public var sourcesValue: [String] {
        get {
            return value(for: Key.sourcesValue, ofType: [String].self)
        }
        set {
            set(newValue as AnyObject, forKey: Key.sourcesValue)
        }
    }
    
    // MARK: - Constuctor
    
    private init() {
    }
    
    public func valueOrNil<ValueType>(for key: Key, ofType type: ValueType.Type) -> ValueType? {
        if let value = UserDefaults.standard.object(forKey: key.rawValue) as? ValueType {
            return value
        }
        if let defaultValue = key.defaultValue as? ValueType {
            return defaultValue
        }
        return nil
    }
    
    public func value<ValueType>(for key: Key, ofType type: ValueType.Type) -> ValueType {
        return valueOrNil(for: key, ofType: ValueType.self)!
    }
    
    public func set(_ value: Any?, forKey key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
}
