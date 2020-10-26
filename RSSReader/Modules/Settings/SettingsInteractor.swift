//
//  SettingsInteractor.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

class SettingsInteractor: SettingsInteractorProtocol {
    
    var isAdvancedViewEvailable: Bool {
        get {
            return PreferencesService.shared.advancedViewAvailable
        }
        
        set {
            PreferencesService.shared.advancedViewAvailable = newValue
        }
    }
    
    var updateInterval: UpdateInterval {
        get {
            return PreferencesService.shared.updateInterval
        }
        
        set {
            PreferencesService.shared.updateInterval = newValue
        }
    }
    
    weak var presenter: SettingsPresenterProtocol!
    
    required init(presenter: SettingsPresenterProtocol) {
        self.presenter = presenter
    }
    
    func updateSynchronization() {
        SynchronizationManager.shared.startSync()
    }
}
