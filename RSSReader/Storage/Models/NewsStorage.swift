//
//  NewsStorage.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

public final class NewsStorage: CoreDataStorage<NewsEntity>, Storage {
    
    // MARK: - Singleton
    
    public static let shared = NewsStorage()
    
    // MARK: - Predicates
    
    public func entities(whereIdEquals uuid: UUID) -> NSPredicate {
        return NSPredicate(format: "uuid = %@", uuid.uuidString)
    }
    
    public func entities(whereTitlequals title: String) -> NSPredicate {
        return NSPredicate(format: "title = %@", title)
    }
    
    // MARK: - Updating
    
    public func createOrUpdate(from news: News) -> NewsEntity? {
        
        var result: NewsEntity? = nil
        
        result = createOrUpdate(entityWithPredicate: NSCompoundPredicate(andPredicateWithSubpredicates: [entities(whereTitlequals: news.title ?? "")]), withPreparations: { entity in
            entity.uuid = news.uuid.uuidString
            entity.title = news.title
            entity.source = news.source
            entity.newsDescription = news.newsDescription
            entity.externalThubnailPath = news.externalThubnailPath
            entity.localThubnailPath = news.localThubnailPath
            if !entity.isOpen {
                entity.isOpen = news.isOpen
            }
            entity.createDate = news.createDate
            entity.link = news.link
        })
        
        return result
    }
    
    // MARK: - Fetching
    
    public func fetchAll(ascending: Bool) -> [NewsEntity] {
        return fetchAll(with: NSCompoundPredicate(andPredicateWithSubpredicates: []), orderedBy: "createDate", ascending: ascending, active: nil)
    }
    
    // MARK: - Deleting
    
    @discardableResult
    public func deleteAll() -> Bool {
        return
            deleteAll(with: NSCompoundPredicate(andPredicateWithSubpredicates: []), permanently: false) &&
                deleteAll(with: NSCompoundPredicate(andPredicateWithSubpredicates: []), permanently: true)
    }
    
    @discardableResult
    public func delete(news: News, permanently: Bool) -> Bool {
        return
            deleteAll(with: NSCompoundPredicate(andPredicateWithSubpredicates: [entities(whereIdEquals: news.uuid)]), permanently: permanently)
    }
    
    
}

extension NewsEntity {
    public func toModel() -> News {
        let news = News()
        if let uuidString = uuid, let uuid = UUID(uuidString: uuidString) {
            news.uuid = uuid
        }
        news.title = title
        news.source = source
        news.newsDescription = newsDescription
        news.externalThubnailPath = externalThubnailPath
        news.localThubnailPath = localThubnailPath
        news.isOpen = isOpen
        news.createDate = createDate ?? Date()
        news.link = link
    
        return news
    }
}
