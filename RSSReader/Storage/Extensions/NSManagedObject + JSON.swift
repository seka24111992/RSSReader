//
//  NSManagedObject + JSON.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

extension NSManagedObject {
    func toJSON() -> String? {
        let keys = Array(self.entity.attributesByName.keys)
        let dict = self.dictionaryWithValues(forKeys: keys).filter { !($0.1 is NSNull) }
        let newDict = Dictionary(uniqueKeysWithValues:
            dict.map { (arg) -> (key: String, value: Any) in let (key, value) = arg;
                var newValue = value
                if value is NSDate {
                    newValue = (value as! Date).toString
                }
                return (key, newValue)
                
        })
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: newDict)
            let reqJSONStr = String(data: jsonData, encoding: .utf8)
            return reqJSONStr
        }
        catch let error {
            print("Error converting Core Data object to JSON: \(error.localizedDescription)")
        }

        return nil
    }
}
