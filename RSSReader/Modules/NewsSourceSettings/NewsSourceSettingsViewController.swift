//
//  NewsSourceSettingsViewController.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit

class NewsSourceSettingsViewController: UIViewController, NewsSourceSettingsViewProtocol {
    
    // MARK: - Outlets
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addSourceButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
        
    var presenter: NewsSourceSettingsPresenterProtocol!
    var configurator: NewsSourceSettingsConfiguratorProtocol = NewsSourceSettingsConfigurator()
    
    private var newsSources = [String]() {
        didSet {
            print(newsSources)
        }
    }
    
    private let cellReuseIdentifier = "sourcesCell"

    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func setNewsSources(_ newsSources: [String]) {
        self.newsSources = newsSources
        tableView.reloadData()
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    func addGestureRecognizerForView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func addSourceButtonTapped(_ sender: Any) {
        if textField.hasText {
            newsSources.append(textField.text!)
            textField.text = ""
            presenter.needUpdateSources(newsSources)
            tableView.reloadData()
        }
    }
    
}


extension NewsSourceSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = newsSources[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            newsSources.remove(at: indexPath.row)
            presenter.needUpdateSources(newsSources)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

extension NewsSourceSettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
