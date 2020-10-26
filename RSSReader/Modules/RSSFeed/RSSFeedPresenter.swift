//
//  RSSFeedPresenter.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/23/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

class RSSFeedPresenter: NSObject, RSSFeedPresenterProtocol {
    
    
    weak var view: RSSFeedViewProtocol!
    var interactor: RSSFeedInteractorProtocol!
    var router: RSSFeedRouterProtocol!
        
    init(view: RSSFeedViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        self.presentActivityIndicator()
    }
    
    func viewWillAppear() {
        view.setAdvancedViewValue(interactor.isAdvancedViewAvailable)
        view.tableViewReloadData()
    }
    
    func setNewsArray(_ news: [News]) {
        view.setNewsArray(news)
    }
    
    func didSelectNews(_ news: News) {
        router.presentNewsViewController(with: news)
    }
    
    func updateNews(_ news: News) {
        view.updateNews(news)
    }
    
    func synchronizationManagerDidSyncComplete() {
        interactor.getInitialData()
    }
    
    func presentActivityIndicator() {
        view.presentActivityIndicator()
    }
    
    func dismissActivityIndicator() {
        view.dismissActivityIndicator()
    }
    
    func settingsButtonClicked() {
        router.presentSettingsViewController()
    }
    
    func processFetching<Result>(_ result: FetchResult<Result>, allowCache: Bool) -> Result? {
        if view != nil {
            return view.processFetching(result, allowCache: allowCache)
        } else {
            return nil
        }
    }
}

extension RSSFeedPresenter: NewsDelegate {
    
    func open(news: News) {
        interactor.updateNews(news)
    }
    
}
