//
//  RSSNewsInteractor.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import Foundation

class RSSNewsInteractor: RSSNewsInteractorProtocol {
    
    weak var presenter: RSSNewsPresenterProtocol!
    
    var news: News? = nil {
        didSet {
            print("\(news?.title) has been opened.")
        }
    }
    
    init(presenter: RSSNewsPresenterProtocol) {
        self.presenter = presenter
    }
    
}
