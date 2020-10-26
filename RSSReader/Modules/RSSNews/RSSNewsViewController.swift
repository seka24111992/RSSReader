//
//  RSSNewsViewController.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/24/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit

class RSSNewsViewController: UIViewController, RSSNewsViewProtocol {
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsSourceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    // MARK: - Properties
    
    var presenter: RSSNewsPresenterProtocol!
    var configurator: RSSNewsConfiguratorProtocol = RSSNewsConfigurator()
        
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func setNewsTitle(title: String) {
        DispatchQueue.main.async {
            self.newsTitleLabel.text = title
        }
    }
    
    func setNewsSource(_ source: String) {
        DispatchQueue.main.async {
            self.newsSourceLabel.text = source
        }
    }
    
    func setNewsDescription(_ description: String) {
        DispatchQueue.main.async {
            self.newsDescriptionLabel.text = description
        }
    }
    
    func setNews(_ news: News) {
        DispatchQueue.main.async {
            news.setThumbnail(thumbnailImage: self.imageView)
        }
    }

}
