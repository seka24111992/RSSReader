//
//  Date.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

extension Date {
    
    // MARK: - Formatters
    
    private struct Formatters {
        
        static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
            return formatter
        }()
    }
    
    public var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "Ru-ru")
        dateFormatter.dateFormat = "d MMM yyyy HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    public static func fromString(string: String) -> Date? {
        return Formatters.dateFormatter.date(from:string)
    }
    
}
