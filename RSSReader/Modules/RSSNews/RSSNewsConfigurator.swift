//
//  RSSNewsConfigurator.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import UIKit

class RSSNewsConfigurator: RSSNewsConfiguratorProtocol {
    
    static func createNewsModule(with news: News, presenterDelegate: NewsDelegate?) -> UIViewController {
        guard let newsViewController = storyboard.instantiateViewController(withIdentifier: "RSSNewsViewController") as? RSSNewsViewController else {
            fatalError("Invalid view controller type")
        }
        
        let presenter: RSSNewsPresenter & RSSNewsPresenterProtocol = RSSNewsPresenter(view: newsViewController)
        newsViewController.presenter = presenter
        
        let interactor: RSSNewsInteractorProtocol = RSSNewsInteractor(presenter: presenter)
        presenter.interactor = interactor
        presenter.delegate = presenterDelegate
        interactor.news = news
        
        let router: RSSNewsRouterProtocol = RSSNewsRouter(viewController: newsViewController)
        presenter.router = router
        
        return newsViewController
        
    }

    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
