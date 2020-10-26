//
//  RSSNewsRouter.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit

class RSSNewsRouter: RSSNewsRouterProtocol {
    
    weak var viewController: RSSNewsViewController!
    
    init(viewController: RSSNewsViewController) {
        self.viewController = viewController
    }
    
}
