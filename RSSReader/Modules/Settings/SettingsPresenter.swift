//
//  SettingsPresenter.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit

class SettingsPresenter: NSObject, SettingsPresenterProtocol {
    
    weak var view: SettingsViewProtocol!
    var interactor: SettingsInteractorProtocol!
    var router: SettingsRouterProtocol!
    
    init(view: SettingsViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        view.setAdvancedViewSwitch(isOn: interactor.isAdvancedViewEvailable)
        view.addGestureRecognizerForUpdateIntervalView()
        view.addGestureRecognizerForNewsSourcesView()
        view.showUpdateInterval()
    }
    
    func advancedViewSwitchValueChanged() {
        let value = view.getAdvancedViewSwitch()
        interactor.isAdvancedViewEvailable = value
    }
    
    func updateIntervalButtonClicked() {
        var actions = [UIAlertAction]()
        actions.append(UIAlertAction(title: LocalizationService.shared.minute, style: .default, handler: { [weak self] (action) in
            self?.interactor.updateInterval = .minute
            self?.interactor.updateSynchronization()
            self?.view.showUpdateInterval()
        }))
        
        actions.append(UIAlertAction(title: LocalizationService.shared.tenMinutes, style: .default, handler: { [weak self] (action) in
            self?.interactor.updateInterval = .tenMinutes
            self?.interactor.updateSynchronization()
            self?.view.showUpdateInterval()
        }))
        
        actions.append(UIAlertAction(title: LocalizationService.shared.thirtyMinutes, style: .default, handler: { [weak self] (action) in
            self?.interactor.updateInterval = .thirtyMinutes
            self?.interactor.updateSynchronization()
            self?.view.showUpdateInterval()
        }))
        
        actions.append(UIAlertAction(title: LocalizationService.shared.cancel, style: .cancel))
        
        router.presentActionSheet(actions: actions)
    }
    
    func newsSourcesButtonClicked() {
        router.presentNewsSourceSettingsViewController()
    }
}
