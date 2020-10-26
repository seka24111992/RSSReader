//
//  RSSNewsPresenter.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

class RSSNewsPresenter: NSObject, RSSNewsPresenterProtocol {

    weak var view: RSSNewsViewProtocol!
    var interactor: RSSNewsInteractorProtocol!
    var router: RSSNewsRouterProtocol!
    
    weak var delegate: NewsDelegate?
    
    init(view: RSSNewsViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        self.openNews()
        self.updateNews()
    }
    
    func openNews() {
        if let news = interactor.news {
            news.isOpen = true
            delegate?.open(news: news)
        }
    }
    
    func updateNews() {
        if let news = interactor.news {
            view.setNewsTitle(title: news.title ?? "")
            view.setNewsSource(news.source ?? "")
            view.setNewsDescription(news.newsDescription ?? "")
            view.setNews(news)
        }
    }
    
}

protocol NewsDelegate: NSObjectProtocol {
    func open(news: News)
}
