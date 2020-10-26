//
//  NewsProvider.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 24.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import Dispatch



open class NewsProvider: NSObject, Synchronizable {
    
    // MARK: - Singleton
    
    public static let shared = NewsProvider()
    
    // MARK: - Properties
    
    open var syncOperations: [Operation] {
        return fetchSyncOperations()
    }
    
    private let fetchSemaphore = DispatchSemaphore(value: 1)
    private let fetchNewsFromServerQueue = DispatchQueue(label: "queue")
    
    // MARK: - Constructor/Destructor
    
    private override init() {
        super.init()
    }
    
    // MARK: - Methods
    
    open func fetchNews(completionHandler: @escaping (FetchResult<[News]>) -> Void) {
        
        let sources = PreferencesService.shared.sourcesValue
        
        if !APIClient.shared.isReachable {
            completionHandler(self.fetchNewsFromRepository())
        } else {
            self.fetchNewsFromServerQueue.async {
                let dispatch = DispatchGroup()
                var newsArray = [News]()
                var fetchResult: FetchResult<[News]> = .success(value: newsArray)
                
                for source in sources {
                    dispatch.enter()
                    self.fetchNewsFromServer(from: source) {
                        result in
                        switch result {
                        case .success(let result):
                            newsArray.append(contentsOf: result)
                            fetchResult = .success(value: newsArray)
                        case .failure(let error):
                            fetchResult = .failure(error: error)
                        }
                        dispatch.leave()
                    }
                }
                
                dispatch.notify(queue: .main) {
                    completionHandler(fetchResult)
                }
            }
        }
    }
    
    private func fetchNewsFromServer(from url: String, completionHandler: @escaping (FetchResult<[News]>) -> Void) {
        fetchSemaphore.wait()
        
        APIClient.shared.request(route: NewsAPIRoutes.getNews(from: url)).response {
            [weak self] response in
            
            let requestResult = FetchResult(response: response)
            var fetchResult: FetchResult<[News]>
            switch requestResult {
            case .success(let newsArray):
                fetchResult = FetchResult.success(value: newsArray)
                self?.saveToRepository(newsArray: newsArray, completionHandler: {
                    fetchResult in
                    self?.fetchSemaphore.signal()
                    completionHandler(fetchResult)
                })
            case .failure(let error):
                fetchResult = .failure(error: error)
                self?.fetchSemaphore.signal()
                completionHandler(fetchResult)
            }
        }
    }
    
    open func fetchNewsFromRepository() -> FetchResult<[News]> {
        fetchSemaphore.wait()
        let entities = NewsStorage.shared.fetchAll(ascending: false)
        let fetchResult: FetchResult<[News]> = .success(value: entities.map { $0.toModel() })
        fetchSemaphore.signal()
        return fetchResult
    }
    
    private func saveToRepository(newsArray: [News], completionHandler: @escaping (FetchResult<[News]>) -> Void) {
        Transaction.execute(operations: {
            NewsStorage.usingTransaction($0) {
                for (_, news) in newsArray.enumerated() {
                    _ = $0.createOrUpdate(from: news)
                }
            }
        }) {
            error in
            if let error = error {
                completionHandler(.failure(error: .error(error: error)))
            } else {
                completionHandler(.success(value: newsArray))
            }
        }
    }
    
    func updateNewsByUser(news: News, completionHandler: @escaping (FetchResult<News>) -> Void) {
        
        Transaction.execute(operations: {
            NewsStorage.usingTransaction($0) {
                _ = $0.createOrUpdate(from: news)
            }
        }, completed: {
            error in
            if let error = error {
                completionHandler(.failure(error: .error(error: error)))
            } else {
                completionHandler(.success(value: news))
            }
        })
    }
    
    // MARK: - Syncrhonizable
    
    private func fetchSyncOperations() -> [Operation] {
        var operations = [Operation]()
        
        let fetchNewsOperation = AsyncOperation(block: {
            controller in

            NewsProvider.shared.fetchNews { _ in
                controller.complete()
            }
        })

        operations.append(fetchNewsOperation)

        return operations
    }
    
}

