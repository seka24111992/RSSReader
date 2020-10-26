//
//  NewsSourceSettingsProtocols.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit

protocol NewsSourceSettingsViewProtocol: class {
    func setNewsSources(_ newsSources: [String])
    func addGestureRecognizerForView()
}

protocol NewsSourceSettingsInteractorProtocol: class {
    var newsSources: [String] { get set }
    func updateSynchronization()
}

protocol NewsSourceSettingsPresenterProtocol: class {
    func configureView()
    func needUpdateSources(_ sources: [String])
}

protocol NewsSourceSettingsRouterProtocol {
    
}

protocol NewsSourceSettingsConfiguratorProtocol {
    
}
