//
//  UIColor+Construct.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/23/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init(alpha: UInt8 = UInt8.max, red: UInt8, green: UInt8, blue: UInt8) {
        let maxValue = CGFloat(UInt8.max)
        self.init(red: CGFloat(red) / maxValue, green: CGFloat(green) / maxValue, blue: CGFloat(blue) / maxValue, alpha: CGFloat(alpha) / maxValue)
    }
    
    public convenience init?(hexString: String) {
        let red, green, blue, alpha: CGFloat
        var hexColor = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if hexColor.hasPrefix("#") {
            let start = hexColor.index(hexColor.startIndex, offsetBy: 1)
            hexColor = hexColor.substring(from: start)
        }
        
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        if hexColor.count == 8 {
            if scanner.scanHexInt64(&hexNumber) {
                red = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                alpha = CGFloat(hexNumber & 0x000000ff) / 255
                
                self.init(red: red, green: green, blue: blue, alpha: alpha)
                return
            }
        } else if hexColor.count == 6 {
            if scanner.scanHexInt64(&hexNumber) {
                red = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                green = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                blue = CGFloat(hexNumber & 0x0000ff) / 255
                
                self.init(red: red, green: green, blue: blue, alpha: 1)
                return
            }
        }
        
        return nil
    }
    
    public var hexString: String {
        guard let components = cgColor.components else {
            return ""
        }
        
        var result = "#"
        for component in components {
            result += String(format: "%02lX", lround(Double(component * 255)))
        }
        return result
    }
    
}
