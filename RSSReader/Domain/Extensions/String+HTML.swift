//
//  String+HTML.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

extension String {
    func withoutHTML() -> String {
        do {
            let regex = try NSRegularExpression(pattern: "(?<=<\\w{1,40})\\s[^>]+(?=>)", options: .caseInsensitive)
            let range = NSMakeRange(0, self.count)
            let htmlWithoutInlineAttributes = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
            return htmlWithoutInlineAttributes
        } catch {
            return self
        }
    }
}
