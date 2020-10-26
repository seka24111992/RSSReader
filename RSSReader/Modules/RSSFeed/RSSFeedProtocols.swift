//
//  RSSFeedProtocols.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/23/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit

protocol RSSFeedViewProtocol: class {
    func setNewsArray(_ newsArray: [News])
    func updateNews(_ news: News)
    func presentActivityIndicator()
    func dismissActivityIndicator()
    func setAdvancedViewValue(_ value: Bool)
    func tableViewReloadData()
    func processFetching<Result>(_ result: FetchResult<Result>, allowCache: Bool) -> Result?
}

protocol RSSFeedInteractorProtocol: class {
    var isAdvancedViewAvailable: Bool { get }
    func getInitialData()
    func updateNews(_ news: News)
}

protocol RSSFeedPresenterProtocol: class {
    var router: RSSFeedRouterProtocol! { set get }
    func configureView()
    func didSelectNews(_ news: News)
    func viewWillAppear()
    func setNewsArray(_ news: [News])
    func updateNews(_ news: News)
    func synchronizationManagerDidSyncComplete()
    func presentActivityIndicator()
    func dismissActivityIndicator()
    func settingsButtonClicked()
    func processFetching<Result>(_ result: FetchResult<Result>, allowCache: Bool) -> Result?
}

protocol RSSFeedRouterProtocol {
    func presentNewsViewController(with news: News)
    func presentSettingsViewController()
}

protocol RSSFeedConfiguratorProtocol {
    func configure(with viewController: RSSFeedViewController)
}
