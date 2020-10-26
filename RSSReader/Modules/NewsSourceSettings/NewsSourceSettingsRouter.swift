//
//  NewsSourceSettingsRouter.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit

class NewsSourceSettingsRouter: NewsSourceSettingsRouterProtocol {
    
    weak var viewController: NewsSourceSettingsViewController!
    
    init(viewController: NewsSourceSettingsViewController) {
        self.viewController = viewController
    }
    
}
