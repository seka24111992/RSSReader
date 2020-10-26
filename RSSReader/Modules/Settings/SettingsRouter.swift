//
//  SettingsRouter.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit

class SettingsRouter: SettingsRouterProtocol {
    
    weak var viewController: SettingsViewController!
    
    func navigator() -> Navigator {
        return Navigator(controller: viewController)
    }
    
    init(viewController: SettingsViewController) {
        self.viewController = viewController
    }
    
    func presentActionSheet(actions: [UIAlertAction]) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for action in actions {
            actionSheetController.addAction(action)
        }
        
        if let popoverController = actionSheetController.popoverPresentationController {
            popoverController.sourceView =  self.viewController.view
            popoverController.sourceRect = CGRect(x:  self.viewController.view.bounds.midX, y:  self.viewController.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.viewController.present(actionSheetController, animated: true)
    }
    
    func presentNewsSourceSettingsViewController() {
        let newsSourceSettingsViewController = NewsSourceSettingsConfigurator.configure()
        
        pushViewController(newsSourceSettingsViewController)
    }
    
    func pushViewController(_ controller: UIViewController) {
        guard let viewController = viewController else {
            fatalError("Invalid View Protocol type")
        }
        viewController.navigationController?.pushViewController(controller, animated: true)
    }
}
