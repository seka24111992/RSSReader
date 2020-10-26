//
//  LocalizationService.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/23/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

open class LocalizationService: NSObject {
    
    // MARK: - Keys
    
    public enum Key: String {
        case ok = "OK"
        case cancel = "Cancel"
        case close = "Close"
        case select = "Select"
        case attention = "Attention"
        case yes = "Yes"
        case no = "No"
        case minute = "minute"
        case tenMinutes = "TenMinutes"
        case thirtyMinutes = "ThirtyMinutes"
        
        public var comment: String {
            switch self {
            default:
                return rawValue
            }
        }
    }
    
    // MARK: - Singleton
    
    public static let shared = LocalizationService()
    
    private lazy var localBundle: Bundle = Bundle(for: LocalizationService.self)
    
    public static var language: String {
        return Bundle.main.preferredLocalizations.first ?? Locale.current.identifier
    }
    
    // MARK: - Properties
    
    public var ok: String {
        return string(forKey: .ok)
    }
    public var attention: String {
        return string(forKey: .attention)
    }
    public var yes: String {
        return string(forKey: .yes)
    }
    public var no: String {
        return string(forKey: .no)
    }
    public var cancel: String {
        return string(forKey: .cancel)
    }
    public var close: String {
        return string(forKey: .close)
    }
    public var minute: String {
        return string(forKey: .minute)
    }
    public var tenMinutes: String {
        return string(forKey: .tenMinutes)
    }
    public var thirtyMinutes: String {
        return string(forKey: .thirtyMinutes)
    }
    
    // MARK: - Constructor
    
    private override init() {
        super.init()
    }
    
    // MARK: - Load String
    
    private func string(forKey key: Key) -> String {
        let bundle = Bundle.main
        return NSLocalizedString(key.rawValue, tableName: nil, bundle: bundle, value: key.rawValue, comment: key.comment)
    }
    
}
