//
//  NewsSourceSettingsPresenter.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit

class NewsSourceSettingsPresenter: NSObject, NewsSourceSettingsPresenterProtocol {
    
    weak var view: NewsSourceSettingsViewProtocol!
    var interactor: NewsSourceSettingsInteractorProtocol!
    var router: NewsSourceSettingsRouterProtocol!
    
    init(view: NewsSourceSettingsViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        view.setNewsSources(interactor.newsSources)
    }
    
    func needUpdateSources(_ sources: [String]) {
        interactor.newsSources = sources
        interactor.updateSynchronization()
    }
    
}
