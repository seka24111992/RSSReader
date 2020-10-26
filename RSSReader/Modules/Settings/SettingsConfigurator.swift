//
//  SettingsConfigurator.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation
import UIKit

class SettingsConfigurator: SettingsConfiguratorProtocol {
    
    static func configure() -> UIViewController {
        guard let settingsViewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else {
            fatalError("Invalid view controller type")
        }
        
        let presenter: SettingsPresenter & SettingsPresenterProtocol = SettingsPresenter(view: settingsViewController)
        settingsViewController.presenter = presenter
        
        let interactor: SettingsInteractorProtocol = SettingsInteractor(presenter: presenter)
        presenter.interactor = interactor
        
        let router: SettingsRouterProtocol = SettingsRouter(viewController: settingsViewController)
        presenter.router = router
        
        return settingsViewController
    }
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
