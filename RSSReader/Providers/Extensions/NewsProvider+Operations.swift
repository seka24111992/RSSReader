//
//  NewsProvider+Operations.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

extension NewsProvider {
    
    // MARK: - Operations
    
    public var newsOperation: FetchOperation<[News]> {
        return FetchOperation(sender: self, selector: #selector(NewsProvider.fetchNews(options:)), options: [:])
    }
    
    // MARK: - Fetching
    
    @objc
    private func fetchNews(options: [String: Any]) {
        fetchNews {
            result in
            
            if let handler = options[FetchOperationOption.handler] as? ((FetchResult<[News]>) -> Void) {
                handler(result)
            }
        }
    }
    
}
