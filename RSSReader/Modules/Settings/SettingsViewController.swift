//
//  SettingsViewController.swift
//  RSSReader
//
//  Created by Сергей Гусаковский on 25.10.2020.
//  Copyright © 2020 SGU. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewProtocol {
    
    // MARK: - Identifiers
    
    private enum restorationIdentifiers: String {
        case updateIntervalView = "updateIntervalView"
        case newsSourcesView = "newsSourcesView"
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var advancedViewSwitch: UISwitch!
    @IBOutlet weak var updateIntervalView: ShadowView!
    @IBOutlet weak var updateIntervalLabel: UILabel!
    @IBOutlet weak var newsSourcesView: ShadowView!
    
    // MARK: - Properties
        
    var presenter: SettingsPresenterProtocol!
    var configurator: SettingsConfiguratorProtocol = SettingsConfigurator()

    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func setAdvancedViewSwitch(isOn: Bool) {
        advancedViewSwitch.isOn = isOn
    }
    
    func getAdvancedViewSwitch() -> Bool {
         return advancedViewSwitch.isOn
     }
    
    @IBAction func advancedViewSwitchValueChanged(_ sender: UISwitch) {
        presenter.advancedViewSwitchValueChanged()
    }
    
    // MARK: - SettingsViewProtocol
    
    @objc func viewTapped(_ sender:UITapGestureRecognizer) {
        if (sender.view!.restorationIdentifier == restorationIdentifiers.updateIntervalView.rawValue) {
            presenter.updateIntervalButtonClicked()
        } else if (sender.view!.restorationIdentifier == restorationIdentifiers.newsSourcesView.rawValue) {
            presenter.newsSourcesButtonClicked()
        }
    }
    
    func addGestureRecognizerForUpdateIntervalView() {
        let updateIntervalViewGesture = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.viewTapped(_:)))
        self.updateIntervalView.addGestureRecognizer(updateIntervalViewGesture)
    }
    
    func addGestureRecognizerForNewsSourcesView() {
        let newsSourcesViewGesture = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.viewTapped(_:)))
        self.newsSourcesView.addGestureRecognizer(newsSourcesViewGesture)
    }
    
    func showUpdateInterval() {
        switch PreferencesService.shared.updateInterval {
        case .minute:
            self.updateIntervalLabel.text = LocalizationService.shared.minute
        case .tenMinutes:
            self.updateIntervalLabel.text = LocalizationService.shared.tenMinutes
        case .thirtyMinutes:
            self.updateIntervalLabel.text = LocalizationService.shared.thirtyMinutes
        }
    }
    
}
