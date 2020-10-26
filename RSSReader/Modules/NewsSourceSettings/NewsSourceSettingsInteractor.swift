//
//  NewsSourceSettingsInteractor.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

class NewsSourceSettingsInteractor: NewsSourceSettingsInteractorProtocol {
    
    var newsSources: [String] {
        get {
            return PreferencesService.shared.sourcesValue
        }
        set {
            PreferencesService.shared.sourcesValue = newValue
        }
    }
    
    weak var presenter: NewsSourceSettingsPresenterProtocol!
    
    required init(presenter: NewsSourceSettingsPresenterProtocol) {
        self.presenter = presenter
    }
    
    func updateSynchronization() {
        SynchronizationManager.shared.startSync()
    }

}
