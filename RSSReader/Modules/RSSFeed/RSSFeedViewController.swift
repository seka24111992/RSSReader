//
//  ViewController.swift
//  RSSReader
//
//  Created by Gusakovsky, Sergey on 10/23/20.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit
import Alamofire

class RSSFeedViewController: UIViewController, RSSFeedViewProtocol {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    
    // MARK: - Properties
    
    var presenter: RSSFeedPresenterProtocol!
    var configurator: RSSFeedConfiguratorProtocol = RSSFeedConfigurator()

    private let cellReuseIdentifier = "NewsTableViewCell"
    
    private var newsArray = [News]()
    
    private var isAdvancedViewAvailable: Bool = false
    
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        
        self.tableView.register(Nibs.shared.newsTableViewCell, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = CGFloat(TableViewConstants.estimatedRowHeight)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        NotificationCenter.default.addObserver(self, selector: #selector(synchronizationManagerDidSyncComplete), name: .SynchronizationManagerDidSyncComplete, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        NotificationCenter.default.removeObserver(self, name: .SynchronizationManagerDidSyncComplete, object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
    }
    
    func setNewsArray(_ newsArray: [News]) {
        DispatchQueue.main.async {
            self.newsArray = newsArray
            self.tableView.reloadData()
        }
    }
    
    func updateNews(_ news: News) {
        DispatchQueue.main.async {
            if let index = self.newsArray.firstIndex(of: news) {
                self.newsArray.remove(at: index)
                self.newsArray.insert(news, at: index)
                self.tableView.reloadData()
            }
        }
    }
    
    func tableViewReloadData() {
        self.tableView.reloadData()
    }
    
    func setAdvancedViewValue(_ value: Bool) {
        self.isAdvancedViewAvailable = value
    }

    @IBAction func settingsButtonTapped(_ sender: Any) {
        presenter.settingsButtonClicked()
    }
    
    @objc
    private func synchronizationManagerDidSyncComplete() {
        presenter.synchronizationManagerDidSyncComplete()
    }
    
}

extension RSSFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    struct TableViewConstants {
        static let estimatedRowHeight = 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! NewsTableViewCell
        
        cell.newsTitleLabel.text = newsArray[indexPath.row].title
        cell.newsSourceLabel.text = newsArray[indexPath.row].source
        cell.dateCreatedLabel.text = newsArray[indexPath.row].createDate.toString
        if isAdvancedViewAvailable {
            cell.newsDescriptionLabel.isHidden = false
            cell.newsDescriptionLabel.text = newsArray[indexPath.row].newsDescription
        } else {
            cell.newsDescriptionLabel.isHidden = true
            cell.newsDescriptionLabel.text = ""
        }
        
        newsArray[indexPath.row].setThumbnail(thumbnailImage: cell.newsIconImageView)
        
        cell.statusImageView.image = Images.shared.isReadIcon?.withRenderingMode(.alwaysTemplate)
        
        if newsArray[indexPath.row].isOpen {
            cell.statusImageView.tintColor = .clear
        } else {
            cell.statusImageView.tintColor = AppDelegate.sharedDelegate.appearace.greenColor
        }
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.backgroundView?.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter.didSelectNews(newsArray[indexPath.row])
    }
    
    
}

