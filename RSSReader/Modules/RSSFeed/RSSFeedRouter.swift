//
//  RSSFeedRouter.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/23/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import UIKit

class RSSFeedRouter: RSSFeedRouterProtocol {
    
    weak var viewController: RSSFeedViewController!
    
    init(viewController: RSSFeedViewController) {
        self.viewController = viewController
    }
    
    func presentNewsViewController(with news: News) {
        let newsViewController = RSSNewsConfigurator.createNewsModule(with: news, presenterDelegate: viewController.presenter as? NewsDelegate)
        self.pushViewController(newsViewController)
    }
    
    func presentSettingsViewController() {
        let settingsViewController = SettingsConfigurator.configure()
        
        pushViewController(settingsViewController)
    }
    
    func pushViewController(_ controller: UIViewController) {
        guard let viewController = viewController else {
            fatalError("Invalid View Protocol type")
        }
        viewController.navigationController?.pushViewController(controller, animated: true)
    }
    
}
