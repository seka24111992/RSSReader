//
//  NewsSourceSettingsConfigurator.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import UIKit

class NewsSourceSettingsConfigurator: NewsSourceSettingsConfiguratorProtocol {
    
    static func configure() -> UIViewController {
        guard let newsSourceSettingsViewController = storyboard.instantiateViewController(withIdentifier: "NewsSourceSettingsViewController") as? NewsSourceSettingsViewController else {
            fatalError("Invalid view controller type")
        }
        
        let presenter: NewsSourceSettingsPresenter & NewsSourceSettingsPresenterProtocol = NewsSourceSettingsPresenter(view: newsSourceSettingsViewController)
        newsSourceSettingsViewController.presenter = presenter
        
        let interactor: NewsSourceSettingsInteractorProtocol = NewsSourceSettingsInteractor(presenter: presenter)
        presenter.interactor = interactor
        
        let router: NewsSourceSettingsRouterProtocol = NewsSourceSettingsRouter(viewController: newsSourceSettingsViewController)
        presenter.router = router
        
        return newsSourceSettingsViewController
    }
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
