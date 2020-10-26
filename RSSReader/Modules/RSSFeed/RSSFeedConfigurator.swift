//
//  RSSFeedConfigurator.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/23/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import UIKit

class RSSFeedConfigurator: RSSFeedConfiguratorProtocol {
    
    func configure(with viewController: RSSFeedViewController) {
        let presenter = RSSFeedPresenter(view: viewController)
        let interactor = RSSFeedInteractor(presenter: presenter)
        let router = RSSFeedRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
}
