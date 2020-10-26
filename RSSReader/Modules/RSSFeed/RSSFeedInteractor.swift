//
//  RSSFeedInteractor.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/23/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

class RSSFeedInteractor: RSSFeedInteractorProtocol {
    
    var isAdvancedViewAvailable: Bool {
        get {
            return PreferencesService.shared.advancedViewAvailable
        }
    }
    
    weak var presenter: RSSFeedPresenterProtocol!
        
    init(presenter: RSSFeedPresenterProtocol) {
        self.presenter = presenter
    }
        
    
    func getInitialData() {
        NewsProvider.shared.newsOperation.execute {
            [weak self] result in
            guard let interactor = self else { return }
            interactor.fetchNewsFromRepository()
        }
    }
    
    func updateNews(_ news: News) {
        NewsProvider.shared.updateNewsByUser(news: news) { [weak self] result in
            if let news = self?.presenter.processFetching(result, allowCache: false) {
                self?.presenter.updateNews(news)
            }
        }
    }
    
    func fetchNewsFromRepository() {
        let result = NewsProvider.shared.fetchNewsFromRepository()
        if let presenter = self.presenter, let newsArray = presenter.processFetching(result, allowCache: false) {
            presenter.dismissActivityIndicator()
            presenter.setNewsArray(newsArray)
        }
    }
    
}

