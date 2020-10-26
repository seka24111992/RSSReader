//
//  RSSNewsProtocols.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit

protocol RSSNewsViewProtocol: class {
    func setNewsTitle(title: String)
    func setNewsSource(_ source: String)
    func setNewsDescription(_ description: String)
    func setNews(_ news: News)
    func setLink(_ link: String)
}

protocol RSSNewsInteractorProtocol: class {
    var news: News? { get set }
}

protocol RSSNewsPresenterProtocol: class {
    var router: RSSNewsRouterProtocol! { set get }
    func configureView()
}

protocol RSSNewsRouterProtocol {
    
}

protocol RSSNewsConfiguratorProtocol {
    static func createNewsModule(with news: News, presenterDelegate: NewsDelegate?) -> UIViewController
}
